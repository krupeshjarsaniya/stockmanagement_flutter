import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:stoke_management/model/api_request/delete_stoke_request.dart';
import 'package:stoke_management/model/api_request/vepari_stock_list_request.dart';
import 'package:stoke_management/model/api_response/dashbord_model.dart';
import 'package:stoke_management/model/api_response/vepari_list_model.dart';
import 'package:stoke_management/model/api_response/vepari_stock_list_model.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/appbar_title_text.dart';
import 'package:stoke_management/utills/shared_preferences.dart';
import 'package:stoke_management/view_model/vendor_details_viewmodel.dart';

import '../app.dart';
import 'add_transaction.dart';
import 'edit_transaction_screen.dart';
import 'edit_vendor.dart';

class VenderDetailsScreen extends StatefulWidget {
  String? vepariId;
  String? first_name;
  String? last_name;
  String? mobile;
  String? company_name;
  String? address;
  String? email;
  VenderDetailsScreen({this.vepariId,this.first_name,this.last_name,this.mobile,this.company_name,this.address,this.email});
  // const VenderDetailsScreen({Key? key}) : super(key: key);

  @override
  VenderDetailsScreenState createState() => VenderDetailsScreenState();
}

class VenderDetailsScreenState extends State<VenderDetailsScreen> {

  DateTime selectedDateFrom = DateTime.now();
  DateTime selectedDateTo = DateTime.now();

  DashBordModel dashBordModel = DashBordModel();

  late VendorDetailsViewModel viewModel;

  TextEditingController _txtControllerDateFrom = new TextEditingController();
  TextEditingController _txtControllerDateTo = new TextEditingController();

  List<CreditModel>? creditList = <CreditModel>[];
  List<DebitModel>? debitList = <DebitModel>[];

  bool debitCheck = false;
  bool creditCheck = false;
  String vepari_id_str = "";
  String user_id_str = "";
  String from_str = "";
  String to_str = "";
  String deviceType_str = "";
  String deviceuid_str = "";
  String token_str = "";

  List<String> delete_list_credit = [];
  List<String> delete_list_debit = [];

  var csvBuilder = StringBuffer();
  var SEPARATOR = ",";

  @override
  void initState() {
    super.initState();
    init();
    // scrollController.addListener(pagination);
    Future.delayed(Duration.zero, () {
      /*model ??*/ (viewModel = VendorDetailsViewModel(this));
    });
  }




