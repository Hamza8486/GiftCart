class GetNotificationModel {
  bool? success;
  Response? response;

  GetNotificationModel({this.success, this.response});

  GetNotificationModel.fromJson(Map<String, dynamic> json) {
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
  String? text;
  String? date;
  String? time;
  int? user;
  var title;
  String? createdAt;

  Data({this.id, this.text, this.user,this.time,this.date, this.title, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    date = json['date'];
    time = json['time'];
    user = json['user'];
    title = json['title'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['date'] = this.date;
    data['time'] = this.time;
    data['user'] = this.user;
    data['title'] = this.title;
    data['created_at'] = this.createdAt;
    return data;
  }
}
