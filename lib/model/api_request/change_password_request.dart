class ChangePasswordRequest{
  String user_id = "";
  String old_password = "";
  String new_password = "";
  String confirm_password = "";
  String deviceType = "";
  String deviceuid = "";
  String token = "";


  ChangePasswordRequest(
      this.user_id,
      this.old_password,
      this.new_password,
      this.confirm_password,
      this.deviceType,
      this.deviceuid,
      this.token,
      );

  Map<String,String> toMap(){
    var map = Map<String,String>();

    map['user_id'] = user_id;
    map['old_password'] = old_password;
    map['new_password'] = new_password;
    map['confirm_password'] = confirm_password;
    map['deviceType'] = deviceType;
    map['deviceuid'] = deviceuid;
    map['token'] = token;

    return map;

  }
}