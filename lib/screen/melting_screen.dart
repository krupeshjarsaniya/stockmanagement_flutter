import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stoke_management/utills/appbar_title_text.dart';
import 'package:stoke_management/utills/color_constant.dart';

import '../database/database_helper.dart';
import '../model/api_response/melting_data_model.dart';
import 'melting_history_screen.dart';

class MeltingScreen extends StatefulWidget {
  const MeltingScreen({Key? key}) : super(key: key);

  @override
  State<MeltingScreen> createState() => MeltingScreenState();
}

class MeltingScreenState extends State<MeltingScreen> {
  DatabaseHelper helper = DatabaseHelper();
  MeltingDataModel? meltingDataModel = MeltingDataModel('', '', '', '', '', '');
  String pal = "";
  String fianlweight = "";

  // bool _validate = false;
  TextEditingController weightController = TextEditingController();
  TextEditingController touchController = TextEditingController();
  TextEditingController outController = TextEditingController();

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool eng = false;
  bool guj = false;
  bool hin = false;
  bool ben = false;
  bool add = false;
  bool add2 = false;
  String? lan = "";
  SharedPreferences? pref;

  double Height(int per) {
    return (MediaQuery.of(context).size.height * per) / 100;
  }

  @override
  void initState() {
    /*_init();
    Future.delayed(Duration(seconds: 8), () async {});
    super.initState();*/
  }

