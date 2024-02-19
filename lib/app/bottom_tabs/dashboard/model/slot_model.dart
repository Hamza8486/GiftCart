class AddSlotModel {
  String? id;
  String? name;
  String? slot;
  String? total;

  AddSlotModel({
    this.id,

    this.name,
    this.slot,
    this.total,
  });

  AddSlotModel.fromJson(Map<String, dynamic> json) {
    id = json['province'];

    name = json['name'];
    slot = json['slot'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['province'] = this.id;
    data['name'] = this.name;
    data['slot'] = this.slot;
    data['total'] = this.total;
    return data;
  }

  // factory AddSlotModel.fromMap(Map<String, dynamic> map) {
  //   return AddSlotModel(
  //     member: map['member'] as String,
  //     service: map['service'] as String,
  //     duration: map['duration'] as String,
  //     price: map['price'] as String,
  //     date_time: map['date_time'] as String,
  //     name: map['name'] as String,
  //     priceId: map['priceId'] as String,
  //
  //   );
  // }
  //
  // String toJson() => json.encode(toMap());
  //
  // factory AppointmentModel.fromJson(String source) =>
  //     AppointmentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  void updateTotal() {
    int currentSlot = int.tryParse(slot ?? '0') ?? 0;
    int previousTotal = int.tryParse(total ?? '0') ?? 0;
    total = (previousTotal + currentSlot).toString();
  }
}

// class AddtoAppointmentList {
//   AppointmentModel appointmentModel;
//
//   AddtoAppointmentList({required this.appointmentModel});
// }