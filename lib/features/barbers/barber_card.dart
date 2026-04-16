import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'barber_model.dart';

class BarberCard extends StatelessWidget {
  final String serviceId;
  final Barber barber;
  final String serviceName;

  const BarberCard({
    super.key,
    required this.barber,
    required this.serviceId,
    required this.serviceName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),

        title: Text(barber.nombre),

        subtitle: Text(barber.especialidad ?? "Barbero"),

        onTap: () {
          context.go(
            '/calendar',
            extra: {
              "barberid": barber.id,
              "barberName": barber.nombre,
              "serviceid": serviceId,
              "serviceName": serviceName,
              },
          );
        },
      ),
    );
  }
}
