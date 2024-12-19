import 'package:cadt_project2_mobile/modules/app_theme/app_theme_logic.dart';
import 'package:cadt_project2_mobile/modules/login/login_logic.dart';
import 'package:cadt_project2_mobile/modules/tenant/tenant_logic.dart';
import 'package:cadt_project2_mobile/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'splash_screen.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  Future<void> readLogics(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));
    //await context.read<AppThemeLogic>().readTheme();
    final authData = await context.read<LoginLogic>().authData;
    await context.read<TenantLogic>().fetch(authData?.accessToken);
  }

  @override
  Widget build(BuildContext context) {
    int themeIndex = context.watch<AppThemeLogic>().themeIndex;

    return FutureBuilder<void>(
      future: readLogics(context),
      builder: (context, snapshot) {
        final isDone = snapshot.connectionState == ConnectionState.done;

        return MaterialApp(
          home: isDone ? const LandingScreen() : const SplashScreen(),
          themeMode: themeIndex == 0
              ? ThemeMode.light
              : themeIndex == 1
                  ? ThemeMode.dark
                  : ThemeMode.system,
          theme: MyTheme.lightTheme,
          darkTheme: MyTheme.darkTheme,
        );
      },
    );
  }
}

class MyTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        //type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.pink,
        unselectedItemColor: const Color.fromARGB(255, 55, 55, 55),
      ),
      appBarTheme: AppBarTheme(
        color: const Color.fromARGB(149, 197, 130, 88),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.white60,
      ),
      appBarTheme: AppBarTheme(
        color: Colors.blueGrey[900],
      ),
    );
  }
}
