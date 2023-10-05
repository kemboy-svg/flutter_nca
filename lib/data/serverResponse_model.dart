import 'dart:convert';

ServerResponse temperaturesFromMap(String str) => ServerResponse.fromJson(json.decode(str));



class ServerResponse {
    String status;
    String message;

    ServerResponse({
        required this.status,
        required this.message,
    });

    factory ServerResponse.fromJson(Map<String, dynamic> json) => ServerResponse(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
    };
}
