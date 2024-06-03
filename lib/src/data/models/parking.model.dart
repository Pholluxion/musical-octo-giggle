class Parking {
  final int id;
  final String location;
  final int capacity;
  final int available;

  Parking({
    required this.id,
    required this.location,
    required this.capacity,
    required this.available,
  });

  factory Parking.fromJson(Map<String, dynamic> json) => Parking(
        id: json['id'] as int,
        location: json['location'] as String,
        capacity: json['capacity'] as int,
        available: json['available'] as int,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'location': location,
        'capacity': capacity,
        'available': available,
      };
}
