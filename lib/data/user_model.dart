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





UserDetailsModel userDetailModelFromMap(String str) => UserDetailsModel.fromJson(json.decode(str));

String userDetailModelToMap(UserDetailsModel data) => json.encode(data.toMap());

class UserDetailsModel {
    String name;
    String email;
    String pictureUrl;
    String token;
    bool isAdministrator;
    String defaultCompetition;

    UserDetailsModel({
        required this.name,
        required this.email,
        required this.pictureUrl,
        required this.token,
        required this.isAdministrator,
        required this.defaultCompetition,
    });

    factory UserDetailsModel.fromJson(Map<String, dynamic> json) => UserDetailsModel(
        name: json["Name"],
        email: json["Email"],
        pictureUrl: json["PictureUrl"],
        token: json["token"],
        isAdministrator: json["isAdministrator"],
        defaultCompetition: json["defaultCompetition"],
    );

    Map<String, dynamic> toMap() => {
        "Name": name,
        "Email": email,
        "PictureUrl": pictureUrl,
        "token": token,
        "isAdministrator": isAdministrator,
        "defaultCompetition": defaultCompetition,
    };
}

