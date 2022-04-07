class EditVendorModel {
  EditVendorModel({
    this.items,
    this.success,
    this.message,
  });

  List<Item>? items;
  bool? success;
  String? message;

  factory EditVendorModel.fromJson(Map<String, dynamic> json) => EditVendorModel(
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
    this.vepariId,
    this.userId,
    this.firstName,
    this.lastName,
    this.mobile,
    this.email,
    this.address,
    this.companyName,
    this.profileImage,
    this.testId,
  });

  String? vepariId;
  String? userId;
  String? firstName;
  String? lastName;
  String? mobile;
  String? email;
  String? address;
  String? companyName;
  String? profileImage;
  String? testId;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    vepariId: json["vepari_id"],
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    mobile: json["mobile"],
    email: json["email"],
    address: json["address"],
    companyName: json["company_name"],
    profileImage: json["profile_image"],
    testId: json["test_id"],
  );

  Map<String, dynamic> toJson() => {
    "vepari_id": vepariId,
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "mobile": mobile,
    "email": email,
    "address": address,
    "company_name": companyName,
    "profile_image": profileImage,
    "test_id": testId,
  };
}
