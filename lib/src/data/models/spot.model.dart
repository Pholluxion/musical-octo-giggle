class Spot {
  final int? id;
  final String licensePlate;
  final String paymentStatus;
  final DateTime arrivalTime;
  final int parking;
  final int vehicleType;

  Spot({
    this.id,
    required this.licensePlate,
    required this.paymentStatus,
    required this.arrivalTime,
    required this.parking,
    required this.vehicleType,
  });

  factory Spot.fromJson(Map<String, dynamic> json) => Spot(
        id: json['id'] as int,
        licensePlate: json['licensePlate'] as String,
        paymentStatus: json['paymentStatus'] as String,
        arrivalTime: DateTime.fromMillisecondsSinceEpoch(
          int.parse(json['arrivalTime']),
        ),
        parking: json['parking'] as int,
        vehicleType: json['vehicleType'] as int,
      );

  Map<String, dynamic> toJson() => {
        'licensePlate': licensePlate,
        'paymentStatus': paymentStatus,
        'arrivalTime': arrivalTime.millisecondsSinceEpoch,
        'parking': parking,
        'vehicleType': vehicleType,
      };
}
