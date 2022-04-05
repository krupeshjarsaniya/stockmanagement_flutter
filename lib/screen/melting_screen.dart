import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stoke_management/utills/appbar_title_text.dart';
import 'package:stoke_management/utills/color_constant.dart';

class MeltingScreen extends StatefulWidget {
  const MeltingScreen({Key? key}) : super(key: key);

  @override
  _MeltingScreenState createState() => _MeltingScreenState();
}

class _MeltingScreenState extends State<MeltingScreen> {

  bool eng = false;
  bool guj = false;
  bool hin = false;
  bool ben = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Gold Melting", style: AppBarTitle.myAppbarStyle),
        actions: [
          Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text("History", style: TextStyle(fontSize: 20,color: Colors.white)),
          ))
        ],
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: ColorConstant.themColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: ColorConstant.themColor,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
        child: ListView(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              cursorColor: Colors.yellow,
              decoration: InputDecoration(
                labelText: "Enter Weight(Separate With Spaces)",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              cursorColor: Colors.yellow,
              decoration: InputDecoration(
                labelText: "Enter Touch(Separate With Spaces)",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorConstant.themColor!),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              cursorColor: Colors.yellow,
              decoration: InputDecoration(
                labelText: "Enter Output Touch(Separate With Spaces)",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorConstant.themColor!),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: ColorConstant.themColor!)
              ),
            ),
            SizedBox(height: 20),
            Container(
              color: ColorConstant.themColor,
              height: 60,
              child: Center(
                  child: Text("CALCULATE",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
            ),
            SizedBox(height: 20),
            Text("Select Your Language",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 4,
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        eng = true;
                        guj = false;
                        hin = false;
                        ben = false;
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: ColorConstant.themColor!),
                        color: eng ? ColorConstant.themColor : Colors.white,
                      ),
                      child: Center(child: Text("English",style: TextStyle(fontSize: 16,letterSpacing: 1),)),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 4,
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        guj = true;
                        eng = false;
                        hin = false;
                        ben = false;
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: ColorConstant.themColor!),
                        color: guj ? ColorConstant.themColor : Colors.white,
                      ),
                      child: Center(child: Text("ગુજરાતી",style: TextStyle(fontSize: 16,letterSpacing: 1),)),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 4,
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        hin = true;
                        eng = false;
                        guj = false;
                        ben = false;
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: ColorConstant.themColor!),
                        color: hin ? ColorConstant.themColor : Colors.white,
                      ),
                      child: Center(child: Text("हिन्दी",style: TextStyle(fontSize: 16,letterSpacing: 1),)),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 4,
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        ben = true;
                        eng = false;
                        guj = false;
                        hin = false;
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: ColorConstant.themColor!),
                        color: ben ? ColorConstant.themColor : Colors.white,
                      ),
                      child: Center(child: Text("বাংলা",style: TextStyle(fontSize: 16,letterSpacing: 1),)),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
