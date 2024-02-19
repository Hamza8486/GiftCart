class GetProvinceModel {
  bool? success;
  Response? response;

  GetProvinceModel({this.success, this.response});

  GetProvinceModel.fromJson(Map<String, dynamic> json) {
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
  List<Province>? data;

  Response({this.data});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Province>[];
      json['data'].forEach((v) {
        data!.add(new Province.fromJson(v));
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

class Province {
  String? name;
  int? id;
  var image;
  String? createdAt;

  Province({this.name, this.image, this.createdAt,this.id});

  Province.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    return data;
  }
}
