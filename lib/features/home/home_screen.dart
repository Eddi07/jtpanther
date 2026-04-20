import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/repositories/home_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final repo = HomeRepository();

  late Future promocionesFuture;
  late Future productosFuture;

  @override
  void initState() {
    super.initState();
    promocionesFuture = repo.getPromociones();
    productosFuture = repo.getProductos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: Future.wait([promocionesFuture, productosFuture]),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final List promociones = snapshot.data![0] as List;
            final List productos = snapshot.data![1] as List;
            return SingleChildScrollView(
              
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// LOGO
                  const Center(
                    child: Column(
                      children: [
                        Icon(Icons.content_cut, size: 80),
                        SizedBox(height: 10),
                        Text(
                          "JTPanther",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// 🔥 PROMOCIONES (MEJORADAS)
                  if (promociones.isNotEmpty)
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.amber),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// IMAGEN
                          if (promociones[0]['imagen'] != null &&
                              promociones[0]['imagen'] != "")
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: Image.network(
                                promociones[0]['imagen'],
                                height: 140,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            )
                          else
                            Container(
                              height: 120,
                              alignment: Alignment.center,
                              child: const Icon(Icons.local_offer, size: 50),
                            ),

                          /// TEXTO
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  promociones[0]['titulo'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(promociones[0]['descripcion'] ?? ''),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 30),

                  /// 🛍 PRODUCTOS
                  const Text(
                    "Productos",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: productos.length,
                      itemBuilder: (context, index) {
                        final p = productos[index];

                        return Container(
                          width: 150,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// IMAGEN
                              if (p['imagen'] != null && p['imagen'] != "")
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                  child: Image.network(
                                    p['imagen'],
                                    height: 90,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              else
                                Container(
                                  height: 90,
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.shopping_bag,
                                    size: 40,
                                  ),
                                ),

                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// NOMBRE
                                    Text(
                                      p['nombre'] ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 4),

                                    /// DESCRIPCIÓN
                                    Text(
                                      p['descripcion'] ?? "Producto disponible",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),

                                    const SizedBox(height: 6),

                                    /// PRECIO
                                    Text(
                                      "\$${p['precio'] ?? 0}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// 📅 RESERVAR
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.go('/services');
                      },
                      child: const Text("Reservar cita"),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// 🔐 ADMIN
                  Center(
                    child: TextButton(
                      onPressed: () {
                        context.go('/admin');
                      },
                      child: const Text("Acceso administrador"),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
