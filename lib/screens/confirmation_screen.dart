import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConfirmationScreen extends StatelessWidget {

  final String name;
  final String date;
  final String time;

  const ConfirmationScreen({
    super.key,
    required this.name,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.black,

      body: Center(

        child: Padding(
          padding: const EdgeInsets.all(30),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 90,
              ),

              const SizedBox(height: 20),

              const Text(
                "¡Cita registrada!",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                "Tu reserva ha sido registrada exitosamente.\n"
                "Se te enviará un mensaje por WhatsApp\n"
                "con el estatus de tu cita.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70),
              ),

              const SizedBox(height: 30),

Card(
  color: const Color(0xFF111111),
  elevation: 6,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
    side: const BorderSide(color: Color(0xFF2A2A2A)),
  ),
  child: Padding(
    padding: const EdgeInsets.all(22),
    child: Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "DETALLES DE CITA",
            style: TextStyle(
              color: Color(0xFFD4AF37),
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const Divider(color: Colors.white12, height: 25),
        _row("👤 Cliente", name),
        _row("📅 Fecha", date),
        _row("⏰ Hora", time),
      ],
    ),
  ),
),


              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  context.go('/services');
                },
                child: const Text("Volver al inicio"),
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Text(
          label,
          style: const TextStyle(color: Colors.white70),
        ),

        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),

      ],
    ),
  );
}
}