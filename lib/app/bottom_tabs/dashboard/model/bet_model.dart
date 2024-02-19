class GetBetModel {
  bool? status;
  List<BetModelData>? data;
  String? baseUrl;
  String? message;

  GetBetModel({this.status, this.data, this.baseUrl, this.message});

  GetBetModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <BetModelData>[];
      json['data'].forEach((v) {
        data!.add(new BetModelData.fromJson(v));
      });
    }
    baseUrl = json['base_url'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['base_url'] = this.baseUrl;
    data['message'] = this.message;
    return data;
  }
}

class BetModelData {
  int? id;
  String? title;
  String? pricePerSlot;
  String? endDate;
  String? startDate;
  int? status;
  String? type;
  String? createdAt;
  String? updatedAt;

  BetModelData(
      {this.id,
        this.title,
        this.pricePerSlot,
        this.endDate,
        this.startDate,
        this.status,
        this.type,
        this.createdAt,
        this.updatedAt});

  BetModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    pricePerSlot = json['price_per_slot'];
    endDate = json['end_date'];
    startDate = json['start_date'];
    status = json['status'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price_per_slot'] = this.pricePerSlot;
    data['end_date'] = this.endDate;
    data['start_date'] = this.startDate;
    data['status'] = this.status;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
