
import 'dart:convert';

void main() {
  
  String jsonData = '''
  [
    {
      "id": 1,
      "ProjectName": "Project 1",
      "ImageUrl": "https://example.com/project1.jpg",
      "Coordinates": {
        "latitude": 40.7128,
        "longitude": -74.0060
      }
    },
    {
      "id": 2,
      "ProjectName": "Project 2",
      "ImageUrl": "https://example.com/project2.jpg",
      "Coordinates": {
        "latitude": 34.0522,
        "longitude": -118.2437
      }
    },
    {
      "id": 3,
      "ProjectName": "Project 3",
      "ImageUrl": "https://example.com/project3.jpg",
      "Coordinates": {
        "latitude": 51.5074,
        "longitude": -0.1278
      }
    },
    {
      "id": 4,
      "ProjectName": "Project 4",
      "ImageUrl": "https://example.com/project4.jpg",
      "Coordinates": {
        "latitude": 48.8566,
        "longitude": 2.3522
      }
    }
  ]
  ''';

  
  List<Map<String, dynamic>> projects = json.decode(jsonData);


  for (var project in projects) {
    print("Project Name: ${project['ProjectName']}");
    print("Image URL: ${project['ImageUrl']}");
    print("Coordinates: ${project['Coordinates']}");
    print("ID: ${project['id']}");
  }
}
