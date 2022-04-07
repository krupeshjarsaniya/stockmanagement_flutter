
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../app.dart';


BuildContext? c;
 GlobalKey? key;
showLoader(context,{String? label}){
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      c = context;
      return  AlertDialog(
        key: key,
        shape: CircleBorder(),
        contentPadding: EdgeInsets.zero,
        content: new Container(
          height: 50,
          width: 50,
          alignment: Alignment.center,
          child: new CircularProgressIndicator(strokeWidth: 5,color: Colors.amber,),
        ),
      );

    },
  );
}

hideLoader(){
  Navigator.pop(c!);
}



