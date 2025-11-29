import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? token;
  int? userId;
  String? userEmail;
  String? userNicename;
  String? userDisplayName;
  String? userRole;

  UserModel({
    this.token,
    this.userId,
    this.userEmail,
    this.userNicename,
    this.userDisplayName,
    this.userRole,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        token: json["token"],
        userId: json["user_id"] is String
            ? int.parse(json["user_id"])
            : json["user_id"],
        userEmail: json["user_email"],
        userNicename: json["user_nicename"],
        userDisplayName: json["user_display_name"],
        userRole: json["user_role"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user_id": userId,
        "user_email": userEmail,
        "user_nicename": userNicename,
        "user_display_name": userDisplayName,
        "user_role": userRole,
      };

  @override
  String toString() {
    return 'userLoginModel(token: $token, userId: $userId, userEmail: $userEmail, userNicename: $userNicename, userDisplayName: $userDisplayName, userRole: $userRole)';
  }
}
