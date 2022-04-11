import 'package:flutter/material.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/view_model/forgot_password_viewmodel.dart';
import 'package:stoke_management/widgets/common_toast.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  late ForgotPasswordViewModel viewModel;
  TextEditingController emailController =  TextEditingController();


  @override
  void initState() {
    super.initState();
    // init();
    Future.delayed(Duration.zero, () {
      /*model ??*/ (viewModel = ForgotPasswordViewModel(this));
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text("Forgot Password",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20),
        child: ListView(
          children: [
            SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Colors.yellow,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
                alignLabelWithHint: true,
                labelText: "Email",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorConstant.themColor!),
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: (){
                if(emailController.text.isEmpty){
                  commonToast("Please Enter Email");

                }else{
                  viewModel.callForgotPassword(emailController.text.toString());
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorConstant.themColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                      child: Text("Submit",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
