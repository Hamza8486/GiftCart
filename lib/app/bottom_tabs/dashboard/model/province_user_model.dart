class GetProvinceUserModel {
  bool? success;
  Response? response;

  GetProvinceUserModel({this.success, this.response});

  GetProvinceUserModel.fromJson(Map<String, dynamic> json) {
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
  List<Data>? data;

  Response({this.data});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? provinceName;
  String? user;
  int? slotCount;

  Data({this.provinceName, this.user, this.slotCount});

  Data.fromJson(Map<String, dynamic> json) {
    provinceName = json['province_name'];
    user = json['user'];
    slotCount = json['slot_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['province_name'] = this.provinceName;
    data['user'] = this.user;
    data['slot_count'] = this.slotCount;
    return data;
  }
}
