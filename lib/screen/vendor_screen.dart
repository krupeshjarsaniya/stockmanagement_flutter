import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stoke_management/database/database_helper.dart';
import 'package:stoke_management/model/api_response/vender_model.dart';
import 'package:stoke_management/screen/sub_screens/add_vendors.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/appbar_title_text.dart';
import 'package:stoke_management/utills/utils_routes.dart';
import 'package:stoke_management/widgets/card_vendors.dart';

class VendorScreen extends StatefulWidget {
  const VendorScreen({Key? key}) : super(key: key);

  @override
  _VendorScreenState createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  List<VenderModel> listVendor = [];


  //
  // Future<List<Map<String, dynamic>>> getVendor() async {
  //   List<Map<String, dynamic>> listMap = await DatabaseHelper.instance.queryAllRows();
  //   setState(() {
  //     listMap.forEach((map) => listVendor.add(VenderModel.fromMap(map)));
  //   });
  // }


  @override
  void initState() {
    DatabaseHelper.getVendor();
    super.initState();
  }

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
                  child: Container(
                    width:50,
                    child: const Icon(
                      Icons.add,
                      size: 30.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
          ],
        ),
      body: Container(
          padding: EdgeInsets.all(15),
          child: ListView.builder(
              itemCount: listVendor.length,
              itemBuilder: (context, position) {
                VenderModel getVendor = listVendor[position];
                var fistname = getVendor.Firstname;
                var lastname = getVendor.Lastname;
                var mobile = getVendor.MobileNumber;
                var company = getVendor.CompanyName;
                return Card(
                  elevation: 8,
                  child: Container(
                    height: 80,
                    padding: EdgeInsets.all(15),
                    child: Stack(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(getVendor.Firstname,
                                style: TextStyle(fontSize: 18))),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: EdgeInsets.only(right: 45),
                            child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (_) => AddVendors(
                                //               true, getVendor)));
                                }),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: (){
                                DatabaseHelper.instance.delete(getVendor.vendorId);
                                setState(() => {
                                  listVendor.removeWhere((item) => item.vendorId == getVendor.vendorId)
                                });
                              }),
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Text("fisrtname: $fistname | lastname: $lastname",
                                style: TextStyle(fontSize: 18))),
                      ],
                    ),
                  ),
                );
              })),
    );
  }
}
