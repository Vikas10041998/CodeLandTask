import 'dart:async';

import 'package:flutter/material.dart';

import 'LoginScreen.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState() {
    super.initState();
    // Delay for 2 seconds before navigating to the next screen
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:Container(
        color: Colors.orange,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.width/1.8,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 5), // changes the shadow position
                  ),
                ],
              ),
              child: Column(children: [
                SizedBox(height: 30,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    "assets/img.png",
                    fit: BoxFit.fill, // or use BoxFit.fill based on your preference
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    "assets/img_1.png",
                    fit: BoxFit.fill, // or use BoxFit.fill based on your preference
                  ),
                ),
              ],)
            ),
          )),
    );
  }
}





