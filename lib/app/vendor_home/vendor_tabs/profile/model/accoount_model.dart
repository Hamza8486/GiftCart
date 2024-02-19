class VendorAccountModel {
  bool? success;
  Response? response;

  VendorAccountModel({this.success, this.response});

  VendorAccountModel.fromJson(Map<String, dynamic> json) {
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
  List<AllDataAccount>? data;

  Response({this.data});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AllDataAccount>[];
      json['data'].forEach((v) {
        data!.add(new AllDataAccount.fromJson(v));
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

class AllDataAccount {
  int? user;
  String? cardName;
  String? ibnNo;
  String? accountNo;

  AllDataAccount({this.user, this.cardName, this.ibnNo, this.accountNo});

  AllDataAccount.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    cardName = json['card_name'];
    ibnNo = json['ibn_no'];
    accountNo = json['account_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['card_name'] = this.cardName;
    data['ibn_no'] = this.ibnNo;
    data['account_no'] = this.accountNo;
    return data;
  }
}
