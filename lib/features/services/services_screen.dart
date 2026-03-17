import 'package:flutter/material.dart';
import 'package:jtpanther/data/repositories/services_repository.dart';
import 'service_card.dart';
import 'service_model.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {

  final ServicesRepository repository = ServicesRepository();

  late Future<List<dynamic>> servicesFuture;

  @override
  void initState() {
    super.initState();
    servicesFuture = repository.getServices();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Servicios"),
        centerTitle: true,
      ),

      body: FutureBuilder(
        future: servicesFuture,
        builder: (context, snapshot) {
          
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
            }
            
            if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
                );
            }
            
            final services = snapshot.data!;
            return ListView.builder(padding: const EdgeInsets.all(16),
            itemCount: services.length,

            itemBuilder: (context, index){
              
              final item = services[index];
              final service = Service.fromMap(item);
              return ServiceCard(service: service);
              },
            );
          },
        ),
      );
    }
  }