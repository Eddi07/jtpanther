import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'service_model.dart';

class ServiceCard extends StatelessWidget {

  final Service service;

  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),

      child: ListTile(

        onTap: () {
          context.go('/barbers', extra: {
            "serviceid": service.id,
            "serviceName": service.name,
            });
          },

        leading: const Icon(
          Icons.content_cut,
          size: 30,
        ),

        title: Text(service.name),

        subtitle: Row(
          children: [
            const Icon(Icons.schedule, size: 16),
            const SizedBox(width: 5),
            Text("${service.duration} min"),
          ],
        ),

        trailing: Text(
          "\$${service.price}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

      ),

    );
  }
}