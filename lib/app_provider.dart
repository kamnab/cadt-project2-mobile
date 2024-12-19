import 'package:cadt_project2_mobile/modules/app_theme/app_theme_logic.dart';
import 'package:cadt_project2_mobile/modules/login/login_logic.dart';
import 'package:cadt_project2_mobile/modules/tenant/tenant_logic.dart';
import 'screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget LoadingAppWithProvider() {
  return MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AppThemeLogic()),
    ChangeNotifierProvider(create: (context) => LoginLogic()),
    ChangeNotifierProvider(create: (context) => TenantLogic()),
  ], child: const LoadingScreen());
}
