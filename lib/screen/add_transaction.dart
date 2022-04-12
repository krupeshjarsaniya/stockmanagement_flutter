import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:stoke_management/model/api_request/add_transaction_request.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/appbar_title_text.dart';
import 'package:stoke_management/utills/shared_preferences.dart';
import 'package:stoke_management/view_model/add_transaction_view_model.dart';
import 'package:stoke_management/widgets/common_toast.dart';
import '../app.dart';

class AddTransactionScreen extends StatefulWidget {
  String? vepariId;
  String? first_name;
  String? last_name;
  String? mobile;
  String? company_name;
  String? address;
  String? email;

  AddTransactionScreen({this.vepariId,this.first_name,this.last_name,this.mobile,this.company_name,this.address,this.email});



  // const AddTransactionScreen({Key? key}) : super(key: key);

  @override
  AddTransactionScreenState createState() => AddTransactionScreenState();
}

class AddTransactionScreenState extends State<AddTransactionScreen> {
  DateTime selectedDateFrom = DateTime.now();
  DateTime selectedDateTo = DateTime.now();
  late AddTransactionViewModel viewModel;
  TextEditingController dateController =  TextEditingController();
  TextEditingController descriptionController =  TextEditingController();
  TextEditingController weightController =  TextEditingController();
  TextEditingController touchController =  TextEditingController();
  TextEditingController fineweightController =  TextEditingController();

  bool creditTab = true;
  bool debitTab = false;


  String? DEVICE_TYPE;
  String? DEVICE_ID;
  String? DEVICE_TOKEN;
  String? USER_ID;
  String? type;



