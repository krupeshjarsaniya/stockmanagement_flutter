import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/appbar_title_text.dart';

class DashBordScreen extends StatefulWidget {
  const DashBordScreen({Key? key}) : super(key: key);

  @override
  _DashBordScreenState createState() => _DashBordScreenState();
}

class _DashBordScreenState extends State<DashBordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
            title: Text("Dashbord",style: AppBarTitle.myAppbarStyle),
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: ColorConstant.themColor,
            systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: ColorConstant.themColor,
              statusBarIconBrightness: Brightness.light,
            )
        ),
      body: Container(
        margin: EdgeInsets.only(bottom: 90),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          w_toolbar(),
          w_stockCount(),
          w_viewDetailButton(),
        ],
      ),
      )
    );
  }


  Widget w_toolbar(){
    return Container(
      decoration: const BoxDecoration(
        color: Colors.amber
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 25,bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child : Column(
                children: const [
                  Text(
                    "CREDIT",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),

                  SizedBox(height: 5,),
                  Text(
                    "0.0 G",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),

            Container(
              height: 35,
              width: 1,
              color: Colors.white,
            ),

            Container(
              child : Column(
                children: const [
                  Text(
                    "DEBIT",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),

                  SizedBox(height: 5,),

                  Text(
                    "0.0 G",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),

            Container(
              height: 35,
              width: 1,
              color: Colors.white,
            ),

            Container(
              child : Column(
                children: const [
                  Text(
                    "BALANCE",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),

                  SizedBox(height: 5,),

                  Text(
                    "0.0 G",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget w_stockCount(){
    return Container(
      child: Column(
        children: const [
          Text("0.0"),
          Text("Stock"),
        ],
      ),
    );
  }

  Widget w_viewDetailButton(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.circle,color: Colors.lightGreenAccent,size: 12,),
              SizedBox(width: 3,),
              Text("Credit",style: TextStyle(color: Colors.black,fontSize: 10),),
              SizedBox(width: 8,),
              Icon(Icons.circle,color: Colors.yellow,size: 12,),
              SizedBox(width: 3,),
              Text("Debiit",style: TextStyle(color: Colors.black,fontSize: 10),),
            ],
          ),
        ),
        SizedBox(height: 10,),
        Container(
          height: 30,
          width: 120,
          child: const Center(child: Text("View Detail",style: TextStyle(color: Colors.white),)),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(5)
          ),
        ),
      ],
    );
  }
}
