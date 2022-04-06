import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/appbar_title_text.dart';

class ViewMoreScreen extends StatefulWidget {
  const ViewMoreScreen({Key? key}) : super(key: key);

  @override
  _DashBordScreenState createState() => _DashBordScreenState();
}

class _DashBordScreenState extends State<ViewMoreScreen> {

  DateTime selectedDateFrom = DateTime.now();
  DateTime selectedDateTo = DateTime.now();

  TextEditingController _txtControllerDateFrom = new TextEditingController();
  TextEditingController _txtControllerDateTo = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            elevation: 0,
            title: Text("View Detail",style: AppBarTitle.myAppbarStyle),
            // automaticallyImplyLeading: false,
            // centerTitle: true,
            backgroundColor: ColorConstant.themColor,
            actions: [IconButton(onPressed: () {
            }, icon: Icon(Icons.wifi_protected_setup_sharp,))
            ],
            systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: ColorConstant.themColor,
              statusBarIconBrightness: Brightness.light,
            )
        ),
        body: ListView(
          children: [
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                w_toolbar(),
                Container(
                  color: Colors.grey,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height/22,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text("Credit",style: TextStyle(fontSize: 15,color: Colors.black),),
                          ),
                        ),
                      ),

                      Container(width: 1,color: Colors.black,),

                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height/22,

                          color: Colors.white,

                          child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text("Debit",style: TextStyle(fontSize: 15,color: Colors.black),),
                        ),
                        ),
                      ),


                    ],
                  ),
                ),

                Container(height: 1,color: Colors.grey,width: double.infinity,),

                Container(
                  color: Colors.grey,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.white,

                          height: MediaQuery.of(context).size.height,

                        ),
                      ),

                      Container(width: 1,color: Colors.black,),

                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          color: Colors.white,


                        ),
                      ),
                    ],
                  ),
                )



              ],
            ),
          ],
        )
    );
  }


  Widget w_toolbar(){
    return Container(
      decoration: const BoxDecoration(
          color: Colors.amber
      ),
      child: Column(
        children: [

          Container(
            margin: EdgeInsets.only(left: 15,right: 15,top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width/3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white)
                  ),
                  child:

                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Center(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Select Date',hintStyle: TextStyle(color: Colors.white),
                        ),

                        style: TextStyle(color: Colors.white),

                        controller: _txtControllerDateFrom,
                        // style:
                        // GoogleFonts.poppins(fontWeight: FontWeight.w600),
                        readOnly: true,
                        onTap: () {
                          _selectDateFrom(context);
                        },
                      ),
                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("TO",style: TextStyle(color: Colors.white),),
                ),


                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width/3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white)
                  ),
                  child:

                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Center(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Select Date',hintStyle: TextStyle(color: Colors.white),
                        ),

                        style: TextStyle(color: Colors.white),

                        controller: _txtControllerDateTo,
                        // style:
                        // GoogleFonts.poppins(fontWeight: FontWeight.w600),
                        readOnly: true,
                        onTap: () {
                          _selectDateTo(context);
                        },
                      ),
                    ),
                  ),
                ),



              ],
            ),
          ),


          Padding(
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
        ],
      ),
    );
  }



  Future<void> _selectDateFrom(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateFrom,
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDateFrom)
      setState(() {
        selectedDateFrom = picked;
        _txtControllerDateFrom.text = DateFormat('yyyy-MM-dd').format(selectedDateFrom);
      });
  }

  Future<void> _selectDateTo(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateTo,
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDateTo)
      setState(() {
        selectedDateTo = picked;
        _txtControllerDateTo.text = DateFormat('yyyy-MM-dd').format(selectedDateTo);
      });
  }
}
