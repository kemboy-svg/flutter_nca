class ProjectModel {
  final String projectId;
  final String projectName;
  final String coordinates; // Since the coordinates are given as a formatted string
  final dynamic picture; // Keeping this dynamic since it's null in the given sample
  final DateTime createdOn;

  ProjectModel({
    required this.projectId,
    required this.projectName,
    required this.coordinates,
    required this.picture,
    required this.createdOn,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      projectId: json['projectId'],
      projectName: json['projectName'],
      coordinates: json['coordinates'],
      picture: json['picture'],
      createdOn: DateTime.parse(json['createdOn']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'projectName': projectName,
      'coordinates': coordinates,
      'picture': picture,
      'createdOn': createdOn.toIso8601String(),
    };
  }
}
