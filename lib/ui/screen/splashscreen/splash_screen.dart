import 'dart:async';

import 'package:flutter/material.dart';

import '../../../main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startSplashScreen() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.pushNamedAndRemoveUntil(context, homeRoute, (route) => false);
    });
  }

  @override
  void initState() {
    startSplashScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF348b7b),
      body: Container(
        color: Color(0xFF348b7b),
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Cegah Penyebaran Virus Covid-19 Dengan Tetap #DirumahAja',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
          ),
        ),
      ),
    );
  }
}
