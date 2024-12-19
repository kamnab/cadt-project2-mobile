import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: true,
            child: const LinearProgressIndicator(),
          ),
          Expanded(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.jpg',
                  width: 150,
                ),
                SizedBox(
                  height: 10,
                ),
                //Text('Classroom Learning App')
              ],
            )),
          ),
        ],
      ),
    ));
  }
}
