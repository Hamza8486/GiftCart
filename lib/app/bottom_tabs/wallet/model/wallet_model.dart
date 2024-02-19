class GetWalletModel {
  bool? status;
  Data? data;
  String? message;

  GetWalletModel({this.status, this.data, this.message});

  GetWalletModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? balance;
  List<Transaction>? transaction;

  Data({this.id, this.balance, this.transaction});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    balance = json['balance'];
    if (json['transaction'] != null) {
      transaction = <Transaction>[];
      json['transaction'].forEach((v) {
        transaction!.add(new Transaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['balance'] = this.balance;
    if (this.transaction != null) {
      data['transaction'] = this.transaction!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transaction {
  int? id;
  String? type;
  String? amount;
  int? walletId;
  Province? province;
  int? slot;

  Transaction(
      {this.id,
        this.type,
        this.amount,
        this.walletId,
        this.province,
        this.slot});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    amount = json['amount'];
    walletId = json['wallet_id'];
    province = json['province'] != null
        ? new Province.fromJson(json['province'])
        : null;
    slot = json['slot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['wallet_id'] = this.walletId;
    if (this.province != null) {
      data['province'] = this.province!.toJson();
    }
    data['slot'] = this.slot;
    return data;
  }
}

class Province {
  int? id;
  String? name;

  Province({this.id, this.name});

  Province.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
