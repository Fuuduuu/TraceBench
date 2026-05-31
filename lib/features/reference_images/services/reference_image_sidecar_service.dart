import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

class ReferenceImageRecord {
  const ReferenceImageRecord({
    required this.referenceImageId,
    required this.originalFilenameDisplay,
    required this.storedRelativePath,
    required this.mimeType,
    required this.fileSizeBytes,
    required this.importedAt,
    required this.source,
    required this.projectId,
    this.sha256,
    this.notes,
  });

  final String referenceImageId;
  final String originalFilenameDisplay;
  final String storedRelativePath;
  final String mimeType;
  final int fileSizeBytes;
  final String? sha256;
  final String importedAt;
  final String source;
  final String projectId;
  final String? notes;

  factory ReferenceImageRecord.fromJson(Map<String, dynamic> json) {
    return ReferenceImageRecord(
      referenceImageId: json['reference_image_id']?.toString() ?? '',
      originalFilenameDisplay:
          json['original_filename_display']?.toString() ?? '',
      storedRelativePath: json['stored_relative_path']?.toString() ?? '',
      mimeType: json['mime_type']?.toString() ?? 'application/octet-stream',
      fileSizeBytes: (json['file_size_bytes'] as num?)?.toInt() ?? 0,
      sha256: json['sha256']?.toString(),
      importedAt: json['imported_at']?.toString() ?? '',
      source: json['source']?.toString() ?? 'local_file_picker',
      projectId: json['project_id']?.toString() ?? '',
      notes: json['notes']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'reference_image_id': referenceImageId,
      'original_filename_display': originalFilenameDisplay,
      'stored_relative_path': storedRelativePath,
      'mime_type': mimeType,
      'file_size_bytes': fileSizeBytes,
      if (sha256 != null && sha256!.isNotEmpty) 'sha256': sha256,
      'imported_at': importedAt,
      'source': source,
      'project_id': projectId,
      if (notes != null && notes!.isNotEmpty) 'notes': notes,
    };
  }
}

class ReferenceImageLedger {
  const ReferenceImageLedger({
    required this.projectId,
    required this.images,
  });

  final String projectId;
  final List<ReferenceImageRecord> images;
}

class ImportReferenceImageResult {
  const ImportReferenceImageResult._({
    required this.isSuccess,
    this.record,
    this.errorMessage,
  });

  const ImportReferenceImageResult.success(ReferenceImageRecord record)
      : this._(isSuccess: true, record: record);

  const ImportReferenceImageResult.failure(String message)
      : this._(isSuccess: false, errorMessage: message);

  final bool isSuccess;
  final ReferenceImageRecord? record;
  final String? errorMessage;
}

class ReferenceImageSidecarService {
  const ReferenceImageSidecarService();
  static final Random _random = Random();

  static const int maxFileCount = 50;
  static const int maxFileSizeBytes = 20 * 1024 * 1024;
  static const String sidecarRootName = '.tracebench_local';
  static const String sidecarImagesDirName = 'reference_images';
  static const String sidecarLedgerFileName = 'reference_images.json';
  static const Set<String> _allowedExtensions = {
    'png',
    'jpg',
    'jpeg',
    'webp',
  };

  Future<ReferenceImageLedger> loadLedger({
    required String projectDirectory,
    required String projectId,
  }) async {
    final ledgerFile = _ledgerFile(projectDirectory);
    if (!await ledgerFile.exists()) {
      return ReferenceImageLedger(projectId: projectId, images: const []);
    }

    try {
      final decoded = jsonDecode(await ledgerFile.readAsString());
      if (decoded is! Map<String, dynamic>) {
        return ReferenceImageLedger(projectId: projectId, images: const []);
      }
      final storedProjectId = decoded['project_id']?.toString();
      if (storedProjectId != null &&
          storedProjectId.isNotEmpty &&
          storedProjectId != projectId) {
        return ReferenceImageLedger(projectId: projectId, images: const []);
      }

      final rawImages = decoded['images'];
      if (rawImages is! List) {
        return ReferenceImageLedger(projectId: projectId, images: const []);
      }
      final images = rawImages
          .whereType<Map<String, dynamic>>()
          .map(ReferenceImageRecord.fromJson)
          .where((record) =>
              record.referenceImageId.isNotEmpty &&
              record.storedRelativePath.isNotEmpty)
          .toList(growable: false);
      return ReferenceImageLedger(projectId: projectId, images: images);
    } catch (_) {
      return ReferenceImageLedger(projectId: projectId, images: const []);
    }
  }

