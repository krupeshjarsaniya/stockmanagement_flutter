import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stoke_management/model/api_request/add_vepari_request.dart';
import 'package:stoke_management/model/api_response/Add_vepari_model.dart';
import 'package:stoke_management/screen/vendor_screen.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/shared_preferences.dart';
import 'package:stoke_management/view_model/add_vendor_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stoke_management/widgets/common_toast.dart';
import 'package:stoke_management/widgets/image_placeholder.dart';
import '../app.dart';

class AddVendors extends StatefulWidget {


 // AddVendors();

  //AddVendors.d();

  @override
  AddVendorsState createState() => AddVendorsState();
}

class AddVendorsState extends State<AddVendors> {

  File? _image;
  PickedFile? pickedImage;
  final picker = ImagePicker();

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

  String? USER_PROFILE;
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
      appBar:  AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text("Add Vendor",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: ColorConstant.themColor,
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
                contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
                alignLabelWithHint: true,
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
                contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
                alignLabelWithHint: true,
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
                contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
                alignLabelWithHint: true,
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
                contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
                alignLabelWithHint: true,
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
                contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
                alignLabelWithHint: true,
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
                contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
                alignLabelWithHint: true,
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
    return /* InkWell(
            :*/ Container(
            width: 90,
            height: 90,
            child: Image.asset(App.ic_profile,fit: BoxFit.fitHeight,),

      );
  }

  Widget w_Save(){
    return InkWell(
      onTap: () {
        if(firstNameController.text.isEmpty){
          commonToast("Please Enter First Name");
        }else if(lastNameController.text.isEmpty){
          commonToast("Please Enter Last Name");
        }else if(mobileNumberController.text.isEmpty){
          commonToast("Please Enter Mobile Name");
        }else if(companyController.text.isEmpty){
          commonToast("Please Enter Company Name");
        }else if(addressController.text.isEmpty){
          commonToast("Please Enter Address");
        }else if(emailController.text.isEmpty){
          commonToast("Please Enter Email");
        }else {
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
        // Navigator.pushAndRemoveUntil(context,
        //     MaterialPageRoute(builder: (_) => const VendorScreen()),
        //         (r) => false);
        // Navigator.pushNamed(context, UtilRoutes.VendorScreen);
      },
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstant.primarycolor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: const Center(
            child: Text("Save",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
            ),
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
    var userProfile= await Shared_Preferences.prefGetString(App.KEY_USER_PROFILE, "");
    setState(() {
      DEVICE_TOKEN = deviceToken!;
      USER_ID = userId!;
      DEVICE_ID = deviceId!;
      DEVICE_TYPE = deviceType!;
      USER_PROFILE = userProfile!;
    });
  }

  _imgFromCamera() async {
    pickedImage =
    await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    File image = File(pickedImage!.path);
    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    pickedImage =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    File image = File(pickedImage!.path);
    setState(() {
      _image = image;
    });
  }



  _showPicker(BuildContext context ) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
              insetPadding: EdgeInsets.all(15),
              backgroundColor: Colors.transparent,
              child: Builder(builder: (BuildContext context) {
                return
                  Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15,left: 20,bottom: 15),
                              child: Text("Choose",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: (){
                                _imgFromCamera();
                                Navigator.of(context).pop();
                              },
                              child: Column(
                                children: [
                                  Icon(Icons.camera_alt,size: 50,color: Colors.grey,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Camera",style: TextStyle(color: Colors.grey,fontSize: 18),),
                                  )
                                ],
                              ),
                            ),


                            InkWell(
                              onTap: (){
                                _imgFromGallery();
                                Navigator.of(context).pop();
                              },
                              child: Column(
                                children: [
                                  Icon(Icons.photo_library,size: 50,color: Colors.grey,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Gallery",style: TextStyle(color: Colors.grey,fontSize: 18),),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text("CANCLE",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,),
                              ),
                            ),
                            )],
                        ),
                      ],
                    ),
                  );
              },
              )
          );
        });
  }

}
