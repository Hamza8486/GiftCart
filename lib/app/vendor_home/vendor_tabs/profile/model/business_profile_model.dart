class BusinessProfileModel {
  bool? success;
  BusinessProfileResponse? response;

  BusinessProfileModel({this.success, this.response});

  BusinessProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    response = json['response'] != null
        ? new BusinessProfileResponse.fromJson(json['response'])
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

class BusinessProfileResponse {
  Data? data;

  BusinessProfileResponse({this.data});

  BusinessProfileResponse.fromJson(Map<String, dynamic> json) {
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
  String? fullName;
  String? logo;
  String? occupation;
  int? province;
  String? role;
  String? refer;
  Store? store;
  String? email;
  var totalInvite;
  bool? isReferenceUsed;

  Data(
      {this.id,
        this.fullName,
        this.logo,
        this.occupation,
        this.province,
        this.role,
        this.refer,
        this.store,
        this.email,
        this.totalInvite,
        this.isReferenceUsed});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refer = json['referel_code'];
    fullName = json['full_name'];
    logo = json['logo'];
    occupation = json['occupation'];
    province = json['province'];
    role = json['role'];
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
    email = json['email'];
    totalInvite = json['total_invite'];
    isReferenceUsed = json['is_reference_used'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['referel_code'] = this.refer;
    data['full_name'] = this.fullName;
    data['logo'] = this.logo;
    data['occupation'] = this.occupation;
    data['province'] = this.province;
    data['role'] = this.role;
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    data['email'] = this.email;
    data['total_invite'] = this.totalInvite;
    data['is_reference_used'] = this.isReferenceUsed;
    return data;
  }
}

class Store {
  int? id;
  int? user;
  String? name;
  String? description;
  String? contact;
  String? address;
  String? banner;
  String? logo;
  String? term;
  String? policy;
  String? resolution;
  String? businessInfo;
  String? slug;
  var balance;
  String? openTime;
  String? endTime;
  var rating;

  Store(
      {this.id,
        this.user,
        this.name,
        this.description,
        this.contact,
        this.address,
        this.banner,
        this.logo,
        this.term,
        this.policy,
        this.resolution,
        this.businessInfo,
        this.slug,
        this.balance,
        this.openTime,
        this.endTime,
        this.rating});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    name = json['name'];
    description = json['description'];
    contact = json['contact'];
    address = json['address'];
    banner = json['banner'];
    logo = json['logo'];
    term = json['term'];
    policy = json['policy'];
    resolution = json['resolution'];
    businessInfo = json['business_info'];
    slug = json['slug'];
    balance = json['balance'];
    openTime = json['open_time'];
    endTime = json['end_time'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['name'] = this.name;
    data['description'] = this.description;
    data['contact'] = this.contact;
    data['address'] = this.address;
    data['banner'] = this.banner;
    data['logo'] = this.logo;
    data['term'] = this.term;
    data['policy'] = this.policy;
    data['resolution'] = this.resolution;
    data['business_info'] = this.businessInfo;
    data['slug'] = this.slug;
    data['balance'] = this.balance;
    data['open_time'] = this.openTime;
    data['end_time'] = this.endTime;
    data['rating'] = this.rating;
    return data;
  }
}
