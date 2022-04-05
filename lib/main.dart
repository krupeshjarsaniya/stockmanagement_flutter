import 'package:flutter/material.dart';
import 'package:stoke_management/model/api_response/vender_model.dart';
import 'package:stoke_management/screen/profile_screen.dart';
import 'package:stoke_management/screen/sub_screens/add_vendors.dart';
import 'package:stoke_management/screen/home_screen.dart';
import 'package:stoke_management/screen/login_screen.dart';
import 'package:stoke_management/screen/register_screen.dart';
import 'package:stoke_management/screen/sub_screens/change_password.dart';
import 'package:stoke_management/screen/sub_screens/details_vendors.dart';
import 'package:stoke_management/screen/vendor_screen.dart';
import 'package:stoke_management/utills/utils_routes.dart';

void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.yellow
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
      },
    );
  }
}
