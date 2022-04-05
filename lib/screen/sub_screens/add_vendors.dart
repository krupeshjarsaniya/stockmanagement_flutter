import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stoke_management/screen/vendor_screen.dart';
import 'package:stoke_management/utills/color_constant.dart';

class AddVendors extends StatefulWidget {


  AddVendors();

  //AddVendors.d();

  @override
  _AddVendorsState createState() => _AddVendorsState();
}

class _AddVendorsState extends State<AddVendors> {

  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController mobileNumberController = new TextEditingController();
  TextEditingController companyController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

  String? firstname, lastname, mobile, company, address, email;
  int? curVendorId;

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
        Navigator.pushAndRemoveUntil(
            context,
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
}
