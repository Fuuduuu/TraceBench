class TraceBenchEvent {
  const TraceBenchEvent({
    required this.schemaVersion,
    required this.eventId,
    required this.projectId,
    required this.sequence,
    required this.createdAt,
    required this.actor,
    required this.eventType,
    required this.status,
    required this.payload,
  });

  final String schemaVersion;
  final String eventId;
  final String projectId;
  final int sequence;
  final String createdAt;
  final Map<String, dynamic> actor;
  final String eventType;
  final String status;
  final Map<String, dynamic> payload;

  factory TraceBenchEvent.fromJson(Map<String, dynamic> json) {
    return TraceBenchEvent(
      schemaVersion: json['schema_version']?.toString() ?? 'unknown',
      eventId: json['event_id']?.toString() ?? 'unknown',
      projectId: json['project_id']?.toString() ?? 'unknown',
      sequence: json['sequence'] is int ? json['sequence'] as int : 0,
      createdAt: json['created_at']?.toString() ?? '',
      actor: json['actor'] is Map
          ? Map<String, dynamic>.from(json['actor'] as Map)
          : const {},
      eventType: json['event_type']?.toString() ?? 'unknown',
      status: json['status']?.toString() ?? 'accepted',
      payload: json['payload'] is Map
          ? Map<String, dynamic>.from(json['payload'] as Map)
          : const {},
    );
  }

  Map<String, dynamic> toJson() => {
        'schema_version': schemaVersion,
        'event_id': eventId,
        'project_id': projectId,
        'sequence': sequence,
        'created_at': createdAt,
        'actor': actor,
        'event_type': eventType,
        'status': status,
        'payload': payload,
      };
}
