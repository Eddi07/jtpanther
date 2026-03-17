import 'package:flutter/material.dart';
import '../services/availability_service.dart';
import 'package:go_router/go_router.dart';

class TimeSlotsScreen extends StatefulWidget {

  final String barberId;
  final DateTime date;

  const TimeSlotsScreen({
    super.key,
    required this.barberId,
    required this.date,
  });

  @override
  State<TimeSlotsScreen> createState() => _TimeSlotsScreenState();
}

class _TimeSlotsScreenState extends State<TimeSlotsScreen> {

  final AvailabilityService service = AvailabilityService();

  late Future<List<String>> slots;

  @override
  void initState() {
    super.initState();

    slots = service.getAvailableSlots(
      widget.barberId,
      widget.date,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Horarios disponibles"),
      ),

      body: FutureBuilder(

        future: slots,

        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final times = snapshot.data!;

          if (times.isEmpty) {
            return const Center(
              child: Text("No hay horarios disponibles"),
            );
          }

          return GridView.builder(

            padding: const EdgeInsets.all(20),

            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),

            itemCount: times.length,

            itemBuilder: (context, index) {

              final time = times[index];

              return ElevatedButton(

                onPressed: () {

                  context.go(
                    '/booking',
                    extra: {
                      "barberId": widget.barberId,
                      "date": widget.date,
                      "time": time,
                    },
                  );

                },

                child: Text(time),

              );

            },
          );

        },
      ),
    );
  }
}