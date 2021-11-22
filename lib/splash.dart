import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("WeatherApp" ,
          style: TextStyle(
            color: const Color(0xff00804A),
            fontSize: 35.0,
            fontWeight: FontWeight.bold
          ),),
        ),
      ),
    );
  }

  @override
  void initState() {
    _navigateToHome();
  }

  _navigateToHome() async{
    await Future.delayed(Duration(milliseconds: 2000), (){});
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const MyHomePage(title: 'WeatherApp') ));
  }
}
