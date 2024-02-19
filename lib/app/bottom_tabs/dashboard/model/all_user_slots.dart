class AllUserSlotsModel {
  int? id;
  String? email;
  String? fullName;
  ProvinceSlots? provinceSlots;

  AllUserSlotsModel({this.id, this.email, this.fullName, this.provinceSlots});

  AllUserSlotsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    fullName = json['full_name'];
    provinceSlots = json['province_slots'] != null
        ? new ProvinceSlots.fromJson(json['province_slots'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['full_name'] = this.fullName;
    if (this.provinceSlots != null) {
      data['province_slots'] = this.provinceSlots!.toJson();
    }
    return data;
  }
}

class ProvinceSlots {
  int? qC;

  ProvinceSlots({this.qC});

  ProvinceSlots.fromJson(Map<String, dynamic> json) {
    qC = json['QC'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['QC'] = this.qC;
    return data;
  }
}
