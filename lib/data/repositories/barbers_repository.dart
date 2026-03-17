import 'package:jtpanther/core/supabase_client.dart';

class BarbersRepository {

  Future<List<dynamic>> getBarbers() async {

    final response = await supabase
        .from('barberos')
        .select()
        .eq('activo', true)
        .order('nombre');

    return response;

  }

}