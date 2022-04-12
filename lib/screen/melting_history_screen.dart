import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../model/api_response/melting_data_model.dart';
import '../utills/color_constant.dart';


class MeltingHistoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MeltingHistoryScreenState();
}

class MeltingHistoryScreenState extends State<MeltingHistoryScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<MeltingDataModel>? dataList = <MeltingDataModel>[];
  int count = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateDataListView();
  }

  @override
  Widget build(BuildContext context) {
    /*if (dataList == null) {
      dataList = <Data>[];
    }*/
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text("History".tr,style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: ColorConstant.themColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: ColorConstant.themColor,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: getDataListView(),
    );
  }

  getDataListView() {
    return Visibility(
        visible: dataList!.isNotEmpty,
        child: ListView.builder(
            itemCount: count,
            itemBuilder: (BuildContext context, int position) {
              return Stack(children: [
                Card(
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    color: Colors.white,
                    elevation: 6.0,
                    child: new InkWell(
                      onTap: () {
                        _showAlertDialog('Histroy', this.dataList![position]);

                        print("tapped");
                      },
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 6, right: 120),
                              padding: EdgeInsets.only(top: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text("weight".tr),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      this.dataList![position].weight != null
                                          ? this.dataList![position].weight!
                                          : "",
                                      style: TextStyle(color: Colors.blueGrey),
                                    ),
                                  ),
                                ],
                              )),
                          Container(
                              margin: EdgeInsets.only(left: 6, right: 120),
                              padding: EdgeInsets.only(top: 6),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text("touch".tr),
                                  ),
                                  Expanded(
                                    child: Text(
                                        this.dataList![position].touch != null
                                            ? this.dataList![position].touch!
                                            : "",
                                        style:
                                        TextStyle(color: Colors.blueGrey)),
                                  )
                                ],
                              )),
                          Container(
                              margin: EdgeInsets.only(left: 6, right: 120),
                              padding: EdgeInsets.only(top: 6),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text("Output touch".tr),
                                  ),
                                  Expanded(
                                    child: Text(
                                        this.dataList![position].output != null
                                            ? this.dataList![position].output!
                                            : "",
                                        style:
                                        TextStyle(color: Colors.blueGrey)),
                                  )
                                ],
                              )),
                          Container(
                              margin: EdgeInsets.only(left: 6, right: 120),
                              padding: EdgeInsets.only(top: 6),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text("Add palo".tr),
                                  ),
                                  Expanded(
                                    child: Text(
                                        this.dataList![position].pal != null
                                            ? this.dataList![position].pal!
                                            : "",
                                        style:
                                        TextStyle(color: Colors.blueGrey)),
                                  )
                                ],
                              )),
                          Container(
                              margin: EdgeInsets.only(left: 6, right: 120),
                              padding: EdgeInsets.only(top: 6),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text("total weight".tr),
                                  ),
                                  Expanded(
                                    child: Text(
                                        this.dataList![position].finalweight !=
                                            null
                                            ? this
                                            .dataList![position]
                                            .finalweight!
                                            : "",
                                        style:
                                        TextStyle(color: Colors.blueGrey)),
                                  )
                                ],
                              )),
                          /* Container(
                          margin: EdgeInsets.only(left: 6, right: 120),
                          padding: EdgeInsets.only(top: 6),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text("Add Palo:"),
                              ),

                              Expanded(
                                child: Text("Palo will be here",
                                    style: TextStyle(color: Colors.blueGrey)),
                              )
                            ],
                          )),*/

                          Container(
                              margin: EdgeInsets.only(left: 6, right: 120),
                              padding: EdgeInsets.only(top: 6, bottom: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text("DATE".tr),
                                  ),
                                  Expanded(
                                    flex: 0,
                                    child: Text(
                                        this.dataList![position].date != null
                                            ? this.dataList![position].date!
                                            : "",
                                        style:
                                        TextStyle(color: Colors.blueGrey)),
                                  )
                                ],
                              )),
                        ],
                      ),
                    )),
                Positioned(
                  right: 18,
                  top: 15,
                  child: GestureDetector(
                    child: Icon(
                      Icons.delete_forever,
                      color: Colors.grey,
                      size: 25,
                    ),
                    onTap: () {
                      //_showAlertDialog('Delete RECORD');
                      _delete(context, dataList![position]);
                      Fluttertoast.showToast(msg: "Delete successful");
                    },
                  ),
                )
              ]);
            }));
  }

  void _delete(BuildContext context, MeltingDataModel data) async {
    int result = await databaseHelper.deleteData(data.id!);
    if (result != 0) {
      //_showSnackBar(context, 'Note Deleted Successfully');
      updateDataListView();
    }
  }

  void _showAlertDialog(String title, MeltingDataModel data) {
    AlertDialog alertDialog = AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                child: Column(children: [
                  Container(
                      child: Row(children: [
                        Text("weight".tr),
                        Spacer(),
                        Text(data.weight!),
                      ])),
                  Container(
                      child: Row(children: [
                        Text("touch".tr),
                        Spacer(),
                        Text(data.touch!),
                      ])),
                  Container(
                      child: Row(children: [
                        Text("Output touch".tr),
                        Spacer(),
                        Text(data.output!),
                      ])),
                  Container(
                      child: Row(children: [
                        Text("Add palo".tr),
                        Spacer(),
                        Text(data.pal!),
                      ])),
                  Container(
                      child: Row(children: [
                        Text("total weight".tr),
                        Spacer(),
                        Text(data.finalweight!),
                      ])),
                  Container(
                      child: Row(children: [
                        Text("DATE".tr),
                        Spacer(),
                        Text(data.date!),
                      ])),
                  /*   Container(
                  height: 125,
                  child: Column(children: [
                    Text(data.touch!),
                    Text(data.output!),
                    Text(data.pal!),
                    Text(data.finalweight!),
                    Text(data.date!),
                  ])),*/
                ])),
          ],
        ));
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void updateDataListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<MeltingDataModel>> dataListFuture = databaseHelper.getMeltingdataList();
      dataListFuture.then((dataList) {
        setState(() {
          this.dataList = dataList;
          this.count = dataList.length;
        });
      });
    });
  }
}
