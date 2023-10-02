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





// UserModel userDetailModelFromMap(String str) => UserModel.fromJson(json.decode(str));

// String userDetailModelToMap(UserModel data) => json.encode(data.toMap());

// class UserModel {
//     String name;
//     String email;
//     String pictureUrl;
//     String token;
//     bool isAdministrator;
//     String defaultCompetition;

//     UserModel({
//         required this.name,
//         required this.email,
//         required this.pictureUrl,
//         required this.token,
//         required this.isAdministrator,
//         required this.defaultCompetition,
//     });

//     factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//         name: json["Name"],
//         email: json["Email"],
//         pictureUrl: json["PictureUrl"],
//         token: json["token"],
//         isAdministrator: json["isAdministrator"],
//         defaultCompetition: json["defaultCompetition"],
//     );

//     Map<String, dynamic> toMap() => {
//         "Name": name,
//         "Email": email,
//         "PictureUrl": pictureUrl,
//         "token": token,
//         "isAdministrator": isAdministrator,
//         "defaultCompetition": defaultCompetition,
//     };
// }


// To parse this JSON data, do
//
//     final temperatures = temperaturesFromMap(jsonString);



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

