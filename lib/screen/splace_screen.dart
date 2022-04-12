import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stoke_management/screen/home_screen.dart';
import 'package:stoke_management/screen/login_screen.dart';
import 'package:stoke_management/utills/appbar_title_text.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/shared_preferences.dart';

import '../../app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void startTimer() {
    Timer(Duration(milliseconds: 2000), () {
      _checkFirstTime();
    });
  }

  void _checkFirstTime() async {
    bool? isLogin = await Shared_Preferences.prefGetBool(App.KEY_IS_LOGIN, false);
    print("-----------------islogin-----------------" + isLogin.toString());
    if(isLogin! == true){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      // Navigator.pushReplacement(context, NavigatePageRoute(context, WelcomeScreen()));
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
          child: Image.asset(App.ic_splash,fit: BoxFit.cover,))
    );
  }
}
