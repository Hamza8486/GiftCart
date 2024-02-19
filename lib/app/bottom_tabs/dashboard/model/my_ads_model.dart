class MyAdsModel {
  bool? success;
  Response? response;

  MyAdsModel({this.success, this.response});

  MyAdsModel.fromJson(Map<String, dynamic> json) {
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
  List<MyAllModelData>? data;

  Response({this.data});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MyAllModelData>[];
      json['data'].forEach((v) {
        data!.add(new MyAllModelData.fromJson(v));
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

class MyAllModelData {
  int? user;
  String? title;
  String? offerType;
  String? offerTypeValue;
  String? description;
  String? address;
  bool? isWebsite;
  bool? isWhatsapp;
  String? website;
  var whatsapp;
  int? adDay;
  int? budget;
  bool? isScheduled;
  String? startTime;
  String? endTime;
  String? adDate;
  String? image;

  MyAllModelData(
      {this.user,
        this.title,
        this.offerType,
        this.offerTypeValue,
        this.description,
        this.address,
        this.isWebsite,
        this.isWhatsapp,
        this.website,
        this.whatsapp,
        this.adDay,
        this.budget,
        this.isScheduled,
        this.startTime,
        this.endTime,
        this.adDate,
        this.image});

  MyAllModelData.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    title = json['title'];
    offerType = json['offer_type'];
    offerTypeValue = json['offer_type_value'];
    description = json['description'];
    address = json['address'];
    isWebsite = json['is_website'];
    isWhatsapp = json['is_whatsapp'];
    website = json['website'];
    whatsapp = json['whatsapp'];
    adDay = json['ad_day'];
    budget = json['budget'];
    isScheduled = json['is_scheduled'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    adDate = json['ad_date'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['title'] = this.title;
    data['offer_type'] = this.offerType;
    data['offer_type_value'] = this.offerTypeValue;
    data['description'] = this.description;
    data['address'] = this.address;
    data['is_website'] = this.isWebsite;
    data['is_whatsapp'] = this.isWhatsapp;
    data['website'] = this.website;
    data['whatsapp'] = this.whatsapp;
    data['ad_day'] = this.adDay;
    data['budget'] = this.budget;
    data['is_scheduled'] = this.isScheduled;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['ad_date'] = this.adDate;
    data['image'] = this.image;
    return data;
  }
}
