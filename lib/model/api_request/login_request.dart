class UserLogInRequest{
  String mobile = "";
  String password = "";
  String deviceType = "";
  String deviceuid = "";
  String token = "";


  UserLogInRequest(
      this.mobile,
      this.password,
      this.deviceType,
      this.deviceuid,
      this.token
      );

  Map<String,String> toMap(){
    var map = Map<String,String>();

    map['mobile'] = mobile;
    map['password'] = password;
    map['deviceType'] = deviceType;
    map['deviceuid'] = deviceuid;
    map['token'] = token;

    return map;

  }
}