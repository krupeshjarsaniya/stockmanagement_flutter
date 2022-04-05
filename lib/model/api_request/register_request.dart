class UserRegisterRequest{
  String first_name = "";
  String last_name = "";
  String mobile = "";
  String email = "";
  String password = "";
  String deviceType = "";
  String deviceuid = "";
  String token = "";


  UserRegisterRequest(
      this.first_name,
      this.last_name,
      this.mobile,
      this.email,
      this.password,
      this.deviceType,
      this.deviceuid,
      this.token
      );

  Map<String,String> toMap(){
    var map = Map<String,String>();

    map['first_name'] = first_name;
    map['last_name'] = last_name;
    map['mobile'] = mobile;
    map['email'] = email;
    map['password'] = password;
    map['deviceType'] = deviceType;
    map['deviceuid'] = deviceuid;
    map['token'] = token;
    return map;

  }
}





