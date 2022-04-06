import 'package:flutter/material.dart';
import 'package:stoke_management/utills/color_constant.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
            TextField(
              keyboardType: TextInputType.number,
              cursorColor: Colors.yellow,
              decoration: InputDecoration(
                labelText: "Email",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorConstant.themColor!),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ColorConstant.themColor,
              ),
              height: 60,
              child: Center(
                  child: Text("Submit",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
            ),
          ],
        ),
      ),
    );
  }
}
