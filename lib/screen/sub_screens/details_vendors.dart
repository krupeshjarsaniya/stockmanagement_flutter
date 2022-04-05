import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stoke_management/utills/appbar_title_text.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/utils_routes.dart';

class DetailsVendors extends StatefulWidget {
  const DetailsVendors({Key? key}) : super(key: key);

  @override
  _DetailsVendorsState createState() => _DetailsVendorsState();
}

class _DetailsVendorsState extends State<DetailsVendors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        title: Text("Vendor name",style: AppBarTitle.myAppbarStyle),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: ColorConstant.themColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: ColorConstant.themColor,
          statusBarIconBrightness: Brightness.light,
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, UtilRoutes.AddVendors);
            },
            child: Container(
              width:50,
              child: const Icon(
                Icons.add,
                size: 30.0,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
