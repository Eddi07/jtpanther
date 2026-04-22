import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:carousel_slider/carousel_slider.dart';
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

  int currentIndex = 0;

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

                  /// 🎬 CARRUSEL DE PROMOCIONES
                  if (promociones.isNotEmpty)
                    Column(
                      children: [

                        CarouselSlider(
                          options: CarouselOptions(
                            height: 180,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            enlargeCenterPage: true,
                            viewportFraction: 0.9,
                            onPageChanged: (index, reason) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                          ),

                          items: promociones.map<Widget>((promo) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.amber),
                              ),

                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),

                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [

                                    /// IMAGEN
                                    if (promo['imagen'] != null &&
                                        promo['imagen'] != "")
                                      Image.network(
                                        promo['imagen'],
                                        fit: BoxFit.cover,
                                      )
                                    else
                                      Container(color: Colors.black12),

                                    /// GRADIENTE
                                    Container(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.transparent,
                                            Colors.black54,
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                    ),

                                    /// TEXTO
                                    Positioned(
                                      left: 12,
                                      right: 12,
                                      bottom: 12,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            promo['titulo'] ?? '',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            promo['descripcion'] ?? '',
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 10),

                        /// DOTS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: promociones.asMap().entries.map((entry) {
                            return Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentIndex == entry.key
                                    ? Colors.amber
                                    : Colors.grey,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
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
                                  child: const Icon(Icons.shopping_bag, size: 40),
                                ),

                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      p['nombre'] ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
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
                                    Text(
                                      "\$${p['precio'] ?? 0}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// BOTÓN
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