  Future<ImportReferenceImageResult> importFromLocalFile({
    required String projectDirectory,
    required String projectId,
    required String sourceFilePath,
  }) async {
    final sourceFile = File(sourceFilePath);
    if (!await sourceFile.exists()) {
      return const ImportReferenceImageResult.failure(
        'Selected file was not found.',
      );
    }

    final extension = _extension(sourceFile.path);
    if (!_allowedExtensions.contains(extension)) {
      return const ImportReferenceImageResult.failure(
        'Unsupported file type. Use png, jpg, jpeg, or webp.',
      );
    }

    final sourceStat = await sourceFile.stat();
    if (sourceStat.size <= 0) {
      return const ImportReferenceImageResult.failure(
        'Selected file is empty.',
      );
    }
    if (sourceStat.size > maxFileSizeBytes) {
      return ImportReferenceImageResult.failure(
        'File is too large. Max size is ${maxFileSizeBytes ~/ (1024 * 1024)} MB.',
      );
    }

    final ledger = await loadLedger(
      projectDirectory: projectDirectory,
      projectId: projectId,
    );
    if (ledger.images.length >= maxFileCount) {
      return ImportReferenceImageResult.failure(
        'Reference image limit reached ($maxFileCount).',
      );
    }

    final referenceImageId = _generateReferenceImageId();
    final internalFilename = '$referenceImageId.$extension';
    final destinationFile =
        _imagesDirectory(projectDirectory).absolute.uri.resolve(internalFilename);
    final destinationPath = File.fromUri(destinationFile);

    await _imagesDirectory(projectDirectory).create(recursive: true);
    await sourceFile.copy(destinationPath.path);

    String? sha256;
    try {
      final bytes = await destinationPath.readAsBytes();
      sha256 = _sha256Hex(bytes);
    } catch (_) {
      sha256 = null;
    }

    final record = ReferenceImageRecord(
      referenceImageId: referenceImageId,
      originalFilenameDisplay: _basename(sourceFile.path),
      storedRelativePath:
          '$sidecarRootName/$sidecarImagesDirName/$internalFilename',
      mimeType: _mimeTypeForExtension(extension),
      fileSizeBytes: sourceStat.size,
      sha256: sha256,
      importedAt: DateTime.now().toUtc().toIso8601String(),
      source: 'local_file_picker',
      projectId: projectId,
    );

    final updated = [
      ...ledger.images,
      record,
    ];
    await _writeLedger(
      projectDirectory: projectDirectory,
      projectId: projectId,
      records: updated,
    );

    return ImportReferenceImageResult.success(record);
  }

  File resolveStoredImageFile({
    required String projectDirectory,
    required ReferenceImageRecord record,
  }) {
    final normalized = record.storedRelativePath.replaceAll('/', Platform.pathSeparator);
    final fullPath = _joinPath(projectDirectory, normalized);
    return File(fullPath);
  }

  File _ledgerFile(String projectDirectory) {
    final path = _joinPath(
      projectDirectory,
      '$sidecarRootName${Platform.pathSeparator}$sidecarLedgerFileName',
    );
    return File(path);
  }

  Directory _imagesDirectory(String projectDirectory) {
    return Directory(
      _joinPath(
        projectDirectory,
        '$sidecarRootName${Platform.pathSeparator}$sidecarImagesDirName',
      ),
    );
  }

  Future<void> _writeLedger({
    required String projectDirectory,
    required String projectId,
    required List<ReferenceImageRecord> records,
  }) async {
    final file = _ledgerFile(projectDirectory);
    await file.parent.create(recursive: true);
    final payload = <String, dynamic>{
      'schema': 'reference_images_sidecar_v1',
      'project_id': projectId,
      'images': records.map((record) => record.toJson()).toList(growable: false),
    };
    final encoded = const JsonEncoder.withIndent('  ').convert(payload);
    await file.writeAsString('$encoded\n');
  }

  static String _joinPath(String base, String child) {
    if (base.endsWith('/') || base.endsWith('\\')) {
      return '$base$child';
    }
    return '$base${Platform.pathSeparator}$child';
  }

  static String _extension(String path) {
    final name = _basename(path);
    final dot = name.lastIndexOf('.');
    if (dot == -1 || dot == name.length - 1) {
      return '';
    }
    return name.substring(dot + 1).toLowerCase();
  }

