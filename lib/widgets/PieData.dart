import 'dart:ui';

import 'package:stoke_management/model/api_response/dashbord_model.dart';

class PieData {

  static List<Data> data = [
    // Data(name: 'Blue', percent: 90, color: const Color(0xff0293ee)),
    // Data(name: 'Orange', percent: 30, color: const Color(0xfff8b250)),
   // Data(name: model.totalCredit.toString()),
   // Data(name: model.totalDebit.toString()),
    // Data(name: 'Black', percent: 15, color: Colors.black),
    // Data(name: 'Green', percent: 15, color: const Color(0xff13d38e)),
  ];
}

class Data {
  final String? name;

  final double? percent;

  final Color? color;

  Data({this.name, this.percent, this.color});
}


/*
PieData(){
  data = [
    Data(name: 'Black', percent: 15, color: Color(0xff0293ee)),
    Data(name: 'Green', percent: 15, color: const Color(0xff13d38e)),
    //  Data(name: model.totalDebit, percent: 40, color: const Color(0xff0293ee)),
    //  Data(name: model.totalCredit, percent: 30, color: const Color(0xfff8b250)),
  ];
}*/
