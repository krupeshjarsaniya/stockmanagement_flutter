import 'package:flutter/material.dart';


Widget CardVendors(BuildContext context,int index){
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5), // if you need this
      side: BorderSide(
        color: Colors.grey.withOpacity(0.4),
        width: 0.8,
      ),
    ),
    margin: const EdgeInsets.all(10.0),
    child: Container(
      height: 100,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(15),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5)
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width-150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(child: const Text("User Name",style: TextStyle(fontSize: 16,color: Colors.black),)),
                SizedBox(height: 5,),
                Container(child: const Text("TechnoComet Solution")),
                SizedBox(height: 5,),
                Container(child: const Text("9925755626")),
              ],
            ),
          ),

          Container(
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){},
                  child: Container(
                    child: const Icon(
                      Icons.delete_forever,
                      color: Colors.grey,
                    ),
                  ),
                ),

                const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
