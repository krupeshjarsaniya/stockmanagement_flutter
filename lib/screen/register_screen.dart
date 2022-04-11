import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stoke_management/model/api_request/register_request.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/view_model/register_view_model.dart';
import 'package:stoke_management/widgets/common_toast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  late RegisterViewModel viewModel;
  @override
  void initState() {
    super.initState();

    // scrollController.addListener(pagination);

    Future.delayed(Duration.zero, () {
      /*model ??*/ (viewModel = RegisterViewModel(this));
    });
  }

  TextEditingController firstNameController =  TextEditingController();
  TextEditingController lastNameController =  TextEditingController();
  TextEditingController mobileController =  TextEditingController();
  TextEditingController emailController =  TextEditingController();
  TextEditingController passwordController =  TextEditingController();
  TextEditingController conformPasswordController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text("Register",style: TextStyle(color: Colors.white),),
        // centerTitle: true,
        backgroundColor: ColorConstant.themColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: ColorConstant.themColor,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: SizedBox(
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    wR_ProfileImage(),
                    const SizedBox(height: 20,),
                    wR_TextField(),
                    const SizedBox(height: 40,),
                    wR_RegisrationButton(),
                    const SizedBox(height: 40,),
                  ],
                ),
              ),
            ),
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
          borderRadius: BorderRadius.circular(10)
        )
    );
  }

  Widget wR_TextField() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 15,),
          TextFormField(
              keyboardType: TextInputType.text,
              controller: firstNameController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
                alignLabelWithHint: true,
                labelText: "FirstName",
                fillColor: Colors.black,
              )),
          SizedBox(height: 15,),
          TextFormField(
              keyboardType: TextInputType.text,
              controller: lastNameController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
                alignLabelWithHint: true,
                labelText: "LastName",
                fillColor: Colors.black,
              )),
          SizedBox(height: 15,),
          TextFormField(
              keyboardType: TextInputType.number,
              controller: mobileController,
              inputFormatters: [
                new LengthLimitingTextInputFormatter(10),
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
                alignLabelWithHint: true,
                labelText: "Mobile Number",
                fillColor: Colors.black,
              )),
          SizedBox(height: 15,),
          TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
                alignLabelWithHint: true,
                labelText: "Email",
                fillColor: Colors.black,
              )),
          SizedBox(height: 15,),
          TextFormField(
              keyboardType: TextInputType.number,
              controller: passwordController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
                alignLabelWithHint: true,
                labelText: "Password",
                fillColor: Colors.black,
              )),
          SizedBox(height: 15,),
          TextFormField(
              keyboardType: TextInputType.number,
              controller: conformPasswordController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
                alignLabelWithHint: true,
                labelText: "Confirm Password",
                fillColor: Colors.black,
              )),
        ],
      ),
    );
  }

  Widget wR_RegisrationButton() {
    return InkWell(
      onTap: () {
        if(firstNameController.text.isEmpty){

          print("------------");
          commonToast("Please Enter First Name");

          //
          // Fluttertoast.showToast(
          //     msg: "Hi Codesinsider !!",
          //     toastLength: Toast.LENGTH_SHORT,
          //     fontSize: 20,
          //     textColor: Colors.white
          // );
        }else if(lastNameController.text.isEmpty){
          commonToast("Please Enter Last Name");

        }else if(mobileController.text.isEmpty){
          commonToast("Please Enter Mobile Number");

        }else if(emailController.text.isEmpty){
          commonToast("Please Enter Email");

        }else if(passwordController.text.isEmpty){
          commonToast("Please Enter Password");
        }else if(mobileController.text.length == 10){
          commonToast("Please Enter Valid Mobile Number");
        }else if(conformPasswordController.text.isEmpty){
          commonToast("Please Enter Confirm Password");
        }else if(conformPasswordController.text != passwordController.text){
          commonToast("Password Does Not Match");
        }else {
          viewModel.userRegisterRequest = UserRegisterRequest(
              firstNameController.text.toString(),
              lastNameController.text.toString(),
              mobileController.text.toString(),
              emailController.text.toString(),
              passwordController.text.toString(),
              "Android",
              "deviceuid",
              "token");
          viewModel.callUserRegister(viewModel.userRegisterRequest!);
          print(
              "==================" + viewModel.userRegisterRequest.toString());
        }

        // Navigator.pushNamed(context, UtilRoutes.LoginScreen);
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
              "Register",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white
              ),),
          ),
        ),
      ),
    );
  }


}