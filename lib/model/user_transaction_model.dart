class UserTransactionsModel {
  String? error;
  String? message;
  List<TransactionData>? data;

  UserTransactionsModel({this.error, this.message, this.data});

  UserTransactionsModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TransactionData>[];
      json['data'].forEach((v) {
        data!.add(new TransactionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TransactionData {
  String? userName;
  int? transactionId;
  int? orderId;
  String? status;
  String? amount;
  String? currency;
  String? createdAtHuman;
  String? createdAt;
  Plan? plan;

  TransactionData(
      {this.userName,
        this.transactionId,
        this.orderId,
        this.status,
        this.amount,
        this.currency,
        this.createdAtHuman,
        this.createdAt,
        this.plan});

  TransactionData.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    transactionId = json['transaction_id'];
    orderId = json['order_id'];
    status = json['status'];
    amount = json['amount'];
    currency = json['currency'];
    createdAtHuman = json['created_at_human'];
    createdAt = json['created_at'];
    plan = json['plan'] != null ? new Plan.fromJson(json['plan']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['transaction_id'] = this.transactionId;
    data['order_id'] = this.orderId;
    data['status'] = this.status;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['created_at_human'] = this.createdAtHuman;
    data['created_at'] = this.createdAt;
    if (this.plan != null) {
      data['plan'] = this.plan!.toJson();
    }
    return data;
  }
}

class Plan {
  int? planId;
  String? name;
  String? price;
  String? duration;

  Plan({this.planId, this.name, this.price, this.duration});

  Plan.fromJson(Map<String, dynamic> json) {
    planId = json['plan_id'];
    name = json['name'];
    price = json['price'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plan_id'] = this.planId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['duration'] = this.duration;
    return data;
  }
}
