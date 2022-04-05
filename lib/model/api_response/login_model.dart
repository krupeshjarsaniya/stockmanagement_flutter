class LoginModel {
  LoginModel({
    this.items,
    this.success,
    this.message,
  });

  List<Item>? items;
  bool? success;
  String? message;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    "success": success,
    "message": message,
  };
}

class Item {
  Item({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.unit,
    this.profilePicture,
  });

  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? unit;
  String? profilePicture;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    mobile: json["mobile"],
    unit: json["unit"],
    profilePicture: json["profile_picture"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "mobile": mobile,
    "unit": unit,
    "profile_picture": profilePicture,
  };
}
