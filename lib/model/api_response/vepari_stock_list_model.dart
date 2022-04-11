  class VepariStockListModel {
    VepariStockListModel({
      this.debit,
      this.credit,
      this.success,
      this.message,
    });

    List<DebitModel>? debit;
    List<CreditModel>? credit;
    bool? success;
    String? message;

    factory VepariStockListModel.fromJson(Map<String, dynamic> json) => VepariStockListModel(
      // debit: List<Credit>.from(json["debit"].map((x) => Credit.fromJson(x))),
      // credit: List<Credit>.from(json["credit"].map((x) => Credit.fromJson(x))),

      debit: json['debit']!=null ? List<DebitModel>.from(json['debit'].map((x) => DebitModel.fromJson(x))):<DebitModel>[],
      credit: json['credit']!=null ? List<CreditModel>.from(json['credit'].map((x) => CreditModel.fromJson(x))):<CreditModel>[],

      success: json["success"],
      message: json["message"],
    );

    Map<String, dynamic> toJson() => {
      "debit": List<dynamic>.from(debit!.map((x) => x.toJson())),
      "credit": List<dynamic>.from(credit!.map((x) => x.toJson())),
      "success": success,
      "message": message,
    };
  }

  class DebitModel {
    DebitModel({
      this.isCheck = false,
      this.stockId,
      this.vepariId,
      this.vepariName,
      this.userId,
      this.debitCredit,
      this.description,
      this.date,
      this.touch,
      this.weight,
      this.otherDebit,
      this.fineWeight,
      this.stockDate,
    });

    bool? isCheck;
    String? stockId;
    String? vepariId;
    String? vepariName;
    String? userId;
    String? debitCredit;
    String? description;
    String? date;
    String? touch;
    String? weight;
    String? otherDebit;
    String? fineWeight;
    String? stockDate;

    factory DebitModel.fromJson(Map<String, dynamic> json) => DebitModel(
      stockId: json["stock_id"],
      vepariId: json["vepari_id"],
      vepariName: json["vepari_name"],
      userId: json["user_id"],
      debitCredit: json["debit_credit"],
      description: json["description"],
      date: json["date"],
      touch: json["touch"],
      weight: json["weight"],
      otherDebit: json["other_debit"],
      fineWeight: json["fine_weight"],
      stockDate: json["stock_date"],
    );

    Map<String, dynamic> toJson() => {
      "stock_id": stockId,
      "vepari_id": vepariId,
      "vepari_name": vepariName,
      "user_id": userId,
      "debit_credit": debitCredit,
      "description": description,
      "date": date,
      "touch": touch,
      "weight": weight,
      "other_debit": otherDebit,
      "fine_weight": fineWeight,
      "stock_date": stockDate,
    };
  }


  class CreditModel {
    CreditModel({
      this.isCheck = false,
      this.stockId,
      this.vepariId,
      this.vepariName,
      this.userId,
      this.debitCredit,
      this.description,
      this.date,
      this.touch,
      this.weight,
      this.otherDebit,
      this.fineWeight,
      this.stockDate,
    });

    bool? isCheck;
    String? stockId;
    String? vepariId;
    String? vepariName;
    String? userId;
    String? debitCredit;
    String? description;
    String? date;
    String? touch;
    String? weight;
    String? otherDebit;
    String? fineWeight;
    String? stockDate;

    factory CreditModel.fromJson(Map<String, dynamic> json) => CreditModel(
      stockId: json["stock_id"],
      vepariId: json["vepari_id"],
      vepariName: json["vepari_name"],
      userId: json["user_id"],
      debitCredit: json["debit_credit"],
      description: json["description"],
      date: json["date"],
      touch: json["touch"],
      weight: json["weight"],
      otherDebit: json["other_debit"],
      fineWeight: json["fine_weight"],
      stockDate: json["stock_date"],
    );

    Map<String, dynamic> toJson() => {
      "stock_id": stockId,
      "vepari_id": vepariId,
      "vepari_name": vepariName,
      "user_id": userId,
      "debit_credit": debitCredit,
      "description": description,
      "date": date,
      "touch": touch,
      "weight": weight,
      "other_debit": otherDebit,
      "fine_weight": fineWeight,
      "stock_date": stockDate,
    };
  }
