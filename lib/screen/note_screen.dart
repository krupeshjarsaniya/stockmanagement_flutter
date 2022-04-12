import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/shared_preferences.dart';
import 'package:stoke_management/view_model/text_stock_list_view_model.dart';

import '../app.dart';

class NoteScreen extends StatefulWidget {
  String? vendorName;
  NoteScreen({this.vendorName});
  // const NoteScreen({Key? key}) : super(key: key);

  @override
  NoteScreenState createState() => NoteScreenState();
}

class NoteScreenState extends State<NoteScreen> {

  TextEditingController controller = TextEditingController();

  TextStockListViewModel? model;

  String? USER_ID;


  @override
  void initState() {
    super.initState();
   init();
    // scrollController.addListener(pagination);
    Future.delayed(Duration.zero, () {
      (model = TextStockListViewModel(this));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text("${widget.vendorName.toString()} Editor",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                if(controller.text.isNotEmpty) {
                  model!.callStockList(USER_ID.toString());
                }
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            maxLines: 35,
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Insert Your Text",
              hintStyle: TextStyle(color: Colors.grey,fontSize: 20,fontWeight: FontWeight.w500)
            ),
          ),
        ),
      ),
    );
  }



  Future<Void?> init() async {
    var userId = await Shared_Preferences.prefGetString(App.KEY_USER_ID, "");

    setState(() {
      USER_ID = userId.toString();

    });
  }

}
