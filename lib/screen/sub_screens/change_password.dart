import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/utils_routes.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: ColorConstant.themColor,
            automaticallyImplyLeading: false,
            systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: ColorConstant.themColor,
              statusBarIconBrightness: Brightness.light,
            )
        ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [

              const SizedBox(height: 20,),
              w_TextField(),
              const SizedBox(height: 30,),
              w_ChangePwdButton(),
              // w_SaveButton(),

            ],
          ),
        ),
      ),
    );
  }

  Widget w_TextField(){
    return Column(
      children: const [
        TextField(
          decoration: InputDecoration(
            labelText: ("Old Password"),
            labelStyle: TextStyle(
              fontSize: 15
            )
          ),
        ),

        const SizedBox(height: 20,),

        TextField(
          decoration: InputDecoration(
              labelText: ("New Password"),
              labelStyle: TextStyle(
                  fontSize: 15
              )
          ),
        ),

        const SizedBox(height: 20,),

        TextField(
          decoration: InputDecoration(
              labelText: ("Confirm Password"),
              labelStyle: TextStyle(
                  fontSize: 15
              )
          ),
        ),

      ],
    );
  }

  Widget w_ChangePwdButton() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, UtilRoutes.ProfileScreen);
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
            "Change Password",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Colors.white
            ),),
        ),
      ),
    );
  }

}
