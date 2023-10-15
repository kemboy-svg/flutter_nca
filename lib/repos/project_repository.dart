import 'dart:convert';
import 'dart:io';
import 'package:nca/data/project_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';



   final String endpoint = "https://nca-qa-api.agilebiz.co.ke";
  //  final String endpoint = "https://localhost:7284";
 
class AddProjectRepo {
 
  Future<bool> addNewProject(
    String ProjectName,
    String coordinatesString,
    String token
    
    //  File ProjectImage,
  ) async {
    try {
     final Map<String, dynamic>requestBody ={
      "ProjectName": ProjectName,
      "Coordinates": coordinatesString,

     };
     

     final response =await http.post(Uri.parse('$endpoint/api/project/createProj'),
     body: jsonEncode(requestBody),
        headers: {
           "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode==200){
        return true;
        
      }

      else{
        print('This is some error ${response.body}');
        // print('This is some error ${response.reasonPhrase}');
        print('status code: ${response.statusCode}');
        print('This is some error ${response.toString()}');
        
        return false;
      }


    } catch (error) {

      print("An error occured:$error");
    }
    return false;
  }
}






class UserProjectsRepo {

  Future<List<ProjectModel>> getProjects( String token) async {
   
    Response response = await get(Uri.parse('${endpoint}/api/project/myProjects'),
    headers: {
           "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization': 'Bearer $token',
        },
    
    );

    if (response.statusCode == 200) {
      // print('API RESPONSE: ${response.body}');

      final List<dynamic> result = jsonDecode(response.body);

      
      return result.map(((e) => ProjectModel.fromJson(e))).toList();
    }
    
    else {
      print('Error 1${response.reasonPhrase}');
      throw Exception(response.reasonPhrase);
    }
  }
}


class DeleteProjectRepo {
  Future<bool> deleteProject(String projectId,String token) async {
    try {
      final response =await http.delete(Uri.parse('$endpoint/api/project/delProj/$projectId'),
       headers: {
           "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization': 'Bearer $token',
        },
      );

      print(('$endpoint/api/project/delProj/$projectId'));

      if (response==200){
        return true;
      }
      else{
        return false;
      }
    } catch (e) {
      print('error${e.toString()}');
      return false;
      
    }
  }
  
}


class ProjectImageRepo {
  Future<bool> updateImage(String projectId, String token, File imageFile) async {
    var uri = Uri.parse('$endpoint/api/project/updtProjDp');
   
    var request = http.MultipartRequest('PATCH', uri)
      ..headers.addAll({
        "Authorization": 'Bearer $token',
      });

    
    request.fields['ProjectId'] = projectId;

    request.files.add(await http.MultipartFile.fromPath(
      'Picture', 
      imageFile.path,
      contentType: MediaType('image', 'jpeg'), 
    ));

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        return true;
      } else {
        print("This response${response.statusCode}");
        print("This response${response.reasonPhrase}");
        return false;
      }
    } catch (e) {
      print('This is file error ${e.toString()}');
      return false;
    }
  }
}

class ProjectDetailsRepo{
  Future <ProjectDetailmodel?> getProjectDetails(String projectId,String token) async{
   try {
     Response response = await http.get(Uri.parse('${endpoint}/api/project/getProjectdetails/${projectId}'),
    headers: {
           "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization': 'Bearer $token',
        },
    );

    if (response.statusCode ==200){
      final result =jsonDecode(response.body) as Map<String,dynamic>;
      return ProjectDetailmodel.fromJson(result);
    }
    else {
      print(response.reasonPhrase);
        throw Exception(response.reasonPhrase);
    }
     
   } catch (e) {
    //  print("stackTrace${stacktrace}");
      print('Error while logging in: $e');
      return null;
   }
   
  }
}

class ProjectsDocumentsRepo{
  Future<ProjectDocumentsModel?> getProjectDocuments(String projectId,String token)async{
    try {
      Response response =await http.get(Uri.parse('${endpoint}/api/project/getProjectdocuments/${projectId}'),
      headers: {
           "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization': 'Bearer $token',
        },
        );

        if (response == 200){
          final result=jsonDecode(response.body) as Map<String, dynamic>;
          return ProjectDocumentsModel.fromJson(result);
        }
        else {
          print("response${response.statusCode}");
        }
        
    } catch (e) {
      
    }
    return null;
  }
}
