import 'package:cadt_project2_mobile/modules/login/login_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final loading = context.watch<LoginLogic>().loading;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Classroom Learning'),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Visibility(
                visible: loading,
                child: const LinearProgressIndicator(),
              ),
              const SizedBox(height: 8),
              Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: const Text('Sign in'),
                    onPressed: () => context.read<LoginLogic>().signIn(),
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
