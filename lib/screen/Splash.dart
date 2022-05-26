import 'dart:async';

import 'package:flutter/material.dart';
import 'package:Task/screen/HomeScreen.dart';
import 'package:Task/screen/HomeScreen.dart';
import 'package:Task/screen/Login.dart';

class FirstSplash extends StatefulWidget {
  @override
  _FirstSplashState createState() => _FirstSplashState();
}

class _FirstSplashState extends State<FirstSplash> {


  checkLoginCredentials() async {
    Timer(Duration(seconds: 4), () async {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Login(),
      ));
    });
  }

  @override
  void initState() {
    checkLoginCredentials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                  'assets/github.png',
                ),
              )),
            ),
           
            
          ],
        ),
      ),
    );
  }
}
