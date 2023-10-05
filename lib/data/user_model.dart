import 'dart:convert';


class User {
  final String firstname;
  final String lastname;
  final String email;
  final int phone;
  final String imageUrl;

  User(
      {required this.firstname,
      required this.lastname,
      required this.email,
      required this.phone,
      required this.imageUrl});
}








UserDetailsModel userDetailsModelFromMap(String str) => UserDetailsModel.fromJson(json.decode(str));

String userDetailsModelToMap(UserDetailsModel data) => json.encode(data.toMap());

class UserDetailsModel {
    String token;
    DateTime expiration;
    List<String> roles;
    String firstName;
    String lastName;

    UserDetailsModel({
        required this.token,
        required this.expiration,
        required this.roles,
        required this.firstName,
        required this.lastName,
    });

    factory UserDetailsModel.fromJson(Map<String, dynamic> json) => UserDetailsModel(
        token: json["token"],
        expiration: DateTime.parse(json["expiration"]),
        roles: List<String>.from(json["roles"].map((x) => x)),
        firstName: json["firstName"],
        lastName: json["lastName"],
    );

    Map<String, dynamic> toMap() => {
        "token": token,
        "expiration": expiration.toIso8601String(),
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "firstName": firstName,
        "lastName": lastName,
    };
}

