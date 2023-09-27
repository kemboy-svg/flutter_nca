import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nca/data/user_model.dart';

class LoginRepository {
  String endpoint = 'https://trading.agilebiz.co.ke/api/Authentication/login';
  Future<UserDetailsModel?> loginUser(String username, String password) async {
    try {
      final Map<String, dynamic> requestBody = {
        "Email": username,
        "password": password,
      };
      print(requestBody);

      final response = await http.post(
        Uri.parse(endpoint),
        body: jsonEncode(requestBody),
        headers: {
          //  "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          // 'Accept': '*/*'
        },
      );

      if (response.statusCode == 200) {
        
        final userMap = jsonDecode(response.body) as Map<String, dynamic>;
        return UserDetailsModel.fromJson(userMap);
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (error) {
      print('Error while logging in: $error');
      return null;
    }
  }
}

// await Future.delayed(Duration(seconds: 2));
// if (username == "admin" && password == "password") {
//   return true;
// } else {
//   return false;
// }

class SignUpRepo {
  final String endpoint = 'https://localhost:7150/api/Auth/Register';

  Future<bool> signupUser(
    String firstname,
    String lastname,
    String email,
    String phone,
    String password,
  ) async {
    try {
      final Map<String, dynamic> requestBody = {
        'firstName': firstname,
        'lastName': lastname,
        'email': email,
        'phoneNumber': phone,
        'password': password,
      };
      print(requestBody);

      final response = await http.post(
        Uri.parse(endpoint),
        body: jsonEncode(requestBody),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Registration failed with status code: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print('Error while signing up: $error');
      return false;
    }
  }
}
