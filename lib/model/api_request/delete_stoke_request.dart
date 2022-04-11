
class DeleteStockRequest{
  String vepari_id = "";

  DeleteStockRequest(
      this.vepari_id,
      );

  Map<String,String> toMap(){
    var map = Map<String,String>();

    map['"'+"stock_id"+'"'] = '"'+vepari_id+'"';

    return map;

  }
}