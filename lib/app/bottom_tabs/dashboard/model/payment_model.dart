class PaymentProofModel {
  bool? success;
  Response? response;

  PaymentProofModel({this.success, this.response});

  PaymentProofModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    return data;
  }
}

class Response {
  List<PaymentProofAllData>? data;

  Response({this.data});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PaymentProofAllData>[];
      json['data'].forEach((v) {
        data!.add(new PaymentProofAllData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentProofAllData {
  int? id;
  User? user;
  String? createdAt;
  String? amount;
  String? status;

  PaymentProofAllData({this.id, this.user, this.createdAt, this.amount, this.status});

  PaymentProofAllData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['transaction_status'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    createdAt = json['created_at'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transaction_status'] = this.status;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['amount'] = this.amount;
    return data;
  }
}

class User {
  int? id;
  String? fullName;
  var logo;

  User({this.id, this.fullName, this.logo});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['logo'] = this.logo;
    return data;
  }
}
