import 'package:cadt_project2_mobile/modules/login/login_screen.dart';
import 'package:cadt_project2_mobile/modules/tenant/tenant_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../modules/login/login_logic.dart';
import '../modules/tenant/tenant_logic.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _currentIndex = 0;
  bool _hasFetchedTenantData = false;

  @override
  void initState() {
    super.initState();

    // Trigger tenant data fetch after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final loginLogic = context.read<LoginLogic>();
      if (loginLogic.authData?.idToken != null && !_hasFetchedTenantData) {
        _fetchTenantData(context);
        _hasFetchedTenantData = true; // Ensure this runs only once
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginLogic>(
      builder: (context, loginLogic, child) {
        bool isLogin = loginLogic.authData?.idToken != null;

        return Scaffold(
          appBar: isLogin
              ? AppBar(
                  title: const Text('Classroom Learning App'),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.logout),
                      onPressed: isLogin
                          ? () async {
                              await context.read<LoginLogic>().endSession();
                            }
                          : null,
                    ),
                  ],
                )
              : null,
          body: _buildBody(isLogin),
          bottomNavigationBar:
              isLogin ? _buildBottom() : null, // Only show when logged in
        );
      },
    );
  }

  Widget _buildBody(bool isLogin) {
    if (!isLogin) {
      return const LoginScreen();
    }

    // Display the actual content once logged in
    return IndexedStack(
      index: _currentIndex,
      children: const [
        TenantScreen(),
        Center(child: Text('Search')),
        Center(child: Text('Menu')),
      ],
    );
  }

  void _fetchTenantData(BuildContext context) {
    final tenantLogic = context.read<TenantLogic>();
    final authData = context.read<LoginLogic>().authData;

    if (authData?.accessToken != null) {
      tenantLogic.fetch(authData!.accessToken);
    }
  }

  Widget _buildBottom() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "Menu"),
      ],
    );
  }
}
