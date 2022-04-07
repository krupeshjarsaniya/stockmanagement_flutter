import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:stoke_management/model/api_response/vepari_list_model.dart';
import 'package:stoke_management/model/api_response/vepari_stock_list_model.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/appbar_title_text.dart';
import 'package:stoke_management/utills/shared_preferences.dart';
import 'package:stoke_management/view_model/vendor_details_viewmodel.dart';

import '../app.dart';
import 'add_transaction.dart';
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

  late VendorDetailsViewModel viewModel;

  TextEditingController _txtControllerDateFrom = new TextEditingController();
  TextEditingController _txtControllerDateTo = new TextEditingController();

  List<CreditModel>? creditList = <CreditModel>[];
  List<CreditModel>? debitList = <CreditModel>[];


  bool debitCheck = false;
  bool creditCheck = false;

  String vepari_id_str = "";
  String user_id_str = "";
  String from_str = "";
  String to_str = "";
  String deviceType_str = "";
  String deviceuid_str = "";
  String token_str = "";




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
              Navigator.push(context, MaterialPageRoute(builder: (context) => EditVendor(vepariId: widget.vepariId.toString(),)));

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

                viewModel.callVepariStockModel(user_id_str.toString(),vepari_id_str.toString());

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


                              Icon(Icons.delete,color: Colors.red,),

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

                              Icon(Icons.delete,color: Colors.red,),


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
                                    value: debitCheck,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        debitCheck = !debitCheck;
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
                                    itemCount: creditList!.length,
                                    itemBuilder: (context, position) {
                                      return Container(
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
                                                      Text(creditList![position].description.toString(),style: TextStyle(color: Colors.red),),


                                                    ],
                                                  ),
                                                  SizedBox(height: 3,),
                                                  Text("geasfgear",style: TextStyle(color: Colors.red),),
                                                  SizedBox(height: 3,),
                                                  Text("geasfgear",style: TextStyle(color: Colors.red),),
                                                  SizedBox(height: 3,),
                                                  Text("geasfgear",style: TextStyle(color: Colors.red),),
                                                  SizedBox(height: 3,),
                                                  Text("geasfgear",style: TextStyle(color: Colors.red),),
                                                ],
                                              ),
                                            ),


                                            SizedBox(height: 5,),
                                            Container(width: double.infinity,height: 1,color: Colors.grey,)

                                          ],
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
                              itemCount: debitList!.length,
                              itemBuilder: (context, position) {
                                return Container(
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
                                                Text("geasfgear",style: TextStyle(color: Colors.green),),


                                              ],
                                            ),
                                            SizedBox(height: 3,),
                                            Text("geasfgear",style: TextStyle(color: Colors.green),),
                                            SizedBox(height: 3,),
                                            Text("geasfgear",style: TextStyle(color: Colors.green),),
                                            SizedBox(height: 3,),
                                            Text("geasfgear",style: TextStyle(color: Colors.green),),
                                            SizedBox(height: 3,),
                                            Text("geasfgear",style: TextStyle(color: Colors.green),),
                                          ],
                                        ),
                                      ),


                                      SizedBox(height: 5,),
                                      Container(width: double.infinity,height: 1,color: Colors.grey,)

                                    ],
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
        // _txtControllerDateFrom.text = DateFormat('yyyy-MM-dd').format(selectedDateFrom);
        _txtControllerDateFrom.text = DateFormat('dd/MM/yyyy').format(selectedDateFrom);
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
      });
  }
}
