class EditStocksModel {
  EditStocksModel({
    this.items,
    this.success,
    this.message,
  });

  List<Item>? items;
  bool? success;
  String? message;

  factory EditStocksModel.fromJson(Map<String, dynamic> json) => EditStocksModel(
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
    this.stockId,
    this.vepariId,
    this.userId,
    this.debitCredit,
    this.description,
    this.touch,
    this.weight,
    this.fineWeight,
    this.stockDate,
    this.testId,
  });

  String? stockId;
  String? vepariId;
  String? userId;
  String? debitCredit;
  String? description;
  String? touch;
  String? weight;
  String? fineWeight;
  String? stockDate;
  String? testId;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    stockId: json["stock_id"],
    vepariId: json["vepari_id"],
    userId: json["user_id"],
    debitCredit: json["debit_credit"],
    description: json["description"],
    touch: json["touch"],
    weight: json["weight"],
    fineWeight: json["fine_weight"],
    stockDate: json["stock_date"],
    testId: json["test_id"],
  );

  Map<String, dynamic> toJson() => {
    "stock_id": stockId,
    "vepari_id": vepariId,
    "user_id": userId,
    "debit_credit": debitCredit,
    "description": description,
    "touch": touch,
    "weight": weight,
    "fine_weight": fineWeight,
    "stock_date": stockDate,
    "test_id": testId,
  };
}