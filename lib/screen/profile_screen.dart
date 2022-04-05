import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stoke_management/screen/sub_screens/change_password.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/screen/sub_screens/edit_profile.dart';
import 'package:stoke_management/utills/appbar_title_text.dart';
import 'package:stoke_management/utills/utils_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          title: Text("Profile", style: AppBarTitle.myAppbarStyle),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: ColorConstant.themColor,
          systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: ColorConstant.themColor,
            statusBarIconBrightness: Brightness.light,
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            w_UserDetail(),
            const SizedBox(height: 15,),
            w_ProfileSetting(),
            const SizedBox(height: 1.5,),
            w_PasswordSetting(),
            const SizedBox(height: 1.5,),
            w_PurchasePlan(),
            const SizedBox(height: 15,),
            w_Logout(),
          ],
        ),
      ),
    );
  }


  Widget w_UserDetail() {
    return Container(
      height: 100,
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Container(
              width: 75,
              height: 75,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: Colors.grey),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 110,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "User Name",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 5,),
                  Text("useremailaddress@gmail.com"),
                ],
              ),
            )
          ],
        ),
    );
  }

  Widget w_ProfileSetting(){
    return InkWell(
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context) => EditProfile()));
      },
      child: Container(
        color: Colors.white,
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children:  [
            Container(
              margin: EdgeInsets.only(left: 15),
              child: const Text(
                "Profile Settings"
              ),
            ),

            Container(
              margin: EdgeInsets.only(right: 15),
                child:
                const Icon(
                    Icons.keyboard_arrow_right,
                  color: Colors.grey,
                )
            )
          ],
        ),
      ),
    );
  }

  Widget w_PasswordSetting(){
    return InkWell(
      onTap: (){Navigator.push(context, CupertinoPageRoute(builder: (context) => ChangePassword()));
      },
      child: Container(
        color: Colors.white,
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children:  [
            Container(
              margin: EdgeInsets.only(left: 15),
              child: const Text(
                "Password Settings"
              ),
            ),

            Container(
              margin: EdgeInsets.only(right: 15),
                child:
                const Icon(
                    Icons.keyboard_arrow_right,
                  color: Colors.grey,

                )
            )
          ],
        ),
      ),
    );
  }

  Widget w_PurchasePlan(){
    return InkWell(
      onTap: (){},
      child: Container(
        color: Colors.white,
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children:  [
            Container(
              margin: EdgeInsets.only(left: 15),
              child: const Text(
                "Purchage Plan"
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget w_Logout(){
    return InkWell(
      onTap: (){},
      child: Container(
        alignment: Alignment.center,
        color: Colors.white,
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Container(
          child: const Text(
            "Logout"
          ),
        ),
      ),
    );
  }
}
