
class StockDeleteModel {
  StockDeleteModel({
    this.items,
    this.success,
    this.message,
  });

  List<StockDeleteItem>? items;
  bool? success;
  String? message;

  factory StockDeleteModel.fromJson(Map<String, dynamic> json) => StockDeleteModel(
    // items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    items: json['items']!=null ? List<StockDeleteItem>.from(json['items'].map((x) => StockDeleteItem.fromJson(x))):<StockDeleteItem>[],
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    "success": success,
    "message": message,
  };
}

class StockDeleteItem {
  StockDeleteItem({
    this.stockId,
  });

  String? stockId;

  factory StockDeleteItem.fromJson(Map<String, dynamic> json) => StockDeleteItem(
    stockId: json["stock_id"],
  );

  Map<String, dynamic> toJson() => {
    "stock_id": stockId,
  };
}
