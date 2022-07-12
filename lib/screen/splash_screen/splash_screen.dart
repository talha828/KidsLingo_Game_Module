import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kidslingo_game/screen/main_screen/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 2), ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen())));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Center(
          child: FlutterLogo(
            size: 20,
          ),
        )
    );
  }
}