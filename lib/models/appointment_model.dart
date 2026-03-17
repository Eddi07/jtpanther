class Appointment {

  final int? id;
  final int serviceId;
  final int barberId;
  final String clientName;
  final String clientPhone;
  final DateTime appointmentTime;

  Appointment({
    this.id,
    required this.serviceId,
    required this.barberId,
    required this.clientName,
    required this.clientPhone,
    required this.appointmentTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'service_id': serviceId,
      'barber_id': barberId,
      'client_name': clientName,
      'client_phone': clientPhone,
      'appointment_time': appointmentTime.toIso8601String(),
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'],
      serviceId: map['service_id'],
      barberId: map['barber_id'],
      clientName: map['client_name'],
      clientPhone: map['client_phone'],
      appointmentTime: DateTime.parse(map['appointment_time']),
    );
  }
}