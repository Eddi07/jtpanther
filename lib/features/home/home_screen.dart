import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              /// LOGO
              const Icon(Icons.content_cut, size: 80),
              const SizedBox(height: 20),

              const Text(
                "JTPanther",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              /// PROMO
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.amber),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  children: [
                    Text("🔥 20% OFF", style: TextStyle(fontSize: 18)),
                    SizedBox(height: 5),
                    Text("Lunes de Descuento"),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              /// BOTÓN RESERVAR
              ElevatedButton(
                onPressed: () {
                  context.go('/services');
                },
                child: const Text("Reservar cita"),
              ),

              const SizedBox(height: 10),

              /// ADMIN
              TextButton(
                onPressed: () {
                  context.go('/admin');
                },
                child: const Text("Acceso administrador"),
              )
            ],
          ),
        ),
      ),
    );
  }
}