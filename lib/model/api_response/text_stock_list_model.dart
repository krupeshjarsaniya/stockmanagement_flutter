class TextStockListModel {
  TextStockListModel({
    this.items,
    this.success,
    this.message,
  });

  List<dynamic>? items;
  bool? success;
  String? message;

  factory TextStockListModel.fromJson(Map<String, dynamic> json) => TextStockListModel(
    items: List<dynamic>.from(json["items"].map((x) => x)),
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items!.map((x) => x)),
    "success": success,
    "message": message,
  };
}