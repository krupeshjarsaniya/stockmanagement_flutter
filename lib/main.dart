import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:stoke_management/model/api_request/login_request.dart';
import 'package:stoke_management/screen/profile_screen.dart';
import 'package:stoke_management/screen/sub_screens/add_vendors.dart';
import 'package:stoke_management/screen/home_screen.dart';
import 'package:stoke_management/screen/login_screen.dart';
import 'package:stoke_management/screen/register_screen.dart';
import 'package:stoke_management/screen/sub_screens/change_password.dart';
import 'package:stoke_management/screen/sub_screens/details_vendors.dart';
import 'package:stoke_management/screen/vendor_screen.dart';
import 'package:stoke_management/screen/viewmore_screen.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/shared_preferences.dart';
import 'package:stoke_management/utills/utils_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'app.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    registerNotification();
    print("===main init2===");
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        primarySwatch: ColorConstant.primarycolor
      ),
      title: "Stoke Management",
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        UtilRoutes.RegisterScreen:(context) => RegisterScreen(),
        UtilRoutes.LoginScreen:(context) => LoginScreen(),
        UtilRoutes.HomeScreen:(context) => HomeScreen(),
        UtilRoutes.AddVendors:(context) => AddVendors(),
        UtilRoutes.VendorScreen:(context) => VendorScreen(),
        UtilRoutes.ProfileScreen:(context) => ProfileScreen(),
        UtilRoutes.ChangePassword:(context) => ChangePassword(),
        UtilRoutes.DetailsVendors:(context) => DetailsVendors(),
        UtilRoutes.ViewMoreScreen:(context) => ViewMoreScreen(),
      },
    );
  }
  
  Future<void> registerNotification() async {
    print("registernotification");
    FirebaseMessaging.instance.getToken().then((t) async {
      await Shared_Preferences.prefSetString(App.KEY_DEVICE_TOKEN, t!);
      print("--deviceToken---");
      print("-----DeviceToken----> :" + t);
    });
    await Firebase.initializeApp();
  }

}
