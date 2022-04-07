import 'dart:io';

class AddVepariRequest{
  String user_id = "";
  String first_name = "";
  String last_name = "";
  String mobile = "";
  String email = "";
  String address = "";
  String company_name = "";
  String deviceType = "";
  String deviceuid = "";
  String token = "";



  AddVepariRequest(
      this.user_id,
      this.first_name,
      this.last_name,
      this.mobile,
      this.company_name,
      this.address,
      this.email,
      this.deviceType,
      this.deviceuid,
      this.token,
      );

  Map<String,String> toMap(){
    var map = Map<String,String>();

    map['"'+"user_id"+'"'] = '"'+user_id+'"';
    map['"'+"first_name"+'"'] = '"'+first_name+'"';
    map['"'+"last_name"+'"'] = '"'+last_name+'"';
    map['"'+"mobile"+'"'] = '"'+mobile+'"';
    map['"'+"email"+'"'] = '"'+email+'"';
    map['"'+"address"+'"'] = '"'+address+'"';
    map['"'+"company_name"+'"'] = '"'+company_name+'"';
    map['"'+"deviceType"+'"'] = '"'+deviceType+'"';
    map['"'+"deviceuid"+'"'] = '"'+deviceuid+'"';
    map['"'+"token"+'"'] = '"'+token+'"';

    return map;

  }
}