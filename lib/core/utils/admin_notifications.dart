import 'package:supabase_flutter/supabase_flutter.dart';
import '../supabase_client.dart';

void listenNewAppointments(Function callback) {

  supabase
      .channel('citas_channel')
      .onPostgresChanges(
        event: PostgresChangeEvent.insert,
        schema: 'public',
        table: 'citas',
        callback: (payload) {
          callback(payload.newRecord);
        },
      )
      .subscribe();
}