  static String _basename(String path) {
    final normalized = path.replaceAll('\\', '/');
    final index = normalized.lastIndexOf('/');
    if (index == -1) {
      return normalized;
    }
    return normalized.substring(index + 1);
  }

  static String _mimeTypeForExtension(String extension) {
    switch (extension) {
      case 'png':
        return 'image/png';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'webp':
        return 'image/webp';
      default:
        return 'application/octet-stream';
    }
  }

  static String _generateReferenceImageId() {
    final timestamp = DateTime.now().toUtc().millisecondsSinceEpoch;
    final random = _random.nextInt(0xFFFFFF).toRadixString(16).padLeft(6, '0');
    return 'refimg_${timestamp}_$random';
  }

  static int _rotr(int value, int shift) {
    final normalized = value & 0xFFFFFFFF;
    return ((normalized >> shift) | (normalized << (32 - shift))) & 0xFFFFFFFF;
  }

  static String _sha256Hex(List<int> input) {
    const k = <int>[
      0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1,
      0x923f82a4, 0xab1c5ed5, 0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
      0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174, 0xe49b69c1, 0xefbe4786,
      0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
      0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147,
      0x06ca6351, 0x14292967, 0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
      0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85, 0xa2bfe8a1, 0xa81a664b,
      0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
      0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a,
      0x5b9cca4f, 0x682e6ff3, 0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
      0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
    ];

    final bytes = Uint8List.fromList(input);
    final bitLength = bytes.length * 8;
    final padded = BytesBuilder(copy: false);
    padded.add(bytes);
    padded.add([0x80]);
    while ((padded.length + 8) % 64 != 0) {
      padded.add([0]);
    }
    final lengthBytes = ByteData(8)..setUint64(0, bitLength);
    padded.add(lengthBytes.buffer.asUint8List());
    final data = padded.toBytes();

    var h0 = 0x6a09e667;
    var h1 = 0xbb67ae85;
    var h2 = 0x3c6ef372;
    var h3 = 0xa54ff53a;
    var h4 = 0x510e527f;
    var h5 = 0x9b05688c;
    var h6 = 0x1f83d9ab;
    var h7 = 0x5be0cd19;

    for (var offset = 0; offset < data.length; offset += 64) {
      final w = List<int>.filled(64, 0);
      final chunk = ByteData.sublistView(data, offset, offset + 64);
      for (var i = 0; i < 16; i++) {
        w[i] = chunk.getUint32(i * 4);
      }
      for (var i = 16; i < 64; i++) {
        final s0 = _rotr(w[i - 15], 7) ^ _rotr(w[i - 15], 18) ^ (w[i - 15] >> 3);
        final s1 = _rotr(w[i - 2], 17) ^ _rotr(w[i - 2], 19) ^ (w[i - 2] >> 10);
        w[i] = (w[i - 16] + s0 + w[i - 7] + s1) & 0xFFFFFFFF;
      }

      var a = h0;
      var b = h1;
      var c = h2;
      var d = h3;
      var e = h4;
      var f = h5;
      var g = h6;
      var h = h7;

      for (var i = 0; i < 64; i++) {
        final s1 = _rotr(e, 6) ^ _rotr(e, 11) ^ _rotr(e, 25);
        final ch = (e & f) ^ ((~e) & g);
        final temp1 = (h + s1 + ch + k[i] + w[i]) & 0xFFFFFFFF;
        final s0 = _rotr(a, 2) ^ _rotr(a, 13) ^ _rotr(a, 22);
        final maj = (a & b) ^ (a & c) ^ (b & c);
        final temp2 = (s0 + maj) & 0xFFFFFFFF;

        h = g;
        g = f;
        f = e;
        e = (d + temp1) & 0xFFFFFFFF;
        d = c;
        c = b;
        b = a;
        a = (temp1 + temp2) & 0xFFFFFFFF;
      }

      h0 = (h0 + a) & 0xFFFFFFFF;
      h1 = (h1 + b) & 0xFFFFFFFF;
      h2 = (h2 + c) & 0xFFFFFFFF;
      h3 = (h3 + d) & 0xFFFFFFFF;
      h4 = (h4 + e) & 0xFFFFFFFF;
      h5 = (h5 + f) & 0xFFFFFFFF;
      h6 = (h6 + g) & 0xFFFFFFFF;
      h7 = (h7 + h) & 0xFFFFFFFF;
    }

    final digest = [h0, h1, h2, h3, h4, h5, h6, h7];
    return digest.map((word) => word.toRadixString(16).padLeft(8, '0')).join();
  }
}
