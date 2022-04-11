import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stoke_management/model/api_request/Full_more_Request.dart';
import 'package:stoke_management/model/api_response/dashbord_model.dart';
import 'package:stoke_management/screen/viewmore_screen.dart';
import 'package:stoke_management/utills/appbar_title_text.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/shared_preferences.dart';
import 'package:stoke_management/utills/utils_routes.dart';
import 'package:stoke_management/view_model/dashbord_view_model.dart';
import 'package:stoke_management/view_model/view_more_model.dart';

import '../app.dart';
import 'edit_transaction_screen.dart';

class DashBordScreen extends StatefulWidget {
  const DashBordScreen({Key? key}) : super(key: key);

  @override
  DashBordScreenState createState() => DashBordScreenState();
}

class DashBordScreenState extends State<DashBordScreen> {

  String? USER_ID;
  String? DEVICE_TYPE;
  String? DEVICE_ID;
  String? DEVICE_TOKEN;

  DashBordViewModel? model;

  DashBordModel dashBordModel = DashBordModel();

  @override
  void initState() {
    super.initState();
    init();
    // scrollController.addListener(pagination);
    Future.delayed(Duration.zero, () {
      (model = DashBordViewModel(this));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
            title: InkWell(
              onTap: (){
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditTransactionScreen()));
              },
              child: Text("Dash Bord",
                  style: AppBarTitle.myAppbarStyle),
            ),
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: ColorConstant.themColor,
            systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: ColorConstant.themColor,
              statusBarIconBrightness: Brightness.light,
            )
        ),
      body: Container(
        margin: EdgeInsets.only(bottom: 90),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          w_toolbar(),
          w_stockCount(),
          w_viewDetailButton(),
        ],
      ),
      )
    );
  }


  Widget w_toolbar(){
    return Container(
      decoration:  BoxDecoration(
        color: Colors.amber
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 25,bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Container(
                child : Column(
                  children:  [
                    Text(
                      "CREDIT",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),

                    SizedBox(height: 5,),
                    Text(
                     " ${dashBordModel.totalCredit.toString()} ${"G"}",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              height: 35,
              width: 1,
              color: Colors.white,
            ),

            Expanded(
              child: Container(
                child : Column(
                  children:  [
                    Text(
                      "DEBIT",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),

                    SizedBox(height: 5,),

                    Text(
                      " ${dashBordModel.totalDebit.toString()} ${"G"}",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              height: 35,
              width: 1,
              color: Colors.white,
            ),

            
            Expanded(
              child: Container(
                child : Column(
                  children:  [
                    Text(
                      "BALANCE",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),

                    SizedBox(height: 5,),

                    Text(
                      // dashBordModel.balance.toString(),
                      " ${dashBordModel.balance.toString()} ${"G"}",

                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget w_stockCount(){
    return Container(
      child: Column(
        children:  [
          Text(dashBordModel.balance.toString()),
          Text("Stock"),
        ],
      ),
    );
  }

  Widget w_viewDetailButton(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.circle,color: Colors.lightGreenAccent,size: 12,),
              SizedBox(width: 3,),
              Text("Credit",style: TextStyle(color: Colors.black,fontSize: 10),),
              SizedBox(width: 8,),
              Icon(Icons.circle,color: Colors.yellow,size: 12,),
              SizedBox(width: 3,),
              Text("Debiit",style: TextStyle(color: Colors.black,fontSize: 10),),
            ],
          ),
        ),
        SizedBox(height: 10,),
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ViewMoreScreen(totalCredit: dashBordModel.totalCredit.toString(),totalDebit: dashBordModel.totalDebit.toString(),totalBalance: dashBordModel.balance.toString(),)));

            // Navigator.pushNamed(context, UtilRoutes.ViewMoreScreen);
            },
          child: Container(
            height: 30,
            width: 120,
            child: const Center(child: Text("View Detail",style: TextStyle(color: Colors.white),)),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(5)
            ),
          ),
        ),
      ],
    );
  }

  Future<Void?> init() async {
    var userId = await Shared_Preferences.prefGetString(App.KEY_USER_ID, "");
    var deviceType = await Shared_Preferences.prefGetString(App.KEY_DEVICE_TYPE, "");
    var deviceId = await Shared_Preferences.prefGetString(App.KEY_DEVICE_ID, "");
    var token = await Shared_Preferences.prefGetString(App.KEY_DEVICE_TOKEN, "");

    setState(() {
      USER_ID = userId.toString();
      DEVICE_TYPE = deviceType.toString();
      DEVICE_ID = deviceId.toString();
      DEVICE_TOKEN = token.toString();
    });
  }
}
