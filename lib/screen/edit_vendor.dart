import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:stoke_management/model/api_request/edit_vendor_request.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/shared_preferences.dart';
import 'package:stoke_management/view_model/edit_vendor_view_model.dart';

import '../../app.dart';

class EditVendor extends StatefulWidget {
  String? vepariId;
  String? first_name;
  String? last_name;
  String? mobile;
  String? company_name;
  String? address;
  String? email;
  EditVendor({this.vepariId,this.first_name,this.last_name,this.mobile,this.company_name,this.address,this.email});
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
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text("Edit Vendor",style: TextStyle(color: Colors.white),),
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
        child: Image.asset(
            App.ic_profile,fit: BoxFit.fitHeight,),
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

      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: ColorConstant.primarycolor,
          borderRadius: BorderRadius.circular(6),
        ),
        child:  Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text(
              "Save",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
  Future<Void?> init() async {

    var userId = await Shared_Preferences.prefGetString(App.KEY_USER_ID, "");
    var vepariId = await Shared_Preferences.prefGetString(App.KEY_VEPARI_ID, "");

    setState(() {

      firstName = TextEditingController(text:widget.first_name.toString() );
      firstName.selection = TextSelection.fromPosition(TextPosition(offset: firstName.text.length));

      lastName = TextEditingController(text:widget.last_name.toString() );
      lastName.selection = TextSelection.fromPosition(TextPosition(offset: lastName.text.length));

      mobileNumber = TextEditingController(text:widget.mobile.toString() );
      mobileNumber.selection = TextSelection.fromPosition(TextPosition(offset: mobileNumber.text.length));

      companyName = TextEditingController(text:widget.company_name.toString() );
      companyName.selection = TextSelection.fromPosition(TextPosition(offset: companyName.text.length));

      address = TextEditingController(text:widget.address.toString() );
      address.selection = TextSelection.fromPosition(TextPosition(offset: address.text.length));

      emailController = TextEditingController(text:widget.email.toString() );
      emailController.selection = TextSelection.fromPosition(TextPosition(offset: emailController.text.length));

      USER_ID = userId!;
      VEPARI_ID = vepariId!;



    });
  }
}