  Future<Void?> init() async {
    var userId = await Shared_Preferences.prefGetString(App.KEY_USER_ID, "");
    var userDeviceType = await Shared_Preferences.prefGetString(App.KEY_DEVICE_TYPE, "");
    var userDeviceUID = await Shared_Preferences.prefGetString(App.KEY_DEVICE_ID, "");
    var userDeviceToken = await Shared_Preferences.prefGetString(App.KEY_DEVICE_TOKEN, "");
    print("----userId---");
    print("----userId---" + userId.toString());

    setState(() {

      _txtControllerDateFrom = TextEditingController(text: "${selectedDateFrom.day}/${selectedDateFrom.month}/${selectedDateFrom.year}" );
      _txtControllerDateFrom.selection = TextSelection.fromPosition(TextPosition(offset: _txtControllerDateFrom.text.length));

      _txtControllerDateTo = TextEditingController(text: "${selectedDateTo.day}/${selectedDateTo.month}/${selectedDateTo.year}" );
      _txtControllerDateTo.selection = TextSelection.fromPosition(TextPosition(offset: _txtControllerDateTo.text.length));

      vepari_id_str = widget.vepariId.toString();
      user_id_str = userId.toString();
      from_str = _txtControllerDateFrom.text.toString();
      to_str = _txtControllerDateTo.text.toString();
      deviceType_str = userDeviceType.toString();
      deviceuid_str = userDeviceUID.toString();
      token_str = userDeviceToken.toString();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            elevation: 0,
            title: GestureDetector(onTap : (){

              // String? vepariId;
              // String? first_name;
              // String? last_name;
              // String? mobile;
              // String? company_name;
              // String? address;
              // String? email;
              Navigator.push(context, MaterialPageRoute(builder: (context) =>

                  EditVendor(vepariId: widget.vepariId.toString(),
                    first_name: widget.first_name.toString(),
                    last_name: widget.last_name.toString(),
                    mobile: widget.mobile.toString(),
                    company_name: widget.company_name.toString(),
                    address: widget.address.toString(),
                    email: widget.email.toString(),

                  )));

            },child: Text(widget.first_name.toString(),style: AppBarTitle.myAppbarStyle,)),

            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),

            // centerTitle: true,
            backgroundColor: ColorConstant.themColor,
            actions: [
              IconButton(onPressed: () {

                setState(() {
                  creditList!.clear();
                  debitList!.clear();
                });
                viewModel.vepariStockListRequest = VepariStockListRequest(widget.vepariId.toString(), user_id_str.toString(), _txtControllerDateFrom.text.toString(), _txtControllerDateTo.text.toString(), deviceType_str.toString(), deviceuid_str.toString(), token_str.toString());
                viewModel.callVepariStockModel(viewModel.vepariStockListRequest!);

              }, icon: Icon(Icons.wifi_protected_setup_sharp,)),
              IconButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddTransactionScreen(
                    vepariId: widget.vepariId.toString(),
                    first_name: widget.first_name.toString(),
                    last_name: widget.last_name.toString(),
                    mobile: widget.mobile.toString(),
                    company_name: widget.company_name.toString(),
                    address: widget.address.toString(),
                    email: widget.email.toString()

                )));


              }, icon: Icon(Icons.add,)),
              Padding(
                padding:  EdgeInsets.only(right: 10),
                child: IconButton(onPressed: () {}, icon: Icon(Icons.assignment_outlined,)),
              ),
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
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text("Credit",style: TextStyle(fontSize: 15,color: Colors.black),),
                                ),
                              ),

                              Visibility(visible : delete_list_credit.length != 0 ? true :false,
                                  child:
                                  GestureDetector(onTap:(){




                                    if(delete_list_credit != null && !delete_list_credit.isEmpty){

                                      for(int i = 0 ; i< delete_list_credit.length; i++){
                                        var id  = delete_list_credit[i];
                                        csvBuilder.write(id);
                                        csvBuilder.write(SEPARATOR);
                                      }

                                      var delete_item = csvBuilder.toString() ;
                                      delete_item = delete_item.substring(
                                          0, delete_list_credit.length - SEPARATOR.length
                                      );   //remove last comma
                                      // viewModel.callDeleteStock(delete_item);

                                      print("--delete_item--");
                                      print("--delete_item--" + delete_item.toString());
                                      var newDeItem =  delete_item.replaceAll(",", "");
                                      viewModel.deleteStockRequest = DeleteStockRequest(newDeItem);
                                      viewModel.callDeleteStock(viewModel.deleteStockRequest!);
                                    }
                                    else {
                                      print("---ewaf----");
                                    }

                                  }



                                      ,child: Icon(Icons.delete,color: Colors.red,))),

                              Theme(
                                data: ThemeData(
                                  unselectedWidgetColor: Colors.grey,
                                  checkboxTheme: CheckboxThemeData(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                                child: Transform.scale(
                                  scale: 1.1,
                                  child: Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: Colors.amber,
                                    // value: notificationData[index].isCheck,
                                    value: creditCheck,
                                    onChanged: (bool? value) {
                                      setState(() {

                                        creditCheck = !creditCheck;

                                        if(creditCheck) {
                                          for (int i = 0; i <
                                              creditList!.length; i++) {
                                            creditList![i].isCheck = true;
                                          }
                                        }else{
                                          for (int i = 0; i <
                                              creditList!.length; i++) {

                                            setState(() {
                                              // delete_list_credit.clear();
                                            });
                                            creditList![i].isCheck = false;
                                          }
                                        }

                                        // creditCheck = !creditCheck;
                                        // notificationData[index].isCheck = value!;
                                        //
                                        //
                                        // if(notificationData[index].isCheck == true){
                                        //   // delete_list.clear();
                                        //   delete_list.add(notificationData[index].id.toString());
                                        //   print("----notificationlist------" + delete_list.length.toString());
                                        //   print("----notificationId------" + notificationData[index].id.toString());
                                        // }else{
                                        //   delete_list.remove(notificationData[index].id.toString());
                                        //   print("----notificationlist------" + delete_list.length.toString());
                                        //   print("----notificationId------" + notificationData[index].id.toString());
                                        // }

                                      });
                                    },
                                  ),
                                ),
                              ),


                            ],
                          ),
                        ),
                      ),



                      Container(width: 1,color: Colors.black,),

                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height/22,

                          color: Colors.white,

                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text("Debit",style: TextStyle(fontSize: 15,color: Colors.black),),

                                ),
                              ),

                              Visibility(
                                visible: delete_list_debit.length != 0 ? true : false,
                                  child: GestureDetector(

                                      onTap: (){


                                        if(delete_list_debit != null && !delete_list_debit.isEmpty){

                                          for(int i = 0 ; i< delete_list_debit.length; i++){
                                            var id  = delete_list_debit[i];
                                            csvBuilder.write(id);
                                            csvBuilder.write(SEPARATOR);
                                          }

                                          var delete_item = csvBuilder.toString() ;
                                          delete_item = delete_item.substring(
                                              0, delete_list_debit.length - SEPARATOR.length
                                          );   //remove last comma
                                          // viewModel.callDeleteStock(delete_item);

                                          print("--delete_item--");
                                          print("--delete_item--" + delete_item.toString());
                                          var newDeItem =  delete_item.replaceAll(",", "");
                                          viewModel.deleteStockRequest = DeleteStockRequest(newDeItem);
                                          viewModel.callDeleteStock(viewModel.deleteStockRequest!);

                                        }
                                        else {
                                          print("---ewaf----");
                                        }
                                      },
                                      child: Icon(Icons.delete,color: Colors.red,))),


                              Theme(
                                data: ThemeData(
                                  unselectedWidgetColor: Colors.grey,
                                  checkboxTheme: CheckboxThemeData(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                                child: Transform.scale(
                                  scale: 1.1,
                                  child: Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: Colors.amber,
                                    // value: notificationData[index].isCheck,
                                    value:  debitCheck,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        debitCheck = !debitCheck;

                                        if(debitCheck) {
                                          for (int i = 0; i <
                                              debitList!.length; i++) {
                                            debitList![i].isCheck = true;
                                          }
                                        }else{
                                          for (int i = 0; i <
                                              debitList!.length; i++) {
                                            debitList![i].isCheck = false;
                                          }
                                        }


                                        // notificationData[index].isCheck = value!;
                                        //
                                        //
                                        // if(notificationData[index].isCheck == true){
                                        //   // delete_list.clear();
                                        //   delete_list.add(notificationData[index].id.toString());
                                        //   print("----notificationlist------" + delete_list.length.toString());
                                        //   print("----notificationId------" + notificationData[index].id.toString());
                                        // }else{
                                        //   delete_list.remove(notificationData[index].id.toString());
                                        //   print("----notificationlist------" + delete_list.length.toString());
                                        //   print("----notificationId------" + notificationData[index].id.toString());
                                        // }

                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
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
                                            vepari_id: widget.vepariId.toString(),
                                            description:creditList![position].description.toString(),
                                          )));
                                        },
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(0.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(child: Padding(
                                                          padding:  EdgeInsets.only(left: 10),
                                                          child: Text(date_to.toString(),style: TextStyle(color: Colors.red),),
                                                        )),
                                                        Theme(
                                                          data: ThemeData(
                                                            unselectedWidgetColor: Colors.grey,
                                                            checkboxTheme: CheckboxThemeData(
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(2),
                                                              ),
                                                            ),
                                                          ),
                                                          child: Transform.scale(
                                                            scale: 1.1,
                                                            child: Checkbox(
                                                              checkColor: Colors.white,
                                                              activeColor: Colors.amber,
                                                              // value: notificationData[index].isCheck,
                                                              value: creditList![position].isCheck,
                                                              onChanged: (bool? value) {
                                                                setState(() {
                                                                  creditList![position].isCheck = value!;
                                                                  if(creditList![position].isCheck == true){
                                                                    // delete_list.clear();
                                                                    delete_list_credit.add(creditList![position].stockId.toString());
                                                                    print("----notificationlist------" + delete_list_credit.length.toString());
                                                                    print("----notificationId------" + creditList![position].stockId.toString());
                                                                  }else{
                                                                    delete_list_credit.remove(creditList![position].stockId.toString());
                                                                    print("----notificationlist------" + delete_list_credit.length.toString());
                                                                    print("----notificationId------" + creditList![position].stockId.toString());
                                                                  }

                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                    // SizedBox(height: 3,),
                                                    Padding(
                                                      padding:  EdgeInsets.only(left: 10),
                                                      child: Text("${ creditList![position].description.toString()}",style: TextStyle(color: Colors.red),),
                                                    ),
                                                    SizedBox(height: 3,),
                                                    Padding(
                                                      padding:  EdgeInsets.only(left: 10),
                                                      child: Text("${"Weight: "}  ${creditList![position].weight.toString()} ${"G"}",style: TextStyle(color: Colors.red),),
                                                    ),
                                                    SizedBox(height: 3,),
                                                    Padding(
                                                      padding:  EdgeInsets.only(left: 10),
                                                      child: Text("${"Touch: "}${creditList![position].touch.toString()} ${"T"}",style: TextStyle(color: Colors.red),),
                                                    ),
                                                    SizedBox(height: 3,),
                                                    Padding(
                                                      padding:  EdgeInsets.only(left: 10),
                                                      child: Text("${"Fine Weight: "}${creditList![position].fineWeight.toString()} ${"G"}",style: TextStyle(color: Colors.red),),
                                                    ),
                                                    SizedBox(height: 3,),

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

                      Container(width: 1,color: Colors.black,),

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
                                      vepari_id: widget.vepariId.toString(),
                                      description:debitList![position].description.toString(),
                                    )));
                                  },
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,

                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:  EdgeInsets.only(left: 10),
                                                      child: Text(date_to.toString(),style: TextStyle(color: Colors.green),),
                                                    ),
                                                  ),
                                                  Theme(
                                                    data: ThemeData(
                                                      unselectedWidgetColor: Colors.grey,
                                                      checkboxTheme: CheckboxThemeData(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(2),
                                                        ),
                                                      ),
                                                    ),
                                                    child: Transform.scale(
                                                      scale: 1.1,
                                                      child: Checkbox(
                                                        checkColor: Colors.white,
                                                        activeColor: Colors.amber,
                                                        // value: notificationData[index].isCheck,
                                                        value: debitList![position].isCheck,
                                                        onChanged: (bool? value) {
                                                          setState(() {
                                                            debitList![position].isCheck = value!;
                                                            if(debitList![position].isCheck == true){
                                                              // delete_list.clear();
                                                              delete_list_debit.add(debitList![position].stockId.toString());
                                                              print("----debitList------" + delete_list_debit.length.toString());
                                                              print("----debitStockId------" + debitList![position].stockId.toString());
                                                            }else{
                                                              delete_list_debit.remove(debitList![position].stockId.toString());
                                                              print("----debitList------" + delete_list_debit.length.toString());
                                                              print("----debitStockId------" + debitList![position].stockId.toString());
                                                            }


                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                              // SizedBox(height: 3,),
                                              Padding(
                                                padding:  EdgeInsets.only(left: 10),
                                                child: Text("${ debitList![position].description.toString()}",style: TextStyle(color: Colors.green),),
                                              ),
                                              SizedBox(height: 3,),
                                              Padding(
                                                padding:  EdgeInsets.only(left: 10),
                                                child: Text("${"Weight: "}  ${debitList![position].weight.toString()} ${"G"}",style: TextStyle(color: Colors.green),),
                                              ),
                                              SizedBox(height: 3,),
                                              Padding(
                                                padding:  EdgeInsets.only(left: 10),
                                                child: Text("${"Touch: "} ${debitList![position].touch.toString()} ${"T"}",style: TextStyle(color: Colors.green),),
                                              ),
                                              SizedBox(height: 3,),
                                              Padding(
                                                padding:  EdgeInsets.only(left: 10),
                                                child: Text("${"Fine Weight: "}${debitList![position].fineWeight.toString()} ${"G"}",style: TextStyle(color: Colors.green),),
                                              ),
                                              SizedBox(height: 3,),

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
                Container(
                  child : Column(
                    children:  [
                      Text(
                        "CREDIT",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),

                      SizedBox(height: 5,),
                      Text(
                        " ${dashBordModel.totalCredit.toString()} ${"G"}",
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
                    children:  [
                      Text(
                        "DEBIT",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),

                      SizedBox(height: 5,),

                      Text(
                        " ${dashBordModel.totalDebit.toString()} ${"G"}",
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
                    children:  [
                      Text(
                        "BALANCE",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),

                      SizedBox(height: 5,),

                      Text(
                        " ${dashBordModel.balance.toString()} ${"G"}",
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
        // _txtControllerDateFrom.text = DateFormat('yyyy-MM-dd').format(selectedDateFrom);
        _txtControllerDateFrom.text = DateFormat('dd/MM/yyyy').format(selectedDateFrom);
        creditList!.clear();
        debitList!.clear();

        viewModel.vepariStockListRequest = VepariStockListRequest(widget.vepariId.toString(), user_id_str.toString(), _txtControllerDateFrom.text.toString(), _txtControllerDateTo.text.toString(), deviceType_str.toString(), deviceuid_str.toString(), token_str.toString());
        viewModel.callVepariStockModel(viewModel.vepariStockListRequest!);
        // viewModel.c
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
        _txtControllerDateTo.text = DateFormat('dd/MM/yyyy').format(selectedDateTo);
        creditList!.clear();
        debitList!.clear();
        viewModel.vepariStockListRequest = VepariStockListRequest(widget.vepariId.toString(), user_id_str.toString(), _txtControllerDateFrom.text.toString(), _txtControllerDateTo.text.toString(), deviceType_str.toString(), deviceuid_str.toString(), token_str.toString());
        viewModel.callVepariStockModel(viewModel.vepariStockListRequest!);
      });
  }
}
