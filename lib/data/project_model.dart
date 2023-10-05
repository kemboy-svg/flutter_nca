import 'dart:convert';

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




ProjectDetailmodel projectDetailmodelFromMap(String str) => ProjectDetailmodel.fromJson(json.decode(str));

// String projectDetailmodelToMap(ProjectDetailmodel data) => json.encode(data.toMap());

class ProjectDetailmodel {
    String projectId;
    String projectName;
    String coordinates;
    dynamic picture;
    String ownerId;
    dynamic ownedBy;
    DateTime createdOn;

    ProjectDetailmodel({
        required this.projectId,
        required this.projectName,
        required this.coordinates,
        required this.picture,
        required this.ownerId,
        required this.ownedBy,
        required this.createdOn,
    });

    factory ProjectDetailmodel.fromJson(Map<String, dynamic> json) => ProjectDetailmodel(
        projectId: json["projectId"],
        projectName: json["projectName"],
        coordinates: json["coordinates"],
        picture: json["picture"],
        ownerId: json["ownerId"],
        ownedBy: json["ownedBy"],
        createdOn: DateTime.parse(json["createdOn"]),
    );

    Map<String, dynamic> toMap() => {
        "projectId": projectId,
        "projectName": projectName,
        "coordinates": coordinates,
        "picture": picture,
        "ownerId": ownerId,
        "ownedBy": ownedBy,
        "createdOn": createdOn.toIso8601String(),
    };
}

// To parse this JSON data, do
//
//     final projectDocumentsModel = projectDocumentsModelFromMap(jsonString);



ProjectDocumentsModel projectDocumentsModelFromMap(String str) => ProjectDocumentsModel.fromJson(json.decode(str).map((x) => ProjectDocumentsModel.fromJson(x)));

// String projectDocumentsModelToMap(List<ProjectDocumentsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ProjectDocumentsModel {
    String documentId;
    String documentType;
    String fileName;
    String projectId;
    dynamic project;

    ProjectDocumentsModel({
        required this.documentId,
        required this.documentType,
        required this.fileName,
        required this.projectId,
        required this.project,
    });

    factory ProjectDocumentsModel.fromJson(Map<String, dynamic> json) => ProjectDocumentsModel(
        documentId: json["documentId"],
        documentType: json["documentType"],
        fileName: json["fileName"],
        projectId: json["projectId"],
        project: json["project"],
    );

    Map<String, dynamic> toMap() => {
        "documentId": documentId,
        "documentType": documentType,
        "fileName": fileName,
        "projectId": projectId,
        "project": project,
    };
}
