import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/utils_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        centerTitle: true,
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
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
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
        height: 100.0,
        width: 100.0,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(4)
        )
    );
  }

  Widget wR_TextField() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 20,),
          TextFormField(
            decoration: InputDecoration(
                labelText: "FirstName",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                )
            ),
          ),
          SizedBox(height: 30,),
          TextFormField(
            decoration: InputDecoration(
                labelText: "LastName",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                )
            ),
          ),
          SizedBox(height: 30,),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Mobile Number",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                )
            ),
          ),
          SizedBox(height: 30,),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                )
            ),
          ),
          SizedBox(height: 30,),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                )
            ),
          ),
          SizedBox(height: 30,),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Confirm Password",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                )
            ),
          ),
        ],
      ),
    );
  }

  Widget wR_RegisrationButton() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, UtilRoutes.LoginScreen);
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
            "Register",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white
            ),),
        ),
      ),
    );
  }


}