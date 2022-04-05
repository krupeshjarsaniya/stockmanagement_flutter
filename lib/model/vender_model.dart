import 'package:flutter/cupertino.dart';

class VenderModel {

  int vendorId;
  String Firstname, Lastname, MobileNumber, CompanyName, Address, Email;


  VenderModel({
    required this.vendorId,
    required this.Firstname,
    required this.Lastname,
    required this.MobileNumber,
    required this.CompanyName,
    required this.Address,
    required this.Email
  });

  //to be used when inserting a row in the table
  Map<String, dynamic> toMapWithoutId() {
    final map = new Map<String, dynamic>();
    map["vendorId"] = vendorId;
    map["Firstname"] = Firstname;
    map["Lastname"] = Lastname;
    map["MobileNumber"] = MobileNumber;
    map["CompanyName"] = CompanyName;
    map["Address"] = Address;
    map["Email"] = Email;
    return map;
  }


  //to be used when updating a row in the table
  Map<String, dynamic> toMap() {
    final map = new Map<String, dynamic>();
    map["vendorId"] = vendorId;
    map["Firstname"] = Firstname;
    map["Lastname"] = Lastname;
    map["MobileNumber"] = MobileNumber;
    map["CompanyName"] = CompanyName;
    map["Address"] = Address;
    map["Email"] = Email;
    return map;
  }


  //to be used when converting the row into object
  factory VenderModel.fromMap(Map<String, dynamic> data) =>
      VenderModel(
        vendorId: data['vendorId'],
        Firstname: data['Firstname'],
        Lastname: data['Lastname'],
        MobileNumber: data['MobileNumber'],
        CompanyName: data['CompanyName'],
        Address: data['Address'],
        Email: data['Email'],
      );

}


