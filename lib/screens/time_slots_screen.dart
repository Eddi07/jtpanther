import 'package:flutter/material.dart';

class TimeSlotsScreen extends StatelessWidget {

  const TimeSlotsScreen({super.key});

  List<String> generateTimeSlots() {

    List<String> slots = [];

    for (int hour = 12; hour <= 17; hour++) {

      slots.add("$hour:00");
      slots.add("$hour:30");

    }

    return slots;
  }

  @override
  Widget build(BuildContext context) {

    final slots = generateTimeSlots();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Selecciona horario"),
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(20),

        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),

        itemCount: slots.length,

        itemBuilder: (context, index) {

          return ElevatedButton(
            onPressed: () {},

            child: Text(slots[index]),
          );
        },
      ),
    );
  }
}