import 'dart:convert';

class AuthTwilio {
  AuthTwilio({
    required this.token,
  });

  String token;

  factory AuthTwilio.fromJson(String str) =>
      AuthTwilio.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthTwilio.fromMap(Map<String, dynamic> json) => AuthTwilio(
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "token": token,
      };
}
