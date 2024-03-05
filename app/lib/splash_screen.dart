import 'dart:async';
import 'package:flutter/material.dart';
import 'main.dart'; 

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => MyHomePage())); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // 垂直居中
        children: <Widget>[
         Image.asset('assets/images/earth.jpg', width: 500), 
         SizedBox(height: 20), 
          Text(
            'Welcome!',
            style: TextStyle(
              fontSize: 24, // 文字大小
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      ),
    );
  }
}
