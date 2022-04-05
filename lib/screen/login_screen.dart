import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stoke_management/utills/appbar_title_text.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/utils_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login",style: AppBarTitle.myAppbarStyle,),
        centerTitle: true,
        backgroundColor: ColorConstant.themColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: ColorConstant.themColor,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              margin: EdgeInsets.all(25),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  wTextField(),
                  const SizedBox(
                    height: 40,
                  ),
                  wLoginButton(),
                  const SizedBox(
                    height: 40,
                  ),
                  wForgetPassword(),
                  const SizedBox(
                    height: 50,
                  ),
                  wTextRegister()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget wTextField() {
    return Container(
      child: Column(
        children: [
          TextFormField(
              decoration: InputDecoration(
                  labelText: "Mobile/Email Adresss",
                  fillColor: Colors.black,
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.amber),
                  ))),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Password",
                fillColor: Colors.black,
                border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.red))),
          ),
        ],
      ),
    );
  }

  Widget wLoginButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, UtilRoutes.HomeScreen);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 45,
        decoration: BoxDecoration(
          color: ColorConstant.primarycolor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text(
            "Login",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget wForgetPassword() {
    return GestureDetector(
      onTap: () {},
      child: const Text(
        "Forget Password ? ",
        style: TextStyle(
            color: ColorConstant.primarycolor, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget wTextRegister() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Not Register Yet ?   ",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, UtilRoutes.RegisterScreen);
          },
          child: const Text(
            "Register Now",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorConstant.primarycolor,
            ),
          ),
        )
      ],
    );
  }
}
