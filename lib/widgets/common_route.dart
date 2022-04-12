import 'package:flutter/material.dart';



// BuildContext? c;
//  GlobalKey? key;
// showLoader(context,{String? label}){
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       c = context;
//       return  AlertDialog(
//         key: key,
//         shape: CircleBorder(),
//         contentPadding: EdgeInsets.zero,
//         content: new Container(
//           height: 50,
//           width: 50,
//           alignment: Alignment.center,
//           child: new CircularProgressIndicator(strokeWidth: 5,color: Colors.amber,),
//         ),
//       );
//
//     },
//   );
// }


BuildContext? c;
 GlobalKey? key;
showLoader(context,{String? label}){
  showDialog<void>(
    barrierColor: Color(0x01000000),
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      c = context;
      return new WillPopScope(
        onWillPop: () async => false,

//for disable hide dialog on device back button press
        child: AlertDialog(
          key: key,
          shape: CircleBorder(),
          contentPadding: EdgeInsets.zero,
          content: new Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            child: new CircularProgressIndicator(strokeWidth: 5),
          ),
        ),
      );
    },
  );
}


hideLoader(){
  Navigator.pop(c!);
}



