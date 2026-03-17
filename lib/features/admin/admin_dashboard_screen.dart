import 'package:flutter/material.dart';
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

    listenNewAppointments((data){

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

      body: const Center(
        child: Text("Dashboard de citas"),
      ),
    );
  }
}