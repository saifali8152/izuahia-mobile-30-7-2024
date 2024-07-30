// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  Data data;
  String error;

  UserModel({
    required this.data,
    required this.error,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data: Data.fromJson(json["data"]),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "error": error,
      };
}

class Data {
  String userId;
  String firstName;
  String lastName;
  String email;
  String password;
  String phone;
  String profilePic;
  String defaultCurrency;
  String wallet;
  String status;
  String isNotification;
  String createdAt;
  String description;
  String summary;
  String resumeUrl;

  Data({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
    required this.profilePic,
    required this.defaultCurrency,
    required this.wallet,
    required this.status,
    required this.isNotification,
    required this.createdAt,
    required this.description,
    required this.summary,
    required this.resumeUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"] ?? "0",
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        email: json["email"] ?? "",
        password: json["password"] ?? "",
        phone: json["phone"] ?? "",
        profilePic: json["profile_pic"] ?? "",
        defaultCurrency: json["default_currency"] ?? "",
        wallet: json["wallet"] ?? "",
        status: json["status"] ?? "",
        isNotification: json["is_notification"] ?? "",
        createdAt: json["created_at"] ?? "",
        description: json["description"] ?? "",
        summary: json["summary"] ?? "",
        resumeUrl: json["resume"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
        "phone": phone,
        "profile_pic": profilePic,
        "default_currency": defaultCurrency,
        "wallet": wallet,
        "status": status,
        "is_notification": isNotification,
        "created_at": createdAt,
        "description": description,
        "summary": summary,
        "resume": resumeUrl,
      };
}
