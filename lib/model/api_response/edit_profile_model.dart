class EditProfileModel {
  EditProfileModel({
    this.items,
    this.success,
    this.message,
  });

  List<Item>? items;
  bool? success;
  String? message;

  factory EditProfileModel.fromJson(Map<String, dynamic> json) => EditProfileModel(
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
    this.unit,
    this.email,
    this.mobile,
    this.profilePicture,
  });

  String? userId;
  String? firstName;
  String? lastName;
  String? unit;
  String? email;
  String? mobile;
  String? profilePicture;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    unit: json["unit"],
    email: json["email"],
    mobile: json["mobile"],
    profilePicture: json["profile_picture"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "unit": unit,
    "email": email,
    "mobile": mobile,
    "profile_picture": profilePicture,
  };
}
