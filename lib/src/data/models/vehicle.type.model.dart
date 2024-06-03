class VehicleType {
  final int id;
  final String name;
  final int fee;

  VehicleType({
    required this.id,
    required this.name,
    required this.fee,
  });

  factory VehicleType.fromJson(Map<String, dynamic> json) => VehicleType(
        id: json['id'] as int,
        name: json['name'] as String,
        fee: json['fee'] as int,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'fee': fee,
      };
}
