import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/supabase_client.dart';

class BookingFormScreen extends StatefulWidget {

  final String barberid;
  final String serviceid;
  final String barberName;
  final String serviceName;
  final DateTime date;
  final String time;

  const BookingFormScreen({
    super.key,
    required this.barberid,
    required this.serviceid,
    required this.barberName,
    required this.serviceName,
    required this.date,
    required this.time,
  });

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {

  final nameController = TextEditingController();
  final phoneController = TextEditingController();

Future<void> saveAppointment() async {
  try {
    final formattedDate =
        widget.date.toIso8601String().split('T')[0];

    await supabase.from('citas').insert({
      "barbero_id": widget.barberid,
      "servicio_id": widget.serviceid,
      "fecha": formattedDate,
      "hora": widget.time,
      "cliente_nombre": nameController.text,
      "cliente_telefono": phoneController.text,
      "estado": "pendiente"
    });

    if (!mounted) return;

    context.go('/confirmation', extra: {
      "name": nameController.text,
      "date": formattedDate,
      "time": widget.time,
      "serviceName": widget.serviceName,
      "barberName": widget.barberName,
    });

  } catch (e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Error al guardar cita: $e"),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Confirmar cita"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Nombre",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Teléfono",
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: saveAppointment,
              child: const Text("Confirmar cita"),
              
            )
          ],
        ),
      ),
    );
  }
}