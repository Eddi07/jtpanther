import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jtpanther/data/repositories/barbers_repository.dart';
import 'barber_model.dart';
import 'barber_card.dart';

class BarbersScreen extends StatefulWidget {
  const BarbersScreen({super.key});

  @override
  State<BarbersScreen> createState() => _BarbersScreenState();
}

class _BarbersScreenState extends State<BarbersScreen> {
  

  final BarbersRepository repository = BarbersRepository();
  late Future<List> barbersFuture;

  @override
  void initState() {
    super.initState();
    barbersFuture = repository.getBarbers();
  }

  @override
  Widget build(BuildContext context) {
    final serviceId = GoRouterState.of(context).extra as String;
    

    return Scaffold(
      appBar: AppBar(
        title: const Text("Selecciona tu barbero"),
      ),

      body: FutureBuilder(
        future: barbersFuture,
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final barbers = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: barbers.length,

            itemBuilder: (context, index) {

              final item = barbers[index];
              
              final barber = Barber(
                id: item['id'],
                nombre: item['nombre'],
                especialidad: item['especialidad'],
              );

              return BarberCard(
                barber: barber,
                serviceName: serviceId,
              );

            },
          );
        },
      ),
    );
  }
}