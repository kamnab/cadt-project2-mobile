import 'package:flutter_appauth/flutter_appauth.dart';

class LoginModel {
  String? accessToken;
  String? refreshToken;
  String? idToken;
  String? accessTokenExpiration;

  LoginModel(
      {this.accessToken,
      this.refreshToken,
      this.idToken,
      this.accessTokenExpiration});

  // Factory constructor to convert from the authorization response
  factory LoginModel.fromAuthTokenResponse(
      AuthorizationTokenResponse response) {
    return LoginModel(
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
      idToken: response.idToken,
      accessTokenExpiration:
          response.accessTokenExpirationDateTime?.toIso8601String(),
    );
  }

  factory LoginModel.fromTokenResponse(TokenResponse response) {
    return LoginModel(
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
      idToken: response.idToken,
      accessTokenExpiration:
          response.accessTokenExpirationDateTime?.toIso8601String(),
    );
  }

  // Factory constructor for JSON deserialization
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      idToken: json['idToken'] as String,
      accessTokenExpiration: json['accessTokenExpiration'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'idToken': idToken,
        'accessTokenExpiration': accessTokenExpiration,
      };
}
