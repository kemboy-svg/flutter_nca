import 'dart:convert';

List<ProjectModel> projectsFromMap(String str) => List<ProjectModel>.from(
      json.decode(str).map(
            (x) => ProjectModel.fromJson(x),
          ),
    );

class ProjectModel {
  int id;
  String projectName;
  String imageUrl;
  Coordinates coordinates;

  ProjectModel({
    required this.id,
    required this.projectName,
    required this.imageUrl,
    required this.coordinates,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        id: json["id"],
        projectName: json["ProjectName"],
        imageUrl: json["ImageUrl"],
        coordinates: Coordinates.fromMap(json["Coordinates"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "ProjectName": projectName,
        "ImageUrl": imageUrl,
        "Coordinates": coordinates.toMap(),
      };
}

class Coordinates {
  double latitude;
  double longitude;

  Coordinates({
    required this.latitude,
    required this.longitude,
  });

  factory Coordinates.fromMap(Map<String, dynamic> json) => Coordinates(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
