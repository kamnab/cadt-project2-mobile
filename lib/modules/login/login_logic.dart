import 'package:cadt_project2_mobile/models/login_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io' show Platform;

class LoginLogic extends ChangeNotifier {
  final String _clientId = 'cadt-project2-mobile';
  final String _redirectUrl = Platform.isAndroid
      ? 'dev.codemie.cadt_project2_mobile:/callback'
      : 'dev.codemie.cadt-project2-mobile:/callback';
  final String _issuer = 'https://account.codemie.dev'; // Your auth server URL
  final List<String> _scopes = [
    'openid',
    'profile',
    'email',
    'offline_access',
    'fapi'
  ];

  String? _error;
  String? get error => _error;

  LoginModel? _authResponse;
  LoginModel? get authData => _authResponse;

  bool _isBusy = false;
  bool get loading => _isBusy;

  final FlutterAppAuth _appAuth = const FlutterAppAuth();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  final String _postLogoutRedirectUrl = Platform.isAndroid
      ? 'dev.codemie.cadt_project2_mobile:/'
      : 'dev.codemie.cadt-project2-mobile:/';

  final AuthorizationServiceConfiguration _serviceConfiguration =
      const AuthorizationServiceConfiguration(
    authorizationEndpoint: 'https://account.codemie.dev/connect/authorize',
    tokenEndpoint: 'https://account.codemie.dev/connect/token',
    endSessionEndpoint: 'https://account.codemie.dev/connect/logout',
  );

  Future<void> endSession(
      {ExternalUserAgent externalUserAgent =
          ExternalUserAgent.ephemeralAsWebAuthenticationSession}) async {
    try {
      _setBusyState();
      await _appAuth.endSession(EndSessionRequest(
          idTokenHint: _authResponse?.idToken,
          postLogoutRedirectUrl: _postLogoutRedirectUrl,
          serviceConfiguration: _serviceConfiguration,
          externalUserAgent: externalUserAgent));
      _clearSessionInfo();
    } catch (e) {
      _handleError(e);
    } finally {
      _clearBusyState();
    }
  }

  void _clearSessionInfo() {
    authData?.accessToken = null;
    authData?.idToken = null;
    authData?.refreshToken = null;
    authData?.accessTokenExpiration = null;

    notifyListeners();
  }

  Future<void> refresh() async {
    try {
      _setBusyState();
      final TokenResponse result = await _appAuth.token(TokenRequest(
          _clientId, _redirectUrl,
          refreshToken: authData?.refreshToken,
          issuer: _issuer,
          scopes: _scopes));

      _processTokenResponse(result);
      //await _testApi(result);
    } catch (e) {
      _handleError(e);
    } finally {
      _clearBusyState();
    }
  }

  Future<void> signIn(
      {ExternalUserAgent externalUserAgent =
          ExternalUserAgent.ephemeralAsWebAuthenticationSession}) async {
    try {
      _setBusyState();

      /*
        This shows that we can also explicitly specify the endpoints rather than
        getting from the details from the discovery document.
      */
      final AuthorizationTokenResponse result =
          await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(_clientId, _redirectUrl,
            serviceConfiguration: _serviceConfiguration,
            scopes: _scopes,
            externalUserAgent: externalUserAgent),
      );

      _processAuthTokenResponse(result);
    } catch (e) {
      _handleError(e);
    } finally {
      _clearBusyState();
    }
  }

  void _handleError(Object e) {
    if (e is FlutterAppAuthUserCancelledException) {
      _error = 'The user cancelled the flow!';
    } else if (e is FlutterAppAuthPlatformException) {
      _error = e.platformErrorDetails.toString();
    } else if (e is PlatformException) {
      _error = 'Error\n\nCode: ${e.code}\nMessage: ${e.message}\n'
          'Details: ${e.details}';
    } else {
      _error = 'Error: $e';
    }
    notifyListeners();
  }

  void _clearBusyState() {
    _isBusy = false;
    notifyListeners();
  }

  void _setBusyState() {
    _error = '';
    _isBusy = true;
    notifyListeners();
  }

  void _processAuthTokenResponse(AuthorizationTokenResponse response) {
    _authResponse = LoginModel.fromAuthTokenResponse(response);
    notifyListeners();
  }

  void _processTokenResponse(TokenResponse response) {
    _authResponse = LoginModel.fromTokenResponse(response);
    notifyListeners();
  }
}
