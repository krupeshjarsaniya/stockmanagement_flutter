import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:stoke_management/model/api_request/Full_more_Request.dart';
import 'package:stoke_management/model/api_response/view_more_model.dart';
import 'package:stoke_management/utills/appbar_title_text.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/shared_preferences.dart';
import 'package:stoke_management/view_model/view_more_model.dart';

import '../app.dart';
import 'edit_transaction_screen.dart';

class ViewMoreScreen extends StatefulWidget {
  String? totalCredit;
  String? totalDebit;
  String? totalBalance;
  ViewMoreScreen({this.totalCredit,this.totalDebit,this.totalBalance});


  // const ViewMoreScreen({Key? key}) : super(key: key);

  @override
  ViewMoreScreenState createState() => ViewMoreScreenState();
}

class ViewMoreScreenState extends State<ViewMoreScreen> {
  DateTime selectedDateFrom = DateTime.now();
  DateTime selectedDateTo = DateTime.now();

  TextEditingController _txtControllerDateFrom = new TextEditingController();
  TextEditingController _txtControllerDateTo = new TextEditingController();

  List<CreditModel>? creditList = <CreditModel>[];
  List<CreditModel>? debitList = <CreditModel>[];

  String? USER_ID;
  String? DEVICE_TYPE;
  String? DEVICE_ID;

  FullViewDetailModel fullViewDetailModel = FullViewDetailModel();
  late ViewMoreViewModel model;

