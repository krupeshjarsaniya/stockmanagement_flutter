import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:stoke_management/model/api_request/edit_vendor_request.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/shared_preferences.dart';
import 'package:stoke_management/view_model/edit_vendor_view_model.dart';

import '../../app.dart';

class EditVendor extends StatefulWidget {
  String? vepariId;

  EditVendor({this.vepariId});
  // const EditVendor({Key? key}) : super(key: key);

  @override
  EditVendorState createState() => EditVendorState();
}

class EditVendorState extends State<EditVendor> {

  String VEPARI_ID = "";
  String USER_ID = "";


  EditVendorViewModel? model;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
    // scrollController.addListener(pagination);
    Future.delayed(Duration.zero, () {
      /*model ??*/ (model = EditVendorViewModel(this));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Vendor"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              wR_ProfileImage(),
              wR_TextField(),
              SizedBox(
                height: 20,
              ),
              wRSaveButton(),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget wR_ProfileImage() {
    return Container(
      height: 90.0,
      width: 90.0,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
            "https://monstar-lab.com/global/wp-content/uploads/sites/11/2019/04/male-placeholder-image.jpeg"),
      ),
    );
  }

  Widget wR_TextField() {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: firstName,
            decoration: InputDecoration(
              labelText: "FirstName",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: lastName,
            decoration: InputDecoration(
              labelText: "LastName",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: mobileNumber,
            decoration: InputDecoration(
              labelText: "Mobile Number",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: companyName,
            decoration: InputDecoration(
              labelText: "Company Name",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: address,
            decoration: InputDecoration(
              labelText: "Address",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Email",
            ),
          ),
        ],
      ),
    );
  }

  Widget wRSaveButton() {
    return InkWell(
      onTap: () {
        if(firstName.text.isEmpty){
        }else if(lastName.text.isEmpty){
        }else if(mobileNumber.text.isEmpty){
        }else if(companyName.text.isEmpty){
        }else if(address.text.isEmpty){
        }else if(emailController.text.isEmpty){
        }else {
          model!.editVendorRequest = EditVendorRequest(
              widget.vepariId.toString(),
              USER_ID.toString(),
              firstName.text.toString(),
              lastName.text.toString(),
              mobileNumber.text.toString(),
              emailController.text.toString(),
              companyName.text.toString(),
              address.text.toString()
             );
          model!.callEditVendor(model!.editVendorRequest!);
          print(
              "==================" + model!.editVendorRequest.toString());
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          color: ColorConstant.primarycolor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text(
            "Save",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
  Future<Void?> init() async {

    var userId = await Shared_Preferences.prefGetString(App.KEY_USER_ID, "");
    var vepariId = await Shared_Preferences.prefGetString(App.KEY_VEPARI_ID, "");

    setState(() {
      USER_ID = userId!;
      VEPARI_ID = vepariId!;
    });
  }
}
