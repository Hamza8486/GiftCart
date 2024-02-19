class TestMonialsModel {
  bool? success;
  Response? response;

  TestMonialsModel({this.success, this.response});

  TestMonialsModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? user;
  int? slot;
  String? firstName;
  String? lastName;
  var phone;
  String? email;
  String? address;
  String? image;
  var likes;
  var comments;
  String? video;
  String? createdAt;

  Data(
      {this.id,
        this.user,
        this.slot,
        this.likes,
        this.comments,
        this.firstName,
        this.lastName,
        this.phone,
        this.email,
        this.address,
        this.image,
        this.video,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    slot = json['slot'];
    likes = json['likes'];
    comments = json['comments'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    image = json['image'];
    video = json['video'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['likes'] = this.likes;
    data['comments'] = this.comments;
    data['slot'] = this.slot;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['address'] = this.address;
    data['image'] = this.image;
    data['video'] = this.video;
    data['created_at'] = this.createdAt;
    return data;
  }
}

