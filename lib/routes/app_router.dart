// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jtpanther/screens/booking_form_screen.dart';

import '../features/splash/splash_screen.dart';
import '../features/services/services_screen.dart';
import '../features/barbers/barbers_screen.dart';
import '../screens/calendar_screen.dart';
import '../screens/confirmation_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),

      GoRoute(
        path: '/services',
        builder: (context, state) => const ServicesScreen(),
      ),

      GoRoute(
        path: '/barbers',
        builder: (context, state) => const BarbersScreen(),
      ),

      GoRoute(
        path: '/calendar',
        builder: (context, state) {
          final data = state.extra as Map;

          return CalendarScreen(
            serviceid: data["serviceid"],
            serviceName: data["serviceName"],
            barberid: data["barberid"],
            barberName: data["barberName"],
            
          );
        },
      ),

      GoRoute(
        path: '/booking',
        builder: (context, state) {
          final data = state.extra as Map?;

          if (data == null) {
            return const Scaffold(
              body: Center(child: Text("Error: datos no recibidos")),
            );
          }

          return BookingFormScreen(
            barberid: data["barberid"] as String,
            serviceid: data["serviceid"] as String,
            barberName: data["barberName"]as String,
            serviceName: data["serviceName"]as String,
            date: data["date"] as DateTime,
            time: data["time"] as String,
          );
        },
      ),

      GoRoute(
        path: '/confirmation',
        builder: (context, state) {
          final data = state.extra as Map;

          return ConfirmationScreen(
            name: data["name"] ?? "",
            date: data["date"] ?? "",
            time: data["time"] ?? "",
            barberName: data["barberName"] ?? "",
            serviceName: data["serviceName"] ?? "",
          );
        },
      ),
    ],
  );
}
