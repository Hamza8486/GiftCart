class NewStoreModel {
  bool? success;
  Response? response;

  NewStoreModel({this.success, this.response});

  NewStoreModel.fromJson(Map<String, dynamic> json) {
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
  List<StoreDataModel>? data;

  Response({this.data});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <StoreDataModel>[];
      json['data'].forEach((v) {
        data!.add(new StoreDataModel.fromJson(v));
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

class StoreDataModel {
  int? id;
  String? name;
  String? address;
 var openTime;
  int? rating;
  String? logo;

  StoreDataModel(
      {this.id,
        this.name,
        this.address,
        this.openTime,
        this.rating,
        this.logo});

  StoreDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    openTime = json['open_time'];
    rating = json['rating'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['open_time'] = this.openTime;
    data['rating'] = this.rating;
    data['logo'] = this.logo;
    return data;
  }
}
