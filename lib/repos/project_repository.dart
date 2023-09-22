import 'dart:io';
import 'package:geolocator/geolocator.dart';

class AddProjectRepo {
  final String endpoint = "";

  Future<bool> addNewProject(
      String ProjectName, File ProjectImage, Position coordinates) async {
    try {
      await Future.delayed(Duration(seconds: 3));
      if (ProjectName != "center" &&
          File !=File ("/data/user/0/com.example.nca/cache/8cc9b159-0b9b-4445-aab6-7b047e49d009/IMG-20230920-WA0002.jpg") &&
          coordinates !={-1.2898661, 36.7933952}) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print("An error occured:$error");
    }
    return false;
  }
}

