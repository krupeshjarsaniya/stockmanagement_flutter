class DashBordRequest{
  String user_id = "";
  String deviceType = "";
  String deviceuid = "";
  String token = "";


  DashBordRequest(
      this.user_id,
      this.deviceType,
      this.deviceuid,
      this.token,
      );

  Map<String,String> toMap(){
    var map = Map<String,String>();
    map["user_id"] = user_id;
    map["deviceType"] = deviceType;
    map["deviceuid"] = deviceuid;
    map["token"] = token;
    return map;

  }
}