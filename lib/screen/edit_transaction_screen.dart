import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:stoke_management/model/api_request/edit_stocks_request.dart';
import 'package:stoke_management/utills/appbar_title_text.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/shared_preferences.dart';
import 'package:stoke_management/view_model/edit_stocks_view_model.dart';

import '../../app.dart';

class EditTransactionScreen extends StatefulWidget {
  String? stock_id;
  String? debit_credit;
  String? weight;
  String? touch;
  String? fine_weight;
  String? stock_date;
  String? vepari_id;
  String? description;

  EditTransactionScreen({this.stock_id,this.debit_credit,this.weight,this.touch,this.fine_weight,this.stock_date,this.vepari_id,this.description});

  // const EditTransactionScreen({Key? key}) : super(key: key);

  @override
  EditTransactionScreenState createState() => EditTransactionScreenState();
}

class EditTransactionScreenState extends State<EditTransactionScreen> {

  EditStocksViewModel? model;

  DateTime selectedDateFrom = DateTime.now();
  DateTime selectedDateTo = DateTime.now();
  TextEditingController dateController =  TextEditingController();
  TextEditingController descriptionController =  TextEditingController();
  TextEditingController weightController =  TextEditingController();
  TextEditingController touchController =  TextEditingController();
  TextEditingController fineweightController =  TextEditingController();

  bool creditTab = true;
  bool debitTab = false;


  String? USER_ID;


  @override
  void initState() {
    super.initState();
    init();
    // scrollController.addListener(pagination);
    Future.delayed(Duration.zero, () {
      /*model ??*/ (model = EditStocksViewModel(this));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.delete))
            ],
              automaticallyImplyLeading: true,
              iconTheme: IconThemeData(
                color: Colors.white, //change your color here
              ),
              elevation: 0,
              title: Text("Edit Transaction",style: AppBarTitle.myAppbarStyle,),

              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              backgroundColor: ColorConstant.themColor,
              systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: ColorConstant.themColor,
                statusBarIconBrightness: Brightness.light,
              )
          ),
          body: ListView(
            children: [
              Column(
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
                          keyboardType: TextInputType.number,
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
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: fineweightController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
                              alignLabelWithHint: true,
                              labelText: "Fine Weight",
                              fillColor: Colors.black


                          ),
                        ),

                        SizedBox(height: 30),


                        GestureDetector(
                          onTap: () {
                            if(descriptionController.text.isEmpty){
                            }else if(weightController.text.isEmpty){
                            }else if(touchController.text.isEmpty){
                            }else if(fineweightController.text.isEmpty){
                            }else if(dateController.text.isEmpty){
                            }

                            else {

                              if(creditTab == true){
                                model!.editStocksRequest = EditStocksRequest(
                                  widget.stock_id.toString(),
                                  USER_ID.toString(),
                                  "credit",
                                  widget.vepari_id.toString(),
                                  descriptionController.text.toString(),
                                  touchController.text.toString(),
                                  weightController.text.toString(),
                                  dateController.text.toString(),
                                  fineweightController.text.toString(),

                                );

                              }else{
                                model!.editStocksRequest = EditStocksRequest(
                                  widget.stock_id.toString(),
                                  USER_ID.toString(),
                                  "debit",
                                  widget.vepari_id.toString(),
                                  descriptionController.text.toString(),
                                  touchController.text.toString(),
                                  weightController.text.toString(),
                                  dateController.text.toString(),
                                  fineweightController.text.toString(),

                                );
                              }


                              model!.callEditStocks(model!.editStocksRequest!);
                              print(
                                  "==================" + model!.editStocksRequest.toString());
                            }
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
      ),
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

    setState(() {

      if(widget.debit_credit == "credit"){
        creditTab = true;
        debitTab = false;
      }else{
        creditTab = false;
        debitTab = true;
      }

      USER_ID = userId.toString();

      dateController = TextEditingController(text: widget.stock_date.toString() );
      dateController.selection = TextSelection.fromPosition(TextPosition(offset: dateController.text.length));

      descriptionController = TextEditingController(text: widget.description.toString() );
      descriptionController.selection = TextSelection.fromPosition(TextPosition(offset: descriptionController.text.length));

      weightController = TextEditingController(text: widget.weight.toString() );
      weightController.selection = TextSelection.fromPosition(TextPosition(offset: weightController.text.length));

      touchController = TextEditingController(text: widget.touch.toString() );
      touchController.selection = TextSelection.fromPosition(TextPosition(offset: touchController.text.length));

      fineweightController = TextEditingController(text: widget.fine_weight.toString() );
      fineweightController.selection = TextSelection.fromPosition(TextPosition(offset: fineweightController.text.length));
    });
  }
}