  _init() async {
    pref = await SharedPreferences.getInstance();
    lan = pref!.getString("language")!;
    print("init" + lan!);
    if (lan == "eng") {
      eng = true;
    } else if (lan == "hin") {
      hin = true;
    } else if (lan == "guj") {
      guj = true;
    } else {
      ben = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("===build===");
    if (lan == "") {
      _init();
    }
    if (meltingDataModel!.id != null) {
      weightController.text = meltingDataModel!.weight!;
      touchController.text = meltingDataModel!.touch!;
      outController.text = meltingDataModel!.output!;
    } else {}
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          title: Text("Gold melting".tr, style: AppBarTitle.myAppbarStyle),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: ColorConstant.themColor,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MeltingHistoryScreen()));
                },
                child: Container(
                  width:50,
                  child: const Icon(
                    Icons.history,
                    size: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
          systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: ColorConstant.themColor,
            statusBarIconBrightness: Brightness.light,
          )),

      body: SingleChildScrollView(
        child: Form(
            key: _key,
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                margin: EdgeInsets.only(left: 6, right: 6),
                padding: EdgeInsets.only(top: 4),
                height: Height(50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),

                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: weightController,
                      validator: (value) {
                        print("weight add" + value.toString());
                        if (value!.isEmpty)

                          //weightController.value.text.isEmpty
                            {
                          return "Enter value plz";
                        }
                      },
                      onChanged: (value) {
                        updateweight();
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
                        alignLabelWithHint: true,
                        // border: OutlineInputBorder(),
                        labelText: 'Enter Weight(Saperate with Space)'.tr,
                        // errorText: _validate ? 'Weight Can\'t Be Empty' : null,
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: touchController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        print("touch add" + value.toString());
                        if (value!.isEmpty) {
                          return "enter value plz";
                        }
                      },
                      onChanged: (value) {
                        updatetouch();
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
                        alignLabelWithHint: true,
                        labelText: "Enter Touch(Saperate with Space)".tr,
                        //   errorText: _validate ? 'Touch Can\'t Be Empty' : null,
                      ),
                    ),
                    SizedBox(height: 15),

                    TextFormField(
                      controller: outController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        print("out add" + value.toString());
                        if (value!.isEmpty) {
                          return "enter value plz";
                        }
                      },
                      onChanged: (value) {
                        updateout();
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top:0.0,bottom:0.0),
                        alignLabelWithHint: true,
                        labelText: "Enter Output Touch".tr,
                        // errorText:_validate ? 'OutTouch   Can\'t Be Empty' : null,
                      ),
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Visibility(
                              visible: add,
                              child: Text(pal,
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.amber)),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Visibility(
                                visible: add2,
                                child: Text(fianlweight,
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.amber)),
                              ))
                        ])
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(right: 10, left: 10),
                  padding: EdgeInsets.only(top: 30),
                  child: MaterialButton(
                    color: Colors.amber,
                    minWidth: double.infinity,
                    // minWidth: 400,
                    height: Height(6),
                    child: Text("Calculate".tr,style: TextStyle(color: Colors.white,fontSize: 18),),
                    onPressed: () {
                      setState(() {
                        add = true;
                        add2 = true;
                      });

                      if(weightController.text.isEmpty){
                        Fluttertoast.showToast(
                            msg: "Filed can not be blank",
                            backgroundColor: Colors.red);
                      }else if(touchController.text.isEmpty){
                        Fluttertoast.showToast(
                            msg: "Filed can not be blank",
                            backgroundColor: Colors.red);
                      }else if(outController.text.isEmpty){
                        Fluttertoast.showToast(
                            msg: "Filed can not be blank",
                            backgroundColor: Colors.red);
                      }else{
                        calculate();
                      }

                      //
                      // if (_key.currentState!.validate()) {
                      //   //  cal();
                      // } else {
                      //   Fluttertoast.showToast(
                      //       msg: "Filed can not be blank",
                      //       backgroundColor: Colors.red);
                      // }
                    } /* setState(() {
                            weightController.text.isEmpty
                                ? _validate = true
                                : _validate = false;
                        },
                      );*/
                    ,
                  )),
              SizedBox(height: 5,),
              Container(
                  margin: EdgeInsets.only(left: 12),
                  padding: EdgeInsets.only(top: 9),
                  child: Row(children: [
                    Text(
                      "Select your Language".tr,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )
                  ])),

              SizedBox(height: 5,),

              Container(
                  margin: EdgeInsets.only(left: 12, right: 12),
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 10,
                          child: MaterialButton(
                            height: 45,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: Colors.amber, width: 1)),
                            color: eng ? Colors.amber : Colors.white,
                            child: eng ? Text("English",style: TextStyle(color: Colors.white),) : Text("English"),
                            onPressed: () {
                              var local = Locale('eg', 'US');
                              Get.updateLocale(local);
                              setState(() {
                                pref!.setString("language", "eng");
                                eng = true;
                                guj = false;
                                hin = false;
                                ben = false;
                                weightController.text = "";
                                outController.text = "";
                                touchController.text = "";
                              });
                            },
                          )),
                      Spacer(),
                      Expanded(
                          flex: 10,
                          child: MaterialButton(
                            height: 45,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: Colors.amber, width: 1)),
                            color: guj ? Colors.amber : Colors.white,
                            // child: Text("ગુજરાતી"),
                            child: guj ? Text("ગુજરાતી",style: TextStyle(color: Colors.white),) : Text("ગુજરાતી"),

                            onPressed: () {
                              var local = Locale('gu', 'IN');
                              Get.updateLocale(local);
                              setState(() {
                                pref!.setString("language", "guj");

                                eng = false;
                                guj = true;
                                hin = false;
                                ben = false;
                                add = false;
                                add2 = false;
                                weightController.text = "";
                                outController.text = "";
                                touchController.text = "";
                              });
                            },
                          )),
                      Spacer(),
                      Expanded(
                          flex: 10,
                          child: MaterialButton(
                            height: 45,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: Colors.amber, width: 1)),
                            color: hin ? Colors.amber : Colors.white,
                            // child: Text("हिन्दी"),
                            child: hin ? Text("हिन्दी",style: TextStyle(color: Colors.white),) : Text("हिन्दी"),

                            onPressed: () {
                              var local = Locale('hi', 'IN');
                              Get.updateLocale(local);

                              setState(() {
                                pref!.setString("language", "hin");

                                eng = false;
                                guj = false;
                                hin = true;
                                ben = false;
                                add = false;
                                add2 = false;
                                weightController.text = "";
                                outController.text = "";
                                touchController.text = "";
                              });
                            },
                          )),
                      Spacer(),
                      Expanded(
                          flex: 10,
                          child: MaterialButton(
                            height: 45,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: Colors.amber, width: 1)),
                            color: ben ? Colors.amber : Colors.white,
                            // child: Text("বাঙালি"),
                            child: ben ? Text("বাঙালি",style: TextStyle(color: Colors.white),) : Text("বাঙালি"),

                            onPressed: () {
                              var local = Locale('ban', 'IN');
                              Get.updateLocale(local);

                              setState(() {
                                pref!.setString("language", "ben");
                                eng = false;
                                guj = false;
                                hin = false;
                                ben = true;
                                add = false;
                                add2 = false;
                                weightController.text = "";
                                outController.text = "";
                                touchController.text = "";
                              });
                            },
                          ))
                    ],
                  ))
            ])),
      ),
    );
  }

  void updateweight() {
    meltingDataModel!.weight = weightController.text;
    print("weight" + meltingDataModel!.weight.toString());
  }

  void updatetouch() {
    meltingDataModel!.touch = touchController.text;
    print("touch");
  }

  void updateout() {
    meltingDataModel!.output = outController.text;
    print("out");
  }

  void cal() async {
    print("inserting" + meltingDataModel!.weight.toString());
    updateweight();
    updatetouch();
    updateout();

    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd – hh:mm');
    final String formatted = formatter.format(now);
    meltingDataModel!.date = formatted;

    int? result;

    if (meltingDataModel != null && meltingDataModel!.id != null) {
      //  Update
      print("inserting" + meltingDataModel.toString());
      result = await helper.updateMeltingData(meltingDataModel!);
    } else {
      // Insert

      print("result" + meltingDataModel.toString());
      result = await helper.insertMeltingData(meltingDataModel!);
    }
  }

  void calculate() async {
    updateweight();
    updatetouch();
    updateout();
    String str_abcdd, str_abcdd1, str_abcdd2, str_abcdd3;

    List<String> weights = weightController.text.split(" ");
    List<String> stouches = touchController.text.split(" ");
    double dtouche = double.parse(outController.text);

    if (weightController.text.length != touchController.text.length) {
      Fluttertoast.showToast(msg: "Total weight and Touch are not same");
    }

    if (dtouche > 100) {
      Fluttertoast.showToast(msg: "value can't be grater than 100");
    } else if (dtouche == 100) {
      Fluttertoast.showToast(msg: "nothing to Add");
    } else {
      double total_weight = 0;
      double total_fine = 0;
      double w = 0, f = 0;
      for (int i = 0; i < weights.length; i++) {
        try {
          w = double.parse(weights[i]);
        } catch (e) {
          w = 0;
        }
        try {
          f = double.parse(stouches[i]);
        } catch (e) {
          w = 0;
        }
        total_weight += w;
        total_fine += (w * f / 100);
      }
      double final_fine = total_fine / dtouche * 100;
      if (total_weight > final_fine) {
        double dif = total_weight - final_fine;
        double addpalo = (dif * dtouche) / (100 - dtouche);
        double FinalWeight = total_weight + addpalo;
        //pal.setText(R.string.Add_Fine_Gold);
        //str_abcdd=getString(R.string.Add_Fine_Gold1);
        str_abcdd1 = "फाइन गोल्ड जोड़े";
        str_abcdd2 = "ફાઇન ગોલ્ડ ઉમેરો";
        str_abcdd3 = "ফাইন গোল্ড যোগ করুন";
        pal = "Add Fine Gold".tr + addpalo.toStringAsFixed(3) + " G";
        meltingDataModel!.pal = addpalo.toStringAsFixed(3) + ' G';
        fianlweight = "Final Weight".tr + FinalWeight.toStringAsFixed(3) + " G";
        meltingDataModel!.finalweight = FinalWeight.toStringAsFixed(3) + " G";
        /* lblAdd1.setText(get3DigitFraction((addpalo))
  + " G");
  lblFinalWeight.setText(get3DigitFraction((FinalWeight))
  + " G");*/
      } else {
        double t = total_fine / dtouche * 100;
        double diff = t - total_weight;
        double FinalWeight = diff + total_weight;
        pal = "Add Fine Gold".tr + diff.toStringAsFixed(3) + " G";
        meltingDataModel!.pal = diff.toStringAsFixed(3) + ' G';
        //updatepal();
        fianlweight = "Final Weight".tr + FinalWeight.toStringAsFixed(3) + " G";
        meltingDataModel!.finalweight = FinalWeight.toStringAsFixed(3) + " G";

        /* tvAddGold.setText(R.string.Add_Palo);
    str_abcdd=getString(R.string.Add_Palo1);*/
        str_abcdd1 = "पाला जोड़ें ";
        str_abcdd2 = "પાળો ઉમેરો ";
        str_abcdd3 = "পালো যোগ করুন ";
        /*  lblAdd1.setText(get3DigitFraction((diff))
    + " G");
    lblFinalWeight.setText(get3DigitFraction((FinalWeight))
    + " G");*/

      }

      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd – hh:mm');
      final String formatted = formatter.format(now);
      meltingDataModel!.date = formatted;

      int? result;

      if (meltingDataModel != null && meltingDataModel!.id != null) {
        //  Update
        print("inserting" + meltingDataModel.toString());
        result = await helper.updateMeltingData(meltingDataModel!);
      } else {
        // Insert

        print("result" + meltingDataModel.toString());
        result = await helper.insertMeltingData(meltingDataModel!);
      }

      /*Calendar c = Calendar.getInstance();
    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String formattedDate = df.format(c.getTime());
    tvFinalWeight.setText(getString(R.string.final_weight));
    db1.execSQL("INSERT INTO login (WEIGHT,TOUCH,OUTPUTTOUCH,FINE_GOLD,TOTALWEIGHT,DATE_S,FINE_G,FINE_lan)  VALUES ('"
    + amount1.getText().toString().trim()
    + "','"
    + amount2.getText().toString().trim()
  + "','"
  + amount3.getText().toString().trim()
  + "','"
  +""+lblAdd1.getText().toString().trim()
  + "','"
  + lblFinalWeight.getText().toString().trim()
  + "','"
  + formattedDate
  +"','"+str_abcdd+"','"+"0"+ "');");
  db1.execSQL("INSERT INTO login (WEIGHT,TOUCH,OUTPUTTOUCH,FINE_GOLD,TOTALWEIGHT,DATE_S,FINE_G,FINE_lan)  VALUES ('"
  + amount1.getText().toString().trim()
  + "','"
  + amount2.getText().toString().trim()
  + "','"
  + amount3.getText().toString().trim()
  + "','"
  +""+lblAdd1.getText().toString().trim()
  + "','"
  + lblFinalWeight.getText().toString().trim()
  + "','"
  + formattedDate
  +"','"+str_abcdd1+"','"+"1"+ "');");
  db1.execSQL("INSERT INTO login (WEIGHT,TOUCH,OUTPUTTOUCH,FINE_GOLD,TOTALWEIGHT,DATE_S,FINE_G,FINE_lan)  VALUES ('"
  + amount1.getText().toString().trim()
  + "','"
  + amount2.getText().toString().trim()
  + "','"
  + amount3.getText().toString().trim()
  + "','"
  +""+lblAdd1.getText().toString().trim()
  + "','"
  + lblFinalWeight.getText().toString().trim()
  + "','"
  + formattedDate
  +"','"+str_abcdd2+"','"+"2"+ "');");
  db1.execSQL("INSERT INTO login (WEIGHT,TOUCH,OUTPUTTOUCH,FINE_GOLD,TOTALWEIGHT,DATE_S,FINE_G,FINE_lan)  VALUES ('"
  + amount1.getText().toString().trim()
  + "','"
  + amount2.getText().toString().trim()
  + "','"
  + amount3.getText().toString().trim()
  + "','"
  +""+lblAdd1.getText().toString().trim()
  + "','"
  + lblFinalWeight.getText().toString().trim()
  + "','"
  + formattedDate
  +"','"+str_abcdd3+"','"+"3"+ "');");
  Toast.makeText(getContext(), R.string.success,Toast.LENGTH_LONG).show();
  getDataInterAds();
  }
  catch(Exception e1) {
  */ /*dlgAlert.setMessage("Error Occured try again Later");
                    dlgAlert.setTitle("Gold Melting");
                    dlgAlert.setPositiveButton("OK", null);
                    dlgAlert.setCancelable(true);
                    dlgAlert.create().show();*/ /*
  Toasty.error(getActivity(), getString(R.string.Error_Occured_try), Toast.LENGTH_SHORT, true).show();
  // Toasty.success(getActivity(), "Success!", Toast.LENGTH_SHORT, true).show();
  //MessageBox.Show("Error Occured try again later", "Gold Melting", MessageBoxButtons.OK, MessageBoxIcon.Error);
  }*/
    }
  }
}
