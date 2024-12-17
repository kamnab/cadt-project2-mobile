import 'package:cadt_project2_mobile/modules/login/login_logic.dart';

import 'screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget LoadingAppWithProvider() {
  return MultiProvider(
    providers: [
      //ChangeNotifierProvider(create: (context) => LocalThemeLogic()),
      ChangeNotifierProvider(create: (context) => LoginLogic()),
      //ChangeNotifierProvider(create: (context) => SearchProductLogic()),
    ],
    child: const LoadingScreen(),
  );
}
