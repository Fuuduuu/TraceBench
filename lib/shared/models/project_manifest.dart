class ProjectManifest {
  const ProjectManifest({
    required this.projectId,
    required this.schemaVersion,
    required this.createdAt,
    required this.deviceType,
    required this.model,
    required this.symptom,
  });

  final String projectId;
  final String schemaVersion;
  final String createdAt;
  final String deviceType;
  final String model;
  final String symptom;

  factory ProjectManifest.fromJson(Map<String, dynamic> json) {
    return ProjectManifest(
      projectId: json['project_id']?.toString() ?? 'unknown_project',
      schemaVersion: json['schema_version']?.toString() ?? 'unknown',
      createdAt: json['created_at']?.toString() ?? '',
      deviceType: json['device_type']?.toString() ?? 'unknown',
      model: json['model']?.toString() ?? 'unknown',
      symptom: json['symptom']?.toString() ?? 'not_provided',
    );
  }

  Map<String, dynamic> toJson() => {
        'project_id': projectId,
        'schema_version': schemaVersion,
        'created_at': createdAt,
        'device_type': deviceType,
        'model': model,
        'symptom': symptom,
      };
}
