import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_logic.dart';

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
              const SizedBox(height: 10),
              Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: !loading
                        ? () => context.read<LoginLogic>().signIn()
                        : null,
                    child: const Text('Sign in'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      'An engaging space to collaborate with friends—empower your learning journey through shared discussions on projects, lessons, homework, and more!')
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
