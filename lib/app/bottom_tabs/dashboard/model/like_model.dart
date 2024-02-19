class GeLikeModel {
  bool? success;
  LikeResponse? response;

  GeLikeModel({this.success, this.response});

  GeLikeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    response = json['response'] != null
        ? new LikeResponse.fromJson(json['response'])
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

class LikeResponse {
  Data? data;

  LikeResponse({this.data});

  LikeResponse.fromJson(Map<String, dynamic> json) {
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
  int? user;
  int? slot;
  String? firstName;
  String? lastName;
  var phone;
  String? email;
  String? address;
  bool? isApproved;
  String? image;
  String? video;
  String? createdAt;
  var totalComment;
  var totalLike;
  bool? isLiked;

  Data(
      {this.id,
        this.user,
        this.slot,
        this.firstName,
        this.lastName,
        this.phone,
        this.email,
        this.address,
        this.isApproved,
        this.image,
        this.video,
        this.createdAt,
        this.totalComment,
        this.totalLike,
        this.isLiked});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    slot = json['slot'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    isApproved = json['is_approved'];
    image = json['image'];
    video = json['video'];
    createdAt = json['created_at'];
    totalComment = json['total_comment'];
    totalLike = json['total_like'];
    isLiked = json['is_liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['slot'] = this.slot;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['address'] = this.address;
    data['is_approved'] = this.isApproved;
    data['image'] = this.image;
    data['video'] = this.video;
    data['created_at'] = this.createdAt;
    data['total_comment'] = this.totalComment;
    data['total_like'] = this.totalLike;
    data['is_liked'] = this.isLiked;
    return data;
  }
}
