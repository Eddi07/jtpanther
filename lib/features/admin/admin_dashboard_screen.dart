import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/admin_notifications.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {

  @override
  void initState() {
    super.initState();

    listenNewAppointments((data) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Nueva cita registrada"),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Panel Admin"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            /// BOTÓN CITAS
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.go('/admin-citas');
                },
                icon: const Icon(Icons.calendar_today),
                label: const Text("Gestionar citas"),
              ),
            ),

            const SizedBox(height: 20),

            /// FUTURO: MÉTRICAS
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text("Aquí irán métricas del negocio 📊"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}