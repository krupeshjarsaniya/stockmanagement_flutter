class DashBordModel {
  DashBordModel({
    this.items,
    this.payment,
    this.totalDebit,
    this.totalCredit,
    this.balance,
    this.success,
    this.message,
  });

  List<dynamic>? items;
  bool? payment;
  String? totalDebit;
  String? totalCredit;
  String? balance;
  bool? success;
  String? message;

  factory DashBordModel.fromJson(Map<String, dynamic> json) => DashBordModel(
    items: List<dynamic>.from(json["items"].map((x) => x)),
    payment: json["payment"],
    totalDebit: json["total_debit"],
    totalCredit: json["total_credit"],
    balance: json["balance"],
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items!.map((x) => x)),
    "payment": payment,
    "total_debit": totalDebit,
    "total_credit": totalCredit,
    "balance": balance,
    "success": success,
    "message": message,
  };
}
