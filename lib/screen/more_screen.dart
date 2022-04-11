import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/appbar_title_text.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
            title: Text("More",style: AppBarTitle.myAppbarStyle),
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: ColorConstant.themColor,
            systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: ColorConstant.themColor,
              statusBarIconBrightness: Brightness.light,
            )
        ),
      body: Column(
        children: [
          const SizedBox(height: 20.0,),
          w_ShareApp(),
          const SizedBox(height: 2,),
          w_rateFeedback(),
          const SizedBox(height: 2,),
          w_payment(),
        ],
      ),
    );
  }

  Widget w_ShareApp(){
    return InkWell(
      onTap: (){
        Share.share("https://play.google.com/store/apps/details?id=com.app.stockmanagement");
        // Navigator.push(context, CupertinoPageRoute(builder: (context) => EditProfile()));
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
                  "Share App"
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
  Widget w_rateFeedback(){
    return InkWell(
      onTap: (){
        StoreRedirect.redirect(
          androidAppId: "com.app.stockmanagement",
          iOSAppId: "",
        );
        // Navigator.push(context, CupertinoPageRoute(builder: (context) => EditProfile()));
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
                  "Rate and Feedback"
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
  Widget w_payment(){
    return InkWell(
      onTap: (){
        launch("tel://9925755626");
        // Navigator.push(context, CupertinoPageRoute(builder: (context) => EditProfile()));
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
                  "Call Now (9925755626)"
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

}
