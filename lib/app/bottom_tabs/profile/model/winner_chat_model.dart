class WinnersChatModel {
  bool? success;
  WinnerChatAllModelDData? response;

  WinnersChatModel({this.success, this.response});

  WinnersChatModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    response = json['response'] != null
        ? new WinnerChatAllModelDData.fromJson(json['response'])
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

class WinnerChatAllModelDData {
  Data? data;

  WinnerChatAllModelDData({this.data});

  WinnerChatAllModelDData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? text;
  bool? isRead;
  String? createdAt;
  Receiver? receiver;

  Data({this.id, this.text, this.isRead, this.createdAt, this.receiver});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
    receiver = json['receiver'] != null
        ? new Receiver.fromJson(json['receiver'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['is_read'] = this.isRead;
    data['created_at'] = this.createdAt;
    if (this.receiver != null) {
      data['receiver'] = this.receiver!.toJson();
    }
    return data;
  }
}

class Receiver {
  int? id;
  String? fullName;
  var logo;

  Receiver({this.id, this.fullName, this.logo});

  Receiver.fromJson(Map<String, dynamic> json) {
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
