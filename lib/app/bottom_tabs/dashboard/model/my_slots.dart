class getMySlots {
  bool? success;
  Response? response;

  getMySlots({this.success, this.response});

  getMySlots.fromJson(Map<String, dynamic> json) {
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
  List<SlotDataNew>? data;

  Response({this.data});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SlotDataNew>[];
      json['data'].forEach((v) {
        data!.add(new SlotDataNew.fromJson(v));
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

class SlotDataNew {
  int? id;
  int? bet;
  User? user;
  Province? province;
  var price;
  String? code;
  String? createdAt;
  bool? isScratch;

  SlotDataNew(
      {this.id,
        this.bet,
        this.user,
        this.province,
        this.price,
        this.code,
        this.createdAt,
        this.isScratch});

  SlotDataNew.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bet = json['bet'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    province = json['province'] != null
        ? new Province.fromJson(json['province'])
        : null;
    price = json['price'];
    code = json['code'];
    createdAt = json['created_at'];
    isScratch = json['is_scratch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bet'] = this.bet;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.province != null) {
      data['province'] = this.province!.toJson();
    }
    data['price'] = this.price;
    data['code'] = this.code;
    data['created_at'] = this.createdAt;
    data['is_scratch'] = this.isScratch;
    return data;
  }
}

class User {
  int? id;
  String? fullName;
  var logo;

  User({this.id, this.fullName, this.logo});

  User.fromJson(Map<String, dynamic> json) {
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

class Province {
  int? id;
  String? name;
  int? slot;
  var totalPrice;

  Province({this.id, this.name, this.slot, this.totalPrice});

  Province.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slot = json['slot'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slot'] = this.slot;
    data['total_price'] = this.totalPrice;
    return data;
  }
}
