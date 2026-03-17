import '../../core/supabase_client.dart';

class AvailabilityService {

  Future<List<String>> getAvailableSlots(
    String barberId,
    DateTime date,
  ) async {

    List<String> baseSlots = [];

    for (int hour = 9; hour <= 18; hour++) {

      baseSlots.add("${hour.toString().padLeft(2,'0')}:00");
      baseSlots.add("${hour.toString().padLeft(2,'0')}:30");

    }

    final formattedDate = date.toIso8601String().split('T')[0];

    final response = await supabase
        .from('citas')
        .select('hora')
        .eq('barbero_id', barberId)
        .eq('fecha', formattedDate);

    List<String> bookedSlots =
        response.map<String>((e) => e['hora']).toList();

    baseSlots.removeWhere((slot) => bookedSlots.contains(slot));

    return baseSlots;

  }

}