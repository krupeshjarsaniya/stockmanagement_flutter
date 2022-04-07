import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stoke_management/model/api_response/vepari_list_model.dart';

import 'package:stoke_management/screen/sub_screens/add_vendors.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/appbar_title_text.dart';
import 'package:stoke_management/utills/shared_preferences.dart';
import 'package:stoke_management/utills/utils_routes.dart';
import 'package:stoke_management/view_model/vendar_view_model.dart';
import 'package:stoke_management/widgets/card_vendors.dart';

import '../app.dart';

class VendorScreen extends StatefulWidget {
  const VendorScreen({Key? key}) : super(key: key);

  @override
  VendorScreenState createState() => VendorScreenState();
}

class VendorScreenState extends State<VendorScreen> {

  late VendorViewModel viewModel;

  List<VepariListItem>? vepariList = <VepariListItem>[];

  @override
  void initState() {
    init();
    Future.delayed(Duration.zero, () {
      /*model ??*/ (viewModel = VendorViewModel(this));
    });
    super.initState();
  }

  String? USER_ID;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
            title: Text("Vendor",style: AppBarTitle.myAppbarStyle),
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: ColorConstant.themColor,
            systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: ColorConstant.themColor,
              statusBarIconBrightness: Brightness.light,
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, UtilRoutes.AddVendors);
                  },
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddVendors()));

                    },
                    child: Container(
                      width:50,
                      child: const Icon(
                        Icons.add,
                        size: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
              // itemCount: 4,
              itemCount: vepariList!.length,
              itemBuilder: (context, position) {
                return Card(
                  elevation: 5,
                  child: Container(

                    padding: EdgeInsets.all(10),
                    child:
                    Row(
                      children: [
                        Container(
                          color: Colors.grey,
                          height: 60,
                          width: 60,
                        ),
                        
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(vepariList![position].firstName.toString() + " " +vepariList![position].lastName.toString(),style: TextStyle(color: Colors.black),),
                                  SizedBox(height: 6,),
                                  Text(vepariList![position].companyName.toString()),
                                  SizedBox(height: 3,),

                                  Text(vepariList![position].mobile.toString()),
                                ],
                              ),
                            ),
                          ),
                        ),
                        
                        Container(
                          child: Column(
                            children: [
                              Icon(Icons.delete,color: Colors.grey,),
                              SizedBox(height: 10,),
                              Icon(Icons.arrow_forward_ios_rounded,color: Colors.grey,size: 18,),
                            ],
                          ),
                        )
                        
                      ],
                    ),
                  ),
                );
              })),
    );
  }


  Future<Void?> init() async {
    var userId = await Shared_Preferences.prefGetString(App.KEY_USER_ID, "");
    print("----userId---" + userId.toString());

    setState(() {
      USER_ID = userId.toString();
    });
  }

}