  @override
  void initState() {
    super.initState();
    init();
    // scrollController.addListener(pagination);
    Future.delayed(Duration.zero, () {
      /*model ??*/ (model = ViewMoreViewModel(this));
    });
  }

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
            actions: [
              IconButton(
                  onPressed: () {
                model.viewDetailrequest = FullViewDetailrequest(
                    USER_ID.toString(),
                    _txtControllerDateFrom.text.toString(),
                    _txtControllerDateTo.text.toString(),
                    DEVICE_TYPE.toString(),
                    DEVICE_ID.toString()
                );
                model.callFullView(model.viewDetailrequest!);


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
                          child:  ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics:
                              const NeverScrollableScrollPhysics(),
                              itemCount: creditList!.length,
                              itemBuilder: (context, position) {

                                String date_to =creditList![position].date!.substring(8,10)+"/"+""+creditList![position].date!.substring(5,7)+"/"+creditList![position].date!.substring(0,4);


                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditTransactionScreen(
                                      stock_id: creditList![position].stockId.toString(),
                                      debit_credit: creditList![position].debitCredit.toString(),
                                      weight: creditList![position].weight.toString(),
                                      touch: creditList![position].touch.toString(),
                                      fine_weight: creditList![position].fineWeight.toString(),
                                      stock_date: date_to.toString(),
                                      vepari_id: creditList![position].vepariId.toString(),
                                      description:creditList![position].description.toString(),
                                    )));
                                  },
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,

                                            children: [
                                              Row(
                                                children: [
                                                  Text(date_to.toString(),style: TextStyle(color: Colors.red),),
                                                ],
                                              ),
                                              SizedBox(height: 3,),
                                              Text("${ creditList![position].description.toString()}",style: TextStyle(color: Colors.red),),
                                              SizedBox(height: 3,),
                                              Text("${"Weight: "}  ${creditList![position].weight.toString()} ${"G"}",style: TextStyle(color: Colors.red),),
                                              SizedBox(height: 3,),
                                              Text("${"Touch: "} + ${creditList![position].touch.toString()} ${"T"}",style: TextStyle(color: Colors.red),),
                                              SizedBox(height: 3,),
                                              Text("${"Fine Weight: "} + ${creditList![position].fineWeight.toString()} ${"G"}",style: TextStyle(color: Colors.red),),
                                            ],
                                          ),
                                        ),


                                        SizedBox(height: 5,),
                                        Container(width: double.infinity,height: 1,color: Colors.grey,)

                                      ],
                                    ),
                                  ),
                                );
                              }
                          ),

                        ),
                      ),

                      Container(width: 1,color: Colors.grey,),
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          color: Colors.white,
                          child:  ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics:
                              const NeverScrollableScrollPhysics(),
                              itemCount: debitList!.length,
                              itemBuilder: (context, position) {
                                String date_to =debitList![position].date!.substring(8,10)+"/"+""+debitList![position].date!.substring(5,7)+"/"+debitList![position].date!.substring(0,4);


                                return

                                  GestureDetector(
                                    onTap: (){
                                      print("---credit_debit---" + debitList![position].debitCredit.toString() );
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditTransactionScreen(
                                        stock_id: debitList![position].stockId.toString(),
                                        debit_credit: debitList![position].debitCredit.toString(),
                                        weight: debitList![position].weight.toString(),
                                        touch: debitList![position].touch.toString(),
                                        fine_weight: debitList![position].fineWeight.toString(),
                                        stock_date: date_to.toString(),
                                        vepari_id:debitList![position].vepariId.toString(),
                                        description:debitList![position].description.toString(),
                                      )));
                                    },
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,

                                              children: [
                                                Row(
                                                  children: [
                                                    Text(date_to.toString(),style: TextStyle(color: Colors.green),),
                                                  ],
                                                ),
                                                SizedBox(height: 3,),
                                                Text("${ debitList![position].description.toString()}",style: TextStyle(color: Colors.green),),
                                                SizedBox(height: 3,),
                                                Text("${"Weight: "}  ${debitList![position].weight.toString()} ${"G"}",style: TextStyle(color: Colors.green),),
                                                SizedBox(height: 3,),
                                                Text("${"Touch: "} + ${debitList![position].touch.toString()} ${"T"}",style: TextStyle(color: Colors.green),),
                                                SizedBox(height: 3,),
                                                Text("${"Fine Weight: "} + ${debitList![position].fineWeight.toString()} ${"G"}",style: TextStyle(color: Colors.green),),
                                              ],
                                            ),
                                          ),


                                          SizedBox(height: 5,),
                                          Container(width: double.infinity,height: 1,color: Colors.grey,)

                                        ],
                                      ),
                                    ),
                                  );
                              }
                          ),

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
            padding:  EdgeInsets.only(top: 25,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    child : Column(
                      children:  [
                        Text(
                          "CREDIT",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),

                        SizedBox(height: 5,),
                        Text("${ widget.totalCredit.toString()} ${"G"}",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  height: 35,
                  width: 1,
                  color: Colors.white,
                ),

                Expanded(
                  child: Container(
                    child : Column(
                      children:  [
                        Text(
                          "DEBIT",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                        SizedBox(height: 5,),

                        Text(
    "${ widget.totalDebit.toString()} ${"G"}",style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  height: 35,
                  width: 1,
                  color: Colors.white,
                ),

                Expanded(
                  child: Container(
                    child : Column(
                      children:  [
                        Text(
                          "BALANCE",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                        SizedBox(height: 5,),

                        Text(
    "${ widget.totalBalance.toString()} ${"G"}",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),

                      ],
                    ),
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
        // _txtControllerDateFrom.text = DateFormat('yyyy-MM-dd').format(selectedDateFrom);
        _txtControllerDateFrom.text = DateFormat('dd/MM/yyyy').format(selectedDateFrom);

        model.viewDetailrequest = FullViewDetailrequest(USER_ID.toString(),_txtControllerDateFrom.text.toString(),_txtControllerDateTo.text.toString(),DEVICE_TYPE.toString(),DEVICE_ID.toString());
        model.callFullView(model.viewDetailrequest!);

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
        _txtControllerDateTo.text =
            DateFormat('dd/MM/yyyy').format(selectedDateTo);

        model.viewDetailrequest = FullViewDetailrequest(USER_ID.toString(),_txtControllerDateFrom.text.toString(),_txtControllerDateTo.text.toString(),DEVICE_TYPE.toString(),DEVICE_ID.toString());
        model.callFullView(model.viewDetailrequest!);
      });
  }

  Future<Void?> init() async {
    var userId = await Shared_Preferences.prefGetString(App.KEY_USER_ID, "");
    var deviceType =
        await Shared_Preferences.prefGetString(App.KEY_DEVICE_TYPE, "");
    var deviceId =
        await Shared_Preferences.prefGetString(App.KEY_DEVICE_ID, "");

    setState(() {
      _txtControllerDateFrom = TextEditingController(text: "${selectedDateFrom.day}/${selectedDateFrom.month}/${selectedDateFrom.year}" );
      _txtControllerDateFrom.selection = TextSelection.fromPosition(TextPosition(offset: _txtControllerDateFrom.text.length));

      _txtControllerDateTo = TextEditingController(text: "${selectedDateTo.day}/${selectedDateTo.month}/${selectedDateTo.year}" );
      _txtControllerDateTo.selection = TextSelection.fromPosition(TextPosition(offset: _txtControllerDateTo.text.length));

      USER_ID = userId.toString();
      DEVICE_TYPE = deviceType.toString();
      DEVICE_ID = deviceId.toString();
    });
  }
}
