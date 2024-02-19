class GetProfileModel {
  bool? success;
  ProfileDataModel? response;

  GetProfileModel({this.success, this.response});

  GetProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    response = json['response'] != null
        ? new ProfileDataModel.fromJson(json['response'])
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

class ProfileDataModel {
  Data? data;

  ProfileDataModel({this.data});

  ProfileDataModel.fromJson(Map<String, dynamic> json) {
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
  String? phoneNumber;
  var logo;
  String? occupation;
  Province? province;
  String? email;
  bool? claimReward;
  String? referelCode;
  var reward;
  var gift;

  Data(
      {this.id,
        this.fullName,
        this.phoneNumber,
        this.gift,
        this.logo,
        this.occupation,
        this.province,
        this.email,
        this.claimReward,
        this.referelCode,
        this.reward});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    gift = json['gift'];
    phoneNumber = json['phone_number'];
    logo = json['logo'];
    occupation = json['occupation'];
    province = json['province'] != null
        ? new Province.fromJson(json['province'])
        : null;
    email = json['email'];
    claimReward = json['claim_reward'];
    referelCode = json['referel_code'];
    reward = json['reward'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['phone_number'] = this.phoneNumber;
    data['gift'] = this.gift;
    data['logo'] = this.logo;
    data['occupation'] = this.occupation;
    if (this.province != null) {
      data['province'] = this.province!.toJson();
    }
    data['email'] = this.email;
    data['claim_reward'] = this.claimReward;
    data['referel_code'] = this.referelCode;
    data['reward'] = this.reward;
    return data;
  }
}

class Province {
  int? id;
  String? name;
  String? image;
  String? createdAt;

  Province({this.id, this.name, this.image, this.createdAt});

  Province.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    return data;
  }
}
