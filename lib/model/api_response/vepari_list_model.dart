class VepariListModel {
  VepariListModel({
    this.items,
    this.success,
    this.message,
  });

  List<VepariListItem>? items;
  bool? success;
  String? message;

  factory VepariListModel.fromJson(Map<String, dynamic> json) => VepariListModel(
    // items: List<VepariListItem>.from(json["items"].map((x) => VepariListItem.fromJson(x))),
    items: json['items']!=null ? List<VepariListItem>.from(json['items'].map((x) => VepariListItem.fromJson(x))):<VepariListItem>[],
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    "success": success,
    "message": message,
  };
}

class VepariListItem {
  VepariListItem({
    this.vepariId,
    this.firstName,
    this.lastName,
    this.mobile,
    this.unit,
    this.email,
    this.address,
    this.companyName,
    this.profilePicture,
    this.createdAt,
  });

  String? vepariId;
  String? firstName;
  String? lastName;
  String? mobile;
  String? unit;
  String? email;
  String? address;
  String? companyName;
  String? profilePicture;
  String? createdAt;

  factory VepariListItem.fromJson(Map<String, dynamic> json) => VepariListItem(
    vepariId: json["vepari_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    mobile: json["mobile"],
    unit: json["unit"],
    email: json["email"],
    address: json["address"],
    companyName: json["company_name"],
    profilePicture: json["profile_picture"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "vepari_id": vepariId,
    "first_name": firstName,
    "last_name": lastName,
    "mobile": mobile,
    "unit": unit,
    "email": email,
    "address": address,
    "company_name": companyName,
    "profile_picture": profilePicture,
    "created_at": createdAt,
  };
}