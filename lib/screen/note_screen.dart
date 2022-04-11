import 'package:flutter/material.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/view_model/text_stock_list_view_model.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  NoteScreenState createState() => NoteScreenState();
}

class NoteScreenState extends State<NoteScreen> {

  TextEditingController controller = TextEditingController();

  TextStockListViewModel? model;

  @override
  void initState() {
    super.initState();
   // init();
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
        title: Text("Test Edit",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                if(controller.text.isNotEmpty) {
                  model!.callStockList("user_id");
                }
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none
              ),
            ),
          ),
        ),
      ),
    );
  }
}