  @override
  void initState() {
    super.initState();

    init();
    // scrollController.addListener(pagination);

    Future.delayed(Duration.zero, () {
      /*model ??*/ (viewModel = AddTransactionViewModel(this));
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
            title: Text("Add Transaction",style: AppBarTitle.myAppbarStyle,),

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
                  margin: EdgeInsets.only(top: 10,left: 10),
                  alignment: Alignment.topLeft,
                  child: Text("Transaction Type",style: TextStyle(color: Colors.amber,fontSize: 15,fontWeight: FontWeight.bold),),
                ),

                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            touchController = TextEditingController(text: "100" );
                            touchController.selection = TextSelection.fromPosition(TextPosition(offset: touchController.text.length));

                            fineweightController = TextEditingController(text: "0" );
                            fineweightController.selection = TextSelection.fromPosition(TextPosition(offset: fineweightController.text.length));


                            creditTab = true;
                            debitTab = false;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: creditTab ? Colors.amber :Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.amber)
                          ),
                          child: Padding(
                            padding:  EdgeInsets.all(8.0),
                            child: Center(child: Text("Credit",style:TextStyle(color: creditTab ? Colors.white :Colors.grey),)),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            touchController = TextEditingController(text: "" );
                            touchController.selection = TextSelection.fromPosition(TextPosition(offset: touchController.text.length));

                            fineweightController = TextEditingController(text: "0" );
                            fineweightController.selection = TextSelection.fromPosition(TextPosition(offset: fineweightController.text.length));


                            creditTab = false;
                            debitTab = true;
                          });
                        },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: debitTab ? Colors.amber :Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.amber)
                            ),
                            child: Padding(
                              padding:  EdgeInsets.all(8.0),
                              child: Center(child: Text("Debit",style:TextStyle(color: debitTab ? Colors.white :Colors.grey),)),
                            ),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding:  EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextFormField(
                          keyboardType: TextInputType.number,
                          controller: dateController,
                          readOnly: true,
                          onTap: (){
                            _selectDateFrom(context);

                          },
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            hintText: 'Select Date',
                            contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
                            alignLabelWithHint: true,
                            // labelText: "Date",

                            fillColor: Colors.black,
                            // border: OutlineInputBorder(
                            //   borderRadius: new BorderRadius.circular(10),
                            //   borderSide: BorderSide(color: Colors.amber),
                            // )

                          )),
                       SizedBox(height: 15),
                      TextFormField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
                            alignLabelWithHint: true,
                            labelText: "Description",
                          fillColor: Colors.black
                          // border: OutlineInputBorder(
                          //     borderRadius: new BorderRadius.circular(10),
                          //     borderSide: const BorderSide(color: Colors.red))

                        ),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: weightController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
                            alignLabelWithHint: true,
                            labelText: "Weight",
                            fillColor: Colors.black
                          // border: OutlineInputBorder(
                          //     borderRadius: new BorderRadius.circular(10),
                          //     borderSide: const BorderSide(color: Colors.red))

                        ),
                        onChanged: (text){
                            if (touchController.text.isNotEmpty && text.isNotEmpty) {
                            // var tempweight = Float.parseFloat(edweight.getText().toString());
                            double tempweight = double.parse(text);
                            // var temptouch = Float.parseFloat(edtouch.getText().toString());
                            double temptouch = double.parse(touchController.text);
                            double fineWeight = (tempweight * temptouch) / 100.0;
                            setState(() {
                              fineweightController = TextEditingController(text:fineWeight.toString() + "" );
                              fineweightController.selection = TextSelection.fromPosition(TextPosition(offset: fineweightController.text.length));
                            });
                          } else {

                            setState(() {
                              fineweightController = TextEditingController(text:"0" );
                              fineweightController.selection = TextSelection.fromPosition(TextPosition(offset: fineweightController.text.length));
                            });
                          }
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: touchController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
                            alignLabelWithHint: true,
                            labelText: "Touch",
                            fillColor: Colors.black
                          // border: OutlineInputBorder(
                          //     borderRadius: new BorderRadius.circular(10),
                          //     borderSide: const BorderSide(color: Colors.red))

                        ),
                        onChanged: (text){
                          print("dsfg" + text.toString());

                          if (touchController.text.isNotEmpty && text.isNotEmpty) {
                            // var tempweight = Float.parseFloat(edweight.getText().toString());
                            double tempweight = double.parse(text);
                            // var temptouch = Float.parseFloat(edtouch.getText().toString());
                            double temptouch = double.parse(touchController.text);
                            double fineWeight = (tempweight * temptouch) / 100.0;
                            setState(() {
                              fineweightController = TextEditingController(text:fineWeight.toString() + "" );
                              fineweightController.selection = TextSelection.fromPosition(TextPosition(offset: fineweightController.text.length));
                            });
                          } else {
                            setState(() {
                              fineweightController = TextEditingController(text:"0" );
                              fineweightController.selection = TextSelection.fromPosition(TextPosition(offset: fineweightController.text.length));
                            });
                          }

                        },
                      ),
                       SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: fineweightController,
                        readOnly: true,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
                            alignLabelWithHint: true,
                            labelText: "Fine Weight",
                            fillColor: Colors.black
                          // border: OutlineInputBorder(
                          //     borderRadius: new BorderRadius.circular(10),
                          //     borderSide: const BorderSide(color: Colors.red))

                        ),
                      ),

                      SizedBox(height: 30),


                      GestureDetector(
                        onTap: () {
                          if(dateController.text.isEmpty){
                            commonToast("Please Enter Date");
                          }else if(descriptionController.text.isEmpty){
                            commonToast("Please Enter Description");
                          }
                          else if(weightController.text.isEmpty){
                            print("--Password_number_is_empty");
                            commonToast("Please Enter Weight");
                          }

                          else {

                            if(creditTab){
                              setState(() {
                                type == "credit";
                              });
                            }

                          //   this.vepari_id,
                          // this.user_id,
                          // this.debit_credit,
                          // this.description,
                          // this.weight,
                          // this.touch,
                          // this.fine_weight,
                          // this.stock_date,

                            if(creditTab == true){
                              viewModel.addTransactionRequest = AddTransactionRequest(
                                  widget.vepariId.toString(),
                                  USER_ID.toString(),
                                  "credit",
                                  descriptionController.text.toString(),
                                  weightController.text.toString(),
                                  touchController.text.toString(),
                                  fineweightController.text.toString(),
                                  dateController.text.toString());
                              viewModel.callAddTransaction(viewModel.addTransactionRequest!);
                            }else{
                              viewModel.addTransactionRequest = AddTransactionRequest(
                                  widget.vepariId.toString(),
                                  USER_ID.toString(),
                                  "debit",
                                  descriptionController.text.toString(),
                                  weightController.text.toString(),
                                  touchController.text.toString(),
                                  fineweightController.text.toString(),
                                  dateController.text.toString());
                              viewModel.callAddTransaction(viewModel.addTransactionRequest!);
                            }
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
                              "Save",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
        // dateController.text = DateFormat('yyyy-MM-dd').format(selectedDateFrom);
        dateController.text = DateFormat('dd/MM/yyyy').format(selectedDateFrom);
      });
  }


  Future<Void?> init() async {
    var userId = await Shared_Preferences.prefGetString(App.KEY_USER_ID, "");
    var deviceId = await Shared_Preferences.prefGetString(App.KEY_DEVICE_ID, "");
    var deviceToken = await Shared_Preferences.prefGetString(App.KEY_DEVICE_TOKEN, "");
    var deviceType = await Shared_Preferences.prefGetString(App.KEY_DEVICE_TYPE, "");
    print("----userId---");
    print("----userId---" + userId.toString());

    setState(() {

      touchController = TextEditingController(text: "100" );
      touchController.selection = TextSelection.fromPosition(TextPosition(offset: touchController.text.length));

      fineweightController = TextEditingController(text: "0" );
      fineweightController.selection = TextSelection.fromPosition(TextPosition(offset: fineweightController.text.length));

      USER_ID = userId.toString();
      DEVICE_TOKEN = deviceToken.toString();
      DEVICE_ID= deviceId.toString();
      DEVICE_TYPE = deviceType.toString();
    });
  }


}
