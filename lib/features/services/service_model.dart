class Service {

   final String id;
  final String name;
  final int price;
  final int duration;

  Service({
    required this.id,
    required this.name,
    required this.price,
    required this.duration,
  });

  factory Service.fromMap(Map<String, dynamic> map) {

    return Service(
      id: map['id'].toString(),
      name: map['nombre'] ?? '',
      price: (map['precio'] ?? 0).toInt(),
      duration: (map['duracion_minutos'] ?? 0).toInt(),
    );

  }

}