import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
<<<<<<< HEAD
import 'package:stoke_management/model/api_request/login_request.dart';
=======
import 'package:stoke_management/screen/sub_screens/forgot_password_screen.dart';
>>>>>>> development
import 'package:stoke_management/utills/appbar_title_text.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/utils_routes.dart';
import 'package:stoke_management/view_model/login_view_model.dart';
<<<<<<< HEAD
// import 'package:stoke_management/widgets/common_toast.dart';
=======
>>>>>>> development

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

<<<<<<< HEAD
  late LoginViewModel loginViewModel;

  TextEditingController phoneNumberController =  TextEditingController();
  TextEditingController passwordController =  TextEditingController();

=======
  LoginViewModel? model;
>>>>>>> development

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD

    // scrollController.addListener(pagination);

    Future.delayed(Duration.zero, () {
      /*model ??*/ (loginViewModel = LoginViewModel(this));
    });
  }


=======
    Future.delayed(Duration.zero, () {
       (model = LoginViewModel(this));
    });
  }

>>>>>>> development
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login",style: AppBarTitle.myAppbarStyle,),
        // centerTitle: true,
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
            padding:  EdgeInsets.all(5.0),
            child: Container(
              margin: EdgeInsets.all(15),
              child: Column(
                children: [
                   SizedBox(
                    height: 20,
                  ),
                  wTextField(),
                   SizedBox(
                    height: 40,
                  ),
                  wLoginButton(),
                   SizedBox(
                    height: 40,
                  ),
                  wForgetPassword(),
                   SizedBox(
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
            controller: phoneNumberController,
              decoration: InputDecoration(
                  labelText: "Mobile",
                  fillColor: Colors.black,
                  // border: OutlineInputBorder(
                  //   borderRadius: new BorderRadius.circular(10),
                  //   borderSide: BorderSide(color: Colors.amber),
                  // )

              )),
          const SizedBox(height: 20),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
                labelText: "Password",
                fillColor: Colors.black,
                // border: OutlineInputBorder(
                //     borderRadius: new BorderRadius.circular(10),
                //     borderSide: const BorderSide(color: Colors.red))

            ),
          ),
        ],
      ),
    );
  }

  Widget wLoginButton() {
    return GestureDetector(
      onTap: () {


        if(phoneNumberController.text.isEmpty){

          print("--phone_number_is_empty"
          );

          // commonToast("Please Enter Mobile or Email Number");
        }else if(passwordController.text.isEmpty){

          print("--Password_number_is_empty"
          );
          // commonToast("Please Enter Password");
        }else {
          loginViewModel.logInRequest =
              UserLogInRequest(phoneNumberController.text.toString(),
                  passwordController.text.toString(),
                  "sdfag",
                  "fwef",
                  "fraew");

          loginViewModel.callUserLogIn(loginViewModel.logInRequest!);
        }
        // Navigator.pushNamed(context, UtilRoutes.HomeScreen);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 45,
        decoration: BoxDecoration(
          color: ColorConstant.primarycolor,
          borderRadius: BorderRadius.circular(6),
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
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
      },
      child: const Text(
        "Forget Password ? ",
        style: TextStyle(
            color: ColorConstant.primarycolor, fontWeight: FontWeight.bold,fontSize: 15),
      ),
    );
  }

  Widget wTextRegister() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Not Register Yet ?   ",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400,fontSize: 15),
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
                fontSize: 15
            ),
          ),
        )
      ],
    );
  }
}
