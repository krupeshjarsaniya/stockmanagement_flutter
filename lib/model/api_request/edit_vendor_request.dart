class EditVendorRequest{
  String vepari_id = "";
  String user_id = "";
  String first_name = "";
  String last_name = "";
  String mobile = "";
  String email = "";
  String address = "";
  String company_name = "";


  EditVendorRequest(
      this.vepari_id,
      this.user_id,
      this.first_name,
      this.last_name,
      this.mobile,
      this.company_name,
      this.address,
      this.email,
      );

  Map<String,String> toMap(){
    var map = Map<String,String>();

    map['"'+"vepari_id"+'"'] = '"'+vepari_id+'"';
    map['"'+"user_id"+'"'] = '"'+user_id+'"';
    map['"'+"first_name"+'"'] = '"'+first_name+'"';
    map['"'+"last_name"+'"'] = '"'+last_name+'"';
    map['"'+"mobile"+'"'] = '"'+mobile+'"';
    map['"'+"email"+'"'] = '"'+email+'"';
    map['"'+"address"+'"'] = '"'+address+'"';
    map['"'+"company_name"+'"'] = '"'+company_name+'"';

    return map;

  }
}