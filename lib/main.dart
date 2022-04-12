import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:stoke_management/screen/add_transaction.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:stoke_management/screen/profile_screen.dart';
import 'package:stoke_management/screen/splace_screen.dart';
import 'package:stoke_management/screen/add_vendors.dart';
import 'package:stoke_management/screen/home_screen.dart';
import 'package:stoke_management/screen/login_screen.dart';
import 'package:stoke_management/screen/register_screen.dart';
import 'package:stoke_management/screen/change_password.dart';
import 'package:stoke_management/screen/vendor_details_screen.dart';
import 'package:stoke_management/screen/vendor_screen.dart';
import 'package:stoke_management/screen/viewmore_screen.dart';
import 'package:stoke_management/utills/LocalString.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/shared_preferences.dart';
import 'package:stoke_management/utills/utils_routes.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:stoke_management/view_model/login_view_model.dart';
import 'package:stoke_management/view_model/my_app_viewmodel.dart';
import 'app.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'app.dart';
import 'model/api_request/register_device_request.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  late MyAppViewModel model;

  var deviceToken;


  @override
  void initState() {
    super.initState();
    registerNotification();
    Future.delayed(Duration.zero, () {
      /*model ??*/ (model = MyAppViewModel(this));
    });
    // initPlatformState();
    print("===main init2===");
  }

  Future<void> initPlatformState() async {
    String deviceData = "";

    try {
      if (Platform.isAndroid) {
        _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      'Failed to get platform version.';
    }
    if (mounted) return;

    /* setState(() {
      _deviceData = deviceData;
    });*/
  }



  _readAndroidBuildData(AndroidDeviceInfo build) async{
    print("-->"+build.model);
    print("-->"+build.androidId);
    print("-->"+build.type);
    print("-->"+build.version.release.toString());
    print("-->"+build.device);



    model.registerDeviceRequest = RegisterDeviceRequest(
      "Stock Management",
      "0.0",
      build.androidId,
      deviceToken,
      build.device,
      "",
      "",
      "",
        "",
        build.version.release.toString(),
    );

    model.callRegisterDevice(model.registerDeviceRequest!);
    /* model.addApns=AddApns("testmobile","1.0",build.androidId,await App.getToken(),build.model,build.device,build.version.release.toString(),"Android");
    model.callApns(model.addApns);*/
    print("=====DeviceId====="+build.androidId);
    Shared_Preferences.prefSetString(App.KEY_DEVICE_ID,build.androidId);
    Shared_Preferences.prefSetString(App.KEY_DEVICE_TYPE,"Android");
  }


  _readIosDeviceInfo(IosDeviceInfo data) {
    print("-->"+data.model);
    print("-->"+data.name);
    print("-->"+data.systemVersion);
    print("-->"+data.utsname.version);
    print("-->"+data.systemName);
    print("-->"+data.identifierForVendor);
    model.registerDeviceRequest = RegisterDeviceRequest(
     "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
    );
    model.callRegisterDevice(model.registerDeviceRequest!);
    /* model.addApns=AddApns("testmobile", "1.0", data.identifierForVendor,"xyz321", data.name, data.model,  data.systemVersion, "Ios");
    model.callApns(model.addApns);*/
    Shared_Preferences.prefSetString(App.KEY_DEVICE_ID,data.identifierForVendor);
    Shared_Preferences.prefSetString(App.KEY_DEVICE_TYPE,"Ios");

  }


  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      translations: LocalString(),
      locale: Locale('en_US'),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: SplashScreen(),
      routes: {
        UtilRoutes.RegisterScreen:(context) => RegisterScreen(),
        UtilRoutes.LoginScreen:(context) => LoginScreen(),
        UtilRoutes.HomeScreen:(context) => HomeScreen(),
        UtilRoutes.AddVendors:(context) => AddVendors(),
        UtilRoutes.VendorScreen:(context) => VendorScreen(),
        UtilRoutes.ProfileScreen:(context) => ProfileScreen(),
        UtilRoutes.ChangePassword:(context) => ChangePassword(),
        UtilRoutes.ViewMoreScreen:(context) => ViewMoreScreen(),
      },
    );


    //   MaterialApp(
    //   theme: ThemeData(
    //     primarySwatch: ColorConstant.primarycolor
    //   ),
    //   title: "Stoke Management",
    //
    //   home: SplashScreen(),
    //
    //   debugShowCheckedModeBanner: false,
    //   routes: {
    //     UtilRoutes.RegisterScreen:(context) => RegisterScreen(),
    //     UtilRoutes.LoginScreen:(context) => LoginScreen(),
    //     UtilRoutes.HomeScreen:(context) => HomeScreen(),
    //     UtilRoutes.AddVendors:(context) => AddVendors(),
    //     UtilRoutes.VendorScreen:(context) => VendorScreen(),
    //     UtilRoutes.ProfileScreen:(context) => ProfileScreen(),
    //     UtilRoutes.ChangePassword:(context) => ChangePassword(),
    //     UtilRoutes.ViewMoreScreen:(context) => ViewMoreScreen(),
    //   },
    // );
  }

  Future<void> registerNotification() async {
    print("registernotification");
    FirebaseMessaging.instance.getToken().then((t) async {
      await Shared_Preferences.prefSetString(App.KEY_DEVICE_TOKEN, t!);
      print("--deviceToken---");
      deviceToken =  await Shared_Preferences.prefSetString(App.KEY_DEVICE_TOKEN, t);
      print("-----DeviceToken----> :" + t);
    });
    await Firebase.initializeApp();
  }

}
