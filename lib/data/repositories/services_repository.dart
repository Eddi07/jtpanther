import 'package:jtpanther/core/supabase_client.dart';

class ServicesRepository {

  Future<List<dynamic>> getServices() async {

    final response = await supabase
        .from('servicios')
        .select()
        .eq('activo', true)
        .order('nombre');

    return response;

  }

}