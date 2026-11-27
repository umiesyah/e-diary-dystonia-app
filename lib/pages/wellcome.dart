

import 'package:dystoniadiary/main.dart';
import 'package:dystoniadiary/pages/login.dart';
import 'package:dystoniadiary/pages/register.dart';
import 'package:flutter/material.dart';

class Wellcome extends StatelessWidget {
  const Wellcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: palletcolor.dark,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: [
          Image.asset("assets/images/logo.png"),
          
          Column(
            children: [
              GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Register()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width *0.8,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(colors: 
                [
                  palletcolor.light,
                ],
                end: Alignment.bottomRight,
                begin: Alignment.topLeft,
                )
              ),
              child: Center(child: Text("Sign Up", style: TextStyle(fontSize: 20),)),
            ),
          ),
          Center(child: SizedBox(height: 20,)),
           GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width *0.8,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(colors: 
                [
                  palletcolor.light,
                ],
                end: Alignment.bottomRight,
                begin: Alignment.topLeft,
                )
              ),
              child: Center(child: Text("Login", style: TextStyle(fontSize: 20),)),
            ),
          )
            ],
          )
        ],
      ),
    );
  }
}