import 'package:cadt_project2_mobile/modules/login/login_logic.dart';
import 'package:cadt_project2_mobile/modules/login/login_screen.dart';
import 'package:cadt_project2_mobile/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'splash_screen.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  Future<void> readLogics(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    //await context.read<LocalThemeLogic>().readTheme();
    //await context.read<LoginLogic>().signIn();
  }

  @override
  Widget build(BuildContext context) {
    final authData = context.watch<LoginLogic>().authData;
    bool isLogin = authData?.idToken != null;

    return FutureBuilder<void>(
      future: readLogics(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return isLogin ? LandingScreen() : LoginScreen();
        } else {
          return SplashScreen();
        }
      },
    );
  }
}
