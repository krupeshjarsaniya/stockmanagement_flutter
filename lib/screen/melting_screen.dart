import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/appbar_title_text.dart';
class MeltingScreen extends StatefulWidget {
  const MeltingScreen({Key? key}) : super(key: key);

  @override
  _MeltingScreenState createState() => _MeltingScreenState();
}

class _MeltingScreenState extends State<MeltingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Melting",style: AppBarTitle.myAppbarStyle),
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: ColorConstant.themColor,
            systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: ColorConstant.themColor,
              statusBarIconBrightness: Brightness.light,
            )
        )
    );
  }
}
