class RegisterDeviceRequest{
  String appname = "";
  String appversion = "";
  String deviceuid = "";
  String devicetoken = "";
  String devicename = "";
  String devicemodel = "";
  String pushbadge = "";
  String pushalert = "";
  String pushsound = "";
  String deviceversion = "";


  RegisterDeviceRequest(
      this.appname,
      this.appversion,
      this.deviceuid,
      this.devicetoken,
      this.devicename,
      this.devicemodel,
      this.pushbadge,
      this.pushalert,
      this.pushsound,
      this.deviceversion,
      );

  Map<String,String> toMap(){
    var map = Map<String,String>();
    map['appname'] = appname;
    map['appversion'] = appversion;
    map['deviceuid'] = deviceuid;
    map['devicetoken'] = devicetoken;
    map['devicename'] = devicename;
    map['devicemodel'] = devicemodel;
    map['pushbadge'] = pushbadge;
    map['pushalert'] = pushalert;
    map['pushsound'] = pushsound;
    map['deviceversion'] = deviceversion;
    return map;

  }
}





