class VepariStockListModel {
  VepariStockListModel({
    this.debit,
    this.credit,
    this.totalDebit,
    this.totalCredit,
    this.balance,
    this.totalOtherDebit,
    this.totalOtherCredit,
    this.otherCharges,
    this.success,
    this.message,
  });

  List<dynamic>? debit;
  List<dynamic>? credit;
  String? totalDebit;
  String? totalCredit;
  String? balance;
  String? totalOtherDebit;
  String? totalOtherCredit;
  String? otherCharges;
  bool? success;
  String? message;

  factory VepariStockListModel.fromJson(Map<String, dynamic> json) => VepariStockListModel(
    debit: List<dynamic>.from(json["debit"].map((x) => x)),
    credit: List<dynamic>.from(json["credit"].map((x) => x)),
    totalDebit: json["total_debit"],
    totalCredit: json["total_credit"],
    balance: json["balance"],
    totalOtherDebit: json["total_other_debit"],
    totalOtherCredit: json["total_other_credit"],
    otherCharges: json["other_charges"],
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "debit": List<dynamic>.from(debit!.map((x) => x)),
    "credit": List<dynamic>.from(credit!.map((x) => x)),
    "total_debit": totalDebit,
    "total_credit": totalCredit,
    "balance": balance,
    "total_other_debit": totalOtherDebit,
    "total_other_credit": totalOtherCredit,
    "other_charges": otherCharges,
    "success": success,
    "message": message,
  };
}
