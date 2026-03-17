import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'barber_model.dart';

class BarberCard extends StatelessWidget {

  final Barber barber;
  final String serviceName;

  const BarberCard({
    super.key,
    required this.barber,
    required this.serviceName,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      child: ListTile(

        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),

        title: Text(barber.nombre),

        subtitle: Text(barber.especialidad ?? "Barbero"),

onTap: () {

  context.go(
    '/calendar',
    extra: {
      "barberid": barber.id,
      "serviceid": serviceName,
    },
  );

},

      ),
    );
  }
}