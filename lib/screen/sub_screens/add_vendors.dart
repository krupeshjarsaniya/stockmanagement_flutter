import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stoke_management/database/database_helper.dart';
import 'package:stoke_management/model/vender_model.dart';
import 'package:stoke_management/screen/vendor_screen.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/utils_routes.dart';

class AddVendors extends StatefulWidget {

   VenderModel? vendermodel;

  // AddVendors(this.venderModel, {Key? key}) : super(key: key);


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

  // Future<List<VenderModel>>? vendors;
  String? firstname, lastname, mobile, company, address, email;
  int? curVendorId;
  //
  // final formKey = new GlobalKey<FormState>();
  // var dbHelper;
  // late bool isUpdating;
  //
  // clearName() {
  //   firstNameController.text = '';
  //   lastNameController.text = '';
  //   mobileNumberController.text = '';
  //   companyController.text = '';
  //   addressController.text = '';
  //   emailController.text = '';
  // }



  @override
  Widget build(BuildContext context) {

      firstNameController.text = widget.vendermodel!.Firstname.toString();
      lastNameController.text = widget.vendermodel!.Lastname.toString();
      mobileNumberController.text = widget.vendermodel!.MobileNumber.toString();
      companyController.text = widget.vendermodel!.CompanyName.toString();
      addressController.text = widget.vendermodel!.Address.toString();
      emailController.text = widget.vendermodel!.Email.toString();


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
            margin: const EdgeInsets.all(25),
            child: Column(
              children: [
                const SizedBox(height: 20,),
                w_Image(),
                const SizedBox(height: 20,),
                w_TextFields(),
                const SizedBox(height: 30,),
                // w_Save(),
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

          const SizedBox(
            height: 20,
          ),

          TextFormField(
            controller: lastNameController,
            keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: "Last Name",
                fillColor: Colors.black,
              ),

            onSaved: (val) => lastname = val,

          ),

          const SizedBox(
            height: 20,
          ),

          TextFormField(
            controller: mobileNumberController,
            keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Mobile Number",
                fillColor: Colors.black,
              ),

            onSaved: (val) => mobile = val,
          ),

          const SizedBox(
            height: 20,
          ),

          TextFormField(
            controller: companyController,
            keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: "Company Name",
                fillColor: Colors.black,
              ),
            onSaved: (val) => company = val,
          ),

          const SizedBox(
            height: 20,
          ),

          TextFormField(
            controller: addressController,
            keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: "Address",
                fillColor: Colors.black,
              ),


            onSaved: (val) => address = val,
          ),

          const SizedBox(
            height: 20,
          ),

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
      height: 100,
      width: 100,
        color: Colors.grey
    );
  }

  Widget w_Save(){
    return InkWell(
      onTap: () {
        var getFirstName = firstNameController.text;
        var getLastName = lastNameController.text;
        var getMobile = mobileNumberController.text;
        var getCompany= companyController.text;
        var getAddress = addressController.text;
        var getEmail = emailController.text;


          VenderModel addVendor = VenderModel(
              vendorId : widget.vendermodel!.vendorId,
              Firstname: getFirstName,
              Lastname: getLastName,
              MobileNumber: getMobile,
              CompanyName: getCompany,
              Address: getAddress,
              Email: getEmail);

          DatabaseHelper.instance.insert(addVendor.toMapWithoutId());


        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const VendorScreen()),
                (r) => false);
        // Navigator.pushNamed(context, UtilRoutes.VendorScreen);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
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
}
