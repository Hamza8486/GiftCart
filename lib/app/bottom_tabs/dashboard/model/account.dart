class AccountListModel {
  bool? status;
  List<Amount>? amount;
  String? message;

  AccountListModel({this.status, this.amount, this.message});

  AccountListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['amount'] != null) {
      amount = <Amount>[];
      json['amount'].forEach((v) {
        amount!.add(new Amount.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.amount != null) {
      data['amount'] = this.amount!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Amount {
  int? id;
  String? iban;
  String? accountNumber;
  String? name;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Amount(
      {this.id,
        this.iban,
        this.accountNumber,
        this.name,
        this.userId,
        this.createdAt,
        this.updatedAt});

  Amount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iban = json['iban'];
    accountNumber = json['account_number'];
    name = json['name'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iban'] = this.iban;
    data['account_number'] = this.accountNumber;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
