import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stoke_management/model/api_response/dashbord_model.dart';
import 'package:stoke_management/utills/appbar_title_text.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/shared_preferences.dart';
import 'package:stoke_management/utills/utils_routes.dart';
import 'package:stoke_management/view_model/dashbord_view_model.dart';
import 'package:stoke_management/widgets/PieData.dart';
import '../app.dart';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class DashBordScreen extends StatefulWidget {
  const DashBordScreen({Key? key}) : super(key: key);

  @override
  DashBordScreenState createState() => DashBordScreenState();
}
enum LegendShape { Circle, Rectangle }

class DashBordScreenState extends State<DashBordScreen> {

  int touchedIndex = 0;

  double totalCredit = 0;
  double totalDebit = 0;
  double totalBalance = 0;

  final legendLabels = <String, String>{
    "Credit": "Credit",
    "Debit": "Debit",
  };

  final colorList = <Color>[
    Colors.lightGreenAccent,
    Colors.amber,
  ];

  ChartType? _chartType = ChartType.ring;
  bool _showCenterText = true;
  double? _ringStrokeWidth = 70;
  double? _chartLegendSpacing = 50;

  bool _showLegendsInRow = true;
  bool _showLegends = true;
  bool _showLegendLabel = true;

  bool _showChartValueBackground = false;
  bool _showChartValues = true;
  bool _showChartValuesInPercentage = false;
  bool _showChartValuesOutside = true;

  bool _showGradientColors = false;

  LegendShape? _legendShape = LegendShape.Circle;
  LegendPosition? _legendPosition = LegendPosition.bottom;

  int key = 0;
  String? USER_ID;
  String? DEVICE_TYPE;
  String? DEVICE_ID;
  String? DEVICE_TOKEN;

  DashBordViewModel? model;

  DashBordModel dashBordModel = DashBordModel();

  @override
  void initState() {
    super.initState();
    init();
    Future.delayed(Duration.zero, () {
      (model = DashBordViewModel(this));
    });
  }

  @override
  Widget build(BuildContext context) {

    final dataMap = <String, double>{
      "Credit": totalCredit,
      "Debit": totalDebit,
      // "Debit": 50,
    };

    final chart = PieChart(
      key: ValueKey(key),
      dataMap: dataMap,
      animationDuration: Duration(milliseconds: 5000),
      chartLegendSpacing: _chartLegendSpacing!,
      chartRadius: math.min(MediaQuery.of(context).size.width / 2.5, 300),
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: _chartType!,
      centerText: _showCenterText ? "$totalBalance \n Stock" : null,
      legendLabels: _showLegendLabel ? legendLabels : {},
      legendOptions: LegendOptions(
        showLegendsInRow: _showLegendsInRow,
        legendPosition: _legendPosition!,
        showLegends: _showLegends,
        legendShape: _legendShape == LegendShape.Circle
            ? BoxShape.circle
            : BoxShape.rectangle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: _showChartValueBackground,
        showChartValues: _showChartValues,
        showChartValuesInPercentage: _showChartValuesInPercentage,
        showChartValuesOutside: _showChartValuesOutside,
      ),
      ringStrokeWidth: _ringStrokeWidth!,
      emptyColor: Colors.amber,
      // gradientList: _showGradientColors ? gradientList : null,
      emptyColorGradient: [
        Color(0xff6c5ce7),
        Colors.blue,
      ],
      baseChartColor: Colors.transparent,
    );

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
            title: Text("Dash Bord",
                style: AppBarTitle.myAppbarStyle),
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: ColorConstant.themColor,
            systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: ColorConstant.themColor,
              statusBarIconBrightness: Brightness.light,
            )
        ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height-150,
          // color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              w_toolbar(),
              SizedBox(height: 40),
              // w_stockCount(),
              Column(
                children: [
                  Container(
                    child: chart,
                    margin: EdgeInsets.symmetric(
                      vertical: 32,
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, UtilRoutes.ViewMoreScreen);
                    },
                    child: Container(
                      // height: 30,
                      width: MediaQuery.of(context).size.width/3.3,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: const Center(child: Text("View Detail",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),)),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(),
              SizedBox()

            ],
          ),
        ),
      )
    );
  }


  Widget w_toolbar(){
    return Container(
      decoration:  BoxDecoration(
        color: Colors.amber
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 25,bottom: 10),
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
                    totalCredit.toString(),
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
                    totalDebit.toString(),
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
                    totalBalance.toString(),
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
    );
  }

  Future<Void?> init() async {
    var userId = await Shared_Preferences.prefGetString(App.KEY_USER_ID, "");
    var deviceType = await Shared_Preferences.prefGetString(App.KEY_DEVICE_TYPE, "");
    var deviceId = await Shared_Preferences.prefGetString(App.KEY_DEVICE_ID, "");
    var token = await Shared_Preferences.prefGetString(App.KEY_DEVICE_TOKEN, "");

    setState(() {
      USER_ID = userId.toString();
      DEVICE_TYPE = deviceType.toString();
      DEVICE_ID = deviceId.toString();
      DEVICE_TOKEN = token.toString();
    });
  }

}
