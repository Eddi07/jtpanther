import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/services/availability_service.dart';

class CalendarScreen extends StatefulWidget {

  final String barberid;
  final String serviceid;
  final String barberName;
  final String serviceName;

  const CalendarScreen({
    super.key,
    required this.barberid,
    required this.serviceid,
    required this.barberName,
    required this.serviceName,
  });

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  DateTime selectedDate = DateTime.now();

  List<String> availableSlots = [];
  bool loadingSlots = false;

  final AvailabilityService availabilityService = AvailabilityService();

  Future<void> loadSlots() async {

    setState(() {
      loadingSlots = true;
    });

    final slots = await availabilityService.getAvailableSlots(
      widget.barberid,
      selectedDate,
    );

    setState(() {
      availableSlots = slots;
      loadingSlots = false;
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Selecciona una fecha"),
      ),

      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),

          child: Column(

            children: [

              const SizedBox(height: 20),

              CalendarDatePicker(

                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2030),

                onDateChanged: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                },

              ),

              const SizedBox(height: 20),

              ElevatedButton(

                onPressed: loadSlots,

                child: const Text(
                  "Ver horarios disponibles",
                ),

              ),

              const SizedBox(height: 20),

              if (loadingSlots)
                const CircularProgressIndicator(),

              if (!loadingSlots && availableSlots.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "Selecciona una fecha para ver horarios",
                  ),
                ),

              if (availableSlots.isNotEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Text(
                    "Horarios disponibles",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              if (availableSlots.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 20),

                  child: Wrap(

                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,

                    children: availableSlots.map((slot) {

                      return GestureDetector(

                        onTap: () {
                            context.go(
                              '/booking',
                              extra: {
                                "barberid": widget.barberid,
                                "serviceid": widget.serviceid,
                                "barberName": widget.barberName,
                                "serviceName": widget.serviceName,
                                "date": selectedDate,
                                "time": slot,},);
                        },

                        child: Container(

                          width: 45,
                          height: 45,

                          alignment: Alignment.center,

                          decoration: BoxDecoration(

                            color: const Color.fromARGB(255, 200, 81, 204),
                            borderRadius: BorderRadius.circular(50),

                          ),

                          child: Text(

                            slot,

                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),

                          ),

                        ),

                      );

                    }).toList(),

                  ),

                ),

              const SizedBox(height: 40),

            ],

          ),

        ),

      ),

    );

  }

}