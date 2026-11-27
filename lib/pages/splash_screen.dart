import 'dart:async';


import 'package:dystoniadiary/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:dystoniadiary/pages//wellcome.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    Timer(const Duration(seconds : 3) ,() {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Wellcome()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
               'assets/images/logo.png',
               height: 300,
               width: 300,
           ),
           CircularProgressIndicator(
            color: Colors.black,
           )
          ],
        ),
      ),
      backgroundColor: palletcolor.dark,
    );
  }
}