import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io' show Platform;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter OAuth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthPage(),
    );
  }
}

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final FlutterAppAuth appAuth = FlutterAppAuth();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  String? _accessToken;
  String? _refreshToken;

  // OAuth 2.0 Configuration
  final String _clientId = 'cadt-project2-mobile';
  final String _redirectUrl = Platform.isAndroid
      ? 'dev.codemie.cadt_project2_mobile:/callback'
      : 'dev.codemie.cadt-project2-mobile:/callback';
  final String _issuer = 'https://account.codemie.dev'; // Your auth server URL
  final List<String> _scopes = ['openid', 'profile', 'email'];

  Future<void> _login() async {
    try {
      final AuthorizationTokenResponse? result =
          await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          _clientId,
          _redirectUrl,
          issuer: _issuer,
          scopes: _scopes,
          promptValues: ['login'], // Forces re-authentication
        ),
      );

      if (result != null) {
        _accessToken = result.accessToken;
        _refreshToken = result.refreshToken;

        // Store refresh token securely
        await secureStorage.write(key: 'refresh_token', value: _refreshToken);

        setState(() {
          // Update UI with access token
        });
      }
    } catch (e) {
      print('Login error: $e');
    }
  }

  Future<void> _refreshAccessToken() async {
    try {
      final String? storedRefreshToken =
          await secureStorage.read(key: 'refresh_token');
      if (storedRefreshToken == null) {
        print('No stored refresh token');
        return;
      }

      final TokenResponse? result = await appAuth.token(
        TokenRequest(
          _clientId,
          _redirectUrl,
          issuer: _issuer,
          refreshToken: storedRefreshToken,
        ),
      );

      if (result != null) {
        _accessToken = result.accessToken;
        _refreshToken = result.refreshToken;

        // Store updated refresh token
        await secureStorage.write(key: 'refresh_token', value: _refreshToken);

        setState(() {
          // Update UI with new access token
        });
      }
    } catch (e) {
      print('Token refresh error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OAuth 2.0 Authorization Code Flow'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _login,
              child: Text('Login with OAuth 2.0'),
            ),
            ElevatedButton(
              onPressed: _refreshAccessToken,
              child: Text('Refresh Token'),
            ),
            if (_accessToken != null)
              Text(
                'Access Token: $_accessToken',
                style: TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
