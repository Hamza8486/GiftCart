class GetRewardsModel {
  bool? success;
  Response? response;

  GetRewardsModel({this.success, this.response});

  GetRewardsModel.fromJson(Map<String, dynamic> json) {
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
  RewardsDataModel? data;

  Response({this.data});

  Response.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new RewardsDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class RewardsDataModel {
  var coins;
  var dollarValue;
  List<Inovices>? inovices;

  RewardsDataModel({this.coins, this.inovices,this.dollarValue});

  RewardsDataModel.fromJson(Map<String, dynamic> json) {
    coins = json['coins'];
    dollarValue = json['dollar_value'];
    if (json['inovices'] != null) {
      inovices = <Inovices>[];
      json['inovices'].forEach((v) {
        inovices!.add(new Inovices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coins'] = this.coins;
    data['dollar_value'] = this.dollarValue;
    if (this.inovices != null) {
      data['inovices'] = this.inovices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Inovices {
  int? id;
  String? title;
  int? number;
  String? createdAt;

  Inovices({this.id, this.title, this.number, this.createdAt});

  Inovices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    number = json['number'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['number'] = this.number;
    data['created_at'] = this.createdAt;
    return data;
  }
}
