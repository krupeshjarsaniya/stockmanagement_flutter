class RegisterModel {
  RegisterModel({
    this.items,
    this.success,
    this.message,
  });

  List<RegisterItems>? items;
  bool? success;
  String? message;

  factory RegisterModel.fromJson(Map<dynamic, dynamic> json) => RegisterModel(
    // items: RegisterItems.fromJson(json["items"]),
    // items: List<RegisterItems>.from(json["items"].map((x) => RegisterItems.fromJson(x))),

  // items: json['items']!=null ? List<RegisterItems>.from(json['items'].map((x) => RegisterItems.fromJson(x))):<RegisterItems>[],

    success: json["success"],
    message: json["message"],
  );

  Map<dynamic, dynamic> toJson() => {
    // "items": items,
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    "success": success,
    "message": message,
  };
}

class RegisterItems {
  RegisterItems({
    this.userId,
  });

  int? userId;

  factory RegisterItems.fromJson(Map<dynamic, dynamic> json) => RegisterItems(
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
  };
}
