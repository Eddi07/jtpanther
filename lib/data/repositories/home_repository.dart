import '../../core/supabase_client.dart';

class HomeRepository {
  Future<List> getPromociones() async {
    final data = await supabase
        .from('promociones')
        .select()
        .eq('activa', true)
        .order('created_at', ascending: false);

    return data;
  }

  Future<List> getProductos() async {
    final data = await supabase.from('productos').select();

    print("DEBUG PRODUCTOS: $data");

    return data;
  }
}
