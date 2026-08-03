class ProjectManifest {
  const ProjectManifest({
    required this.projectId,
    required this.schemaVersion,
    required this.createdAt,
    this.projectName,
    this.deviceName,
    this.additionalInfo,
    required this.deviceType,
    this.manufacturer,
    required this.model,
    this.revision,
    required this.symptom,
  });

  final String projectId;
  final String schemaVersion;
  final String createdAt;
  final String? projectName;
  final String? deviceName;
  final String? additionalInfo;
  final String deviceType;
  final String? manufacturer;
  final String model;
  final String? revision;
  final String symptom;

  factory ProjectManifest.fromJson(Map<String, dynamic> json) {
    return ProjectManifest(
      projectId: json['project_id']?.toString() ?? 'unknown_project',
      schemaVersion: json['schema_version']?.toString() ?? 'unknown',
      createdAt: json['created_at']?.toString() ?? '',
      projectName: json['project_name']?.toString(),
      deviceName: json['device_name']?.toString(),
      additionalInfo: json['additional_info']?.toString(),
      deviceType: json['device_type']?.toString() ?? 'unknown',
      manufacturer: json['manufacturer']?.toString(),
      model: json['model']?.toString() ?? 'unknown',
      revision: json['revision']?.toString(),
      symptom: json['symptom']?.toString() ?? 'not_provided',
    );
  }

  Map<String, dynamic> toJson() => {
        'project_id': projectId,
        'schema_version': schemaVersion,
        'created_at': createdAt,
        if (projectName != null) 'project_name': projectName,
        if (deviceName != null) 'device_name': deviceName,
        if (additionalInfo != null) 'additional_info': additionalInfo,
        'device_type': deviceType,
        if (manufacturer != null) 'manufacturer': manufacturer,
        'model': model,
        if (revision != null) 'revision': revision,
        'symptom': symptom,
      };
}
