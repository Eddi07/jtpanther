import 'package:flutter/material.dart';
import '../../core/supabase_client.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminAppointmentsScreen extends StatefulWidget {
  const AdminAppointmentsScreen({super.key});

  @override
  State<AdminAppointmentsScreen> createState() => _AdminAppointmentsScreenState();
}

class _AdminAppointmentsScreenState extends State<AdminAppointmentsScreen> {

  late Future<List> citasFuture;

  @override
  void initState() {
    super.initState();
    loadCitas();
  }

  void loadCitas() {
    citasFuture = supabase
        .from('citas')
        .select('''
          id,
          cliente_nombre,
          cliente_telefono,
          fecha,
          hora,
          estado,
          servicio:servicio_id (nombre),
          barbero:barbero_id (nombre)
        ''')
        .order('fecha');
  }

  Future<void> actualizarEstado(String id, String estado, Map cita) async {
    await supabase
        .from('citas')
        .update({'estado': estado})
        .eq('id', id);

    if (estado == 'confirmada') {
      await enviarWhatsApp(cita);
    }

    setState(() {
      loadCitas();
    });
  }

  Future<void> enviarWhatsApp(Map cita) async {
    final telefono = cita['cliente_telefono'];

    final mensaje = Uri.encodeComponent(
      "Hola ${cita['cliente_nombre']} 👋\n\n"
      "Tu cita ha sido CONFIRMADA 💈\n\n"
      "📅 ${cita['fecha']}\n"
      "⏰ ${cita['hora']}\n"
      "✂ ${cita['servicio']['nombre']}\n"
      "💈 ${cita['barbero']['nombre']}\n\n"
      "Te esperamos 🔥"
    );

    final url = "https://wa.me/52$telefono?text=$mensaje";

    await launchUrl(Uri.parse(url));
  }

  Color getColorEstado(String estado) {
    switch (estado) {
      case 'pendiente':
        return Colors.orange;
      case 'confirmada':
        return Colors.blue;
      case 'completada':
        return Colors.green;
      case 'cancelada':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestión de Citas"),
      ),

      body: FutureBuilder(
        future: citasFuture,
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final citas = snapshot.data!;

          return ListView.builder(
            itemCount: citas.length,
            itemBuilder: (context, index) {

              final cita = citas[index];

              return Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(12),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// HEADER
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            cita['cliente_nombre'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Chip(
                            label: Text(cita['estado']),
                            backgroundColor: getColorEstado(cita['estado']),
                          )
                        ],
                      ),

                      const SizedBox(height: 6),

                      Text("📱 ${cita['cliente_telefono']}"),
                      Text("📅 ${cita['fecha']} ${cita['hora']}"),

                      const SizedBox(height: 4),

                      Text("✂ ${cita['servicio']['nombre']}"),
                      Text("💈 ${cita['barbero']['nombre']}"),

                      const SizedBox(height: 10),

                      /// BOTONES
                      Row(
                        children: [

                          if (cita['estado'] == 'pendiente')
                            ElevatedButton(
                              onPressed: () async {
                                await actualizarEstado(
                                  cita['id'],
                                  'confirmada',
                                  cita,
                                );
                              },
                              child: const Text("Confirmar"),
                            ),

                          const SizedBox(width: 8),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () async {
                              await actualizarEstado(
                                cita['id'],
                                'cancelada',
                                cita,
                              );
                            },
                            child: const Text("Cancelar"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}