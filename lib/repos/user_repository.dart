import 'package:http/http.dart' as http;
import 'package:nca/data/serverResponse_model.dart';
import 'dart:convert';
import 'package:nca/data/user_model.dart';

//  final String endpoint = 'https://nca-qa-api.agilebiz.co.ke';
 final String endpoint = "https://localhost:7284";

class LoginRepository {
  
  Future<UserDetailsModel?> loginUser(String username, String password) async {
    try {
      final Map<String, dynamic> requestBody = {
        "email": username,
        "password": password,
      };
      print(requestBody);

      final response = await http.post(
        Uri.parse('$endpoint/api/auth/login'),
        body: jsonEncode(requestBody),
        headers: {
           "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
      );

      if (response.statusCode == 200) {
        
        final userMap = jsonDecode(response.body) as Map<String, dynamic>;
        return UserDetailsModel.fromJson(userMap);
      } else {
        print(response.reasonPhrase);
        throw Exception(response.reasonPhrase);
      
      }
      
    } catch (e,stacktrace) {
      print("stackTrace${stacktrace}");
      print('Error while logging in: $e');
      return null;
    }
  }
}



class SignUpRepo {
  Future<Object> signupUser(
    String firstname,
    String lastname,
    String email,
    String phone,
    String password,
    String confPassword,
  ) async {
    try {
      final Map<String, dynamic> requestBody = {
        "firstName": firstname,
        "lastName": lastname,
        "email": email,
        "phoneNo": phone,
        "password": password,
        "confirmPassword": confPassword,
      };

      final response = await http.post(
        Uri.parse('$endpoint/api/auth/reg-client'),
        body: jsonEncode(requestBody),
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {

         final userToMap = jsonDecode(response.body) as Map<String, dynamic>;
      
        return ServerResponse.fromJson(userToMap);

  
      }
    } catch (error, stacktrace) {
      print("stackTrace${stacktrace}");
      print('Error while signing up: $error');
      return false;
    }
  }
}
