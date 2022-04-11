class EditStocksRequest{
  String stock_id = "";
  String user_id = "";
  String debit_credit = "";
  String weight = "";
  String touch = "";
  String fine_weight = "";
  String stock_date = "";
  String vepari_id = "";
  String description = "";


  EditStocksRequest(
      this.stock_id,
      this.user_id,
      this.debit_credit,
      this.weight,
      this.touch,
      this.fine_weight,
      this.stock_date,
      this.vepari_id,
      this.description,
      );

  Map<String,String> toMap(){
    var map = Map<String,String>();

    map['"'+"stock_id"+'"'] = '"'+stock_id+'"';
    map['"'+"user_id"+'"'] = '"'+user_id+'"';
    map['"'+"debit_credit"+'"'] = '"'+debit_credit+'"';
    map['"'+"weight"+'"'] = '"'+weight+'"';
    map['"'+"touch"+'"'] = '"'+touch+'"';
    map['"'+"fine_weight"+'"'] = '"'+fine_weight+'"';
    map['"'+"stock_date"+'"'] = '"'+stock_date+'"';
    map['"'+"vepari_id"+'"'] = '"'+vepari_id+'"';
    map['"'+"description"+'"'] = '"'+description+'"';

    return map;

  }
}