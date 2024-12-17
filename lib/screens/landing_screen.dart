import 'package:cadt_project2_mobile/screens/home_screen.dart';
import 'package:cadt_project2_mobile/modules/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modules/login/login_logic.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    final authData = context.watch<LoginLogic>().authData;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.logout), // Logout icon
              onPressed: authData?.idToken != null
                  ? () async {
                      await context.read<LoginLogic>().endSession();
                    }
                  : null,
            ),
          ],
        ),
        body: _buildBody(),
        bottomNavigationBar: _buildBottom(),
      ),
    );
  }

  Widget _buildBody() {
    return IndexedStack(
      index: _currentIndex,
      children: [
        HomeScreen()
        //LocalProductScreen(),
        //SearchProductScreen(),
      ],
    );
  }

  int _currentIndex = 0;

  Widget _buildBottom() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
        BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "Menu"),
      ],
    );
  }
}
