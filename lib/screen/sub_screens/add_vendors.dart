import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stoke_management/model/api_request/add_vepari_request.dart';
import 'package:stoke_management/model/api_response/Add_vepari_model.dart';
import 'package:stoke_management/screen/vendor_screen.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/shared_preferences.dart';
import 'package:stoke_management/view_model/add_vendor_view_model.dart';

import '../../app.dart';

class AddVendors extends StatefulWidget {


  AddVendors();

  //AddVendors.d();

  @override
  AddVendorsState createState() => AddVendorsState();
}

class AddVendorsState extends State<AddVendors> {

  AddVendorViewModel? model;
  List<AddVepariModelItem>? item = <AddVepariModelItem>[];
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController mobileNumberController = new TextEditingController();
  TextEditingController companyController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

  String? firstname, lastname, mobile, company, address, email;
  int? curVendorId;

  String DEVICE_TOKEN = "";
  String USER_ID = "";
  String DEVICE_ID = "";
  String DEVICE_TYPE = "";

  @override
  void initState() {
    super.initState();
    init();
    // scrollController.addListener(pagination);
    Future.delayed(Duration.zero, () {
      /*model ??*/ (model = AddVendorViewModel(this));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.themColor,
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: ColorConstant.themColor,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            margin: const EdgeInsets.all(4),
            child: Column(
              children: [
                const SizedBox(height: 20,),
                w_Image(),
                const SizedBox(height: 20,),
                w_TextFields(),
                const SizedBox(height: 30,),
                 w_Save(),
                const SizedBox(height: 30,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget w_TextFields(){
    return Container(
      child: Column(
        children: [
          TextFormField(
            controller: firstNameController,
            keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  labelText: "First Name",
                  fillColor: Colors.black,
                  ),
            onSaved: (val) => firstname = val,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: lastNameController,
            keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: "Last Name",
                fillColor: Colors.black,
              ),
            onSaved: (val) => lastname = val,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: mobileNumberController,
            keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Mobile Number",
                fillColor: Colors.black,
              ),
            onSaved: (val) => mobile = val,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: companyController,
            keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: "Company Name",
                fillColor: Colors.black,
              ),
            onSaved: (val) => company = val,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: addressController,
            keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: "Address",
                fillColor: Colors.black,
              ),
            onSaved: (val) => address = val,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
                fillColor: Colors.black,
              ),
            onSaved: (val) => email = val,
          ),
        ],
      ),
    );
  }
  
  Widget w_Image(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey)
      ),
      height: 100,
      width: 100,
    );
  }

  Widget w_Save(){
    return InkWell(
      onTap: () {
        if(firstNameController.text.isNotEmpty){
          model!.vepariRequest =
              AddVepariRequest(
                  USER_ID.toString(),
                  firstNameController.text.toString(),
                  lastNameController.text.toString(),
                  mobileNumberController.text.toString(),
                  companyController.text.toString(),
                  addressController.text.toString(),
                  emailController.text.toString(),
                  DEVICE_TYPE.toString(),
                  DEVICE_ID.toString(),
                  DEVICE_TOKEN.toString(),

                 );

          model!.callAddVendor(model!.vepariRequest!);
        }
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => const VendorScreen()),
                (r) => false);
        // Navigator.pushNamed(context, UtilRoutes.VendorScreen);
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: ColorConstant.primarycolor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Center(
          child: Text("Save",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );

  }
  Future<Void?> init() async {
    var deviceToken = await Shared_Preferences.prefGetString(App.KEY_DEVICE_TOKEN, "");
    var userId = await Shared_Preferences.prefGetString(App.KEY_USER_ID, "");
    var deviceId = await Shared_Preferences.prefGetString(App.KEY_DEVICE_ID, "");
    var deviceType= await Shared_Preferences.prefGetString(App.KEY_DEVICE_TYPE, "");
    setState(() {
      DEVICE_TOKEN = deviceToken!;
      USER_ID = userId!;
      DEVICE_ID = deviceId!;
      DEVICE_TYPE = deviceType!;
    });
  }
}
