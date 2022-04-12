
class AddTransactionRequest{
  String vepari_id = "";
  String user_id = "";
  String debit_credit = "";
  String description = "";
  String weight = "";
  String touch = "";
  String fine_weight = "";
  String stock_date = "";


  AddTransactionRequest(
      this.vepari_id,
      this.user_id,
      this.debit_credit,
      this.description,
      this.weight,
      this.touch,
      this.fine_weight,
      this.stock_date,

      );

  Map<String,String> toMap(){
    var map = Map<String,String>();
    map['"'+"vepari_id"+'"'] = '"'+vepari_id+'"';
    map['"'+"user_id"+'"'] = '"'+user_id+'"';
    map['"'+"debit_credit"+'"'] = '"'+debit_credit+'"';
    map['"'+"description"+'"'] = '"'+description+'"';
    map['"'+"weight"+'"'] = '"'+weight+'"';
    map['"'+"touch"+'"'] = '"'+touch+'"';
    map['"'+"fine_weight"+'"'] = '"'+fine_weight+'"';
    map['"'+"stock_date"+'"'] = '"'+stock_date+'"';
    return map;
  }
}