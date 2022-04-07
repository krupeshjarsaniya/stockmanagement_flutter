class EditProfileRequest{
  String user_id = "";
  String first_name = "";
  String last_name = "";
  String mobile = "";
  String email = "";
  String deviceType = "";
  String deviceuid = "";
  String token = "";



  EditProfileRequest(
      this.user_id,
      this.first_name,
      this.last_name,
      this.mobile,
      this.email,
      this.deviceType,
      this.deviceuid,
      this.token,
      );

  Map<String,String> toMap(){
    var map = Map<String,String>();

    map["user_id"] = user_id;
    map["first_name"] = first_name;
    map["last_name"] = last_name;
    map["mobile"] = mobile;
    map["email"] = email;
    map["deviceType"] = deviceType;
    map["deviceuid"] = deviceuid;
    map["token"] = token;

    return map;

  }
}