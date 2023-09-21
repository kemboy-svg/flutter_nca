class projects {
  final String projectName;
  final String imagePath;
  final double coordinates;

  projects(
      {required this.projectName,
      required this.imagePath,
      required this.coordinates});

  Map<String, dynamic> toJson() {
    return {
      'projectName': projectName,
      'imagePath': imagePath,
      'coordinates': coordinates,
    };
  }
}
