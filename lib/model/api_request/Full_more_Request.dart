class FullViewDetailrequest{
  String user_id = "";
  String from = "";
  String to = "";
  String deviceType = "";
  String deviceuid = "";


  FullViewDetailrequest(
      this.user_id,
      this.from,
      this.to,
      this.deviceType,
      this.deviceuid,
      );

  Map<String,String> toMap(){
    var map = Map<String,String>();

    map["user_id"] = user_id;
    map["from"] = from;
    map["to"] = to;
    map["deviceType"] = deviceType;
    map["deviceuid"] = deviceuid;


    return map;

  }
}