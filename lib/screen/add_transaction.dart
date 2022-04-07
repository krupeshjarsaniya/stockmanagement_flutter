import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/appbar_title_text.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({Key? key}) : super(key: key);

  @override
  AddTransactionScreState createState() => AddTransactionScreState();
}

class AddTransactionScreState extends State<AddTransactionScreen> {

  DateTime selectedDateFrom = DateTime.now();
  DateTime selectedDateTo = DateTime.now();

  TextEditingController _txtControllerDateFrom = new TextEditingController();
  TextEditingController _txtControllerDateTo = new TextEditingController();


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
