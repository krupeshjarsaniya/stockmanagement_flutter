class VepariStockListRequest{
  String vepari_id = "";
  String user_id = "";
  String from = "";
  String to = "";
  String deviceType = "";
  String deviceuid = "";
  String token = "";


  VepariStockListRequest(
      this.vepari_id,
      this.user_id,
      this.from,
      this.to,
      this.deviceType,
      this.deviceuid,
      this.token
      );

  Map<String,String> toMap(){
    var map = Map<String,String>();

    map['vepari_id'] = vepari_id;
    map['user_id'] = user_id;
    map['from'] = from;
    map['to'] = to;
    map['deviceType'] = deviceType;
    map['deviceuid'] = deviceuid;
    map['token'] = token;
    return map;

  }
}





