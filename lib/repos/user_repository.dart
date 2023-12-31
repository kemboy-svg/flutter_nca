import 'package:http/http.dart' as http;
import 'package:nca/data/serverResponse_model.dart';
import 'dart:convert';
import 'package:nca/data/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// final String endpoint = 'https://nca-qa-api.agilebiz.co.ke';
 final String endpoint = "https://localhost:7284";

class LoginResponse {
  final bool success;
  final UserDetailsModel? userDetails;
  final Object? error;

  LoginResponse({required this.success, this.userDetails, this.error});
}

class LoginRepository {
  Future<LoginResponse> loginUser(String username, String password) async {
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
        final userDetails = UserDetailsModel.fromJson(userMap);
        return LoginResponse(success: true, userDetails: userDetails);
      } else {
        final userToMap = jsonDecode(response.body) as Map<String, dynamic>;
        final serverResponse = ServerResponse.fromJson(userToMap);
        return LoginResponse(success: false, error: serverResponse);
      }
    } catch (error) {
      return LoginResponse(success: false, error: error.toString());
    }
  }
}

final storage = FlutterSecureStorage();

// Save user credentials
Future<void> saveCredentials(UserCredentials credentials) async {
  await storage.write(key: 'email', value: credentials.email);
  await storage.write(key: 'password', value: credentials.password);
}

// Retrieve user credentials
Future<UserCredentials?> getSavedCredentials() async {
  final email = await storage.read(key: 'email');
  final password = await storage.read(key: 'password');

  if (email != null && password != null) {
    return UserCredentials(email: email, password: password);
  } else {
    return null;
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

class ForgotEmailRepo {
  Future<bool> userEmail(String Email) async {
    final Map<String, dynamic> requestBody = {"Email": Email};

    final response = await http.post(
      Uri.parse('$endpoint/api/auth/SendForgotPasswordLink'),
       body: jsonEncode(requestBody),
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
    );
    if(response.statusCode==200){
      return true;
    }else{
      return false;
    }
  }
}
