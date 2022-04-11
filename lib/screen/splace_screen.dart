import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stoke_management/screen/home_screen.dart';
import 'package:stoke_management/screen/login_screen.dart';
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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

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

    // bool isFirstTime = await Shared_Preferences.prefGetBool(App.KEY_IS_FIRST_TIME,false) ?? false;
    // bool isLogin = await Shared_Preferences.prefGetBool(App.KEY_IS_LOGIN,false) ?? false;
    //
    // if (isFirstTime) {
    //   //navigate to login or home screen
    //   if(isLogin == false){
    //     // if not login
    // MaterialPageRoute(builder: (context) => OtpScreen());

    // Navigator.pushReplacement(context, NavigatePageRoute(context, WelcomeScreen()));


    //   }else{
    //     // if login
    //     Navigator.pushReplacement(
    //         context, MaterialPageRoute(builder: (context) => MainHomeScreen()));
    //   }
    // } else {
    //   // navigate to intro screen
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => IntroScreen()));
    //   await Shared_Preferences.prefSetBool(App.KEY_IS_FIRST_TIME,true);
    // }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(child: Image.asset(App.ic_splash,fit: BoxFit.fill,)),
            // Center(child: Image.asset(App.ic_app_logo,height: 80,width: 160)),

          ],
        )
      ),
    );
  }
}
