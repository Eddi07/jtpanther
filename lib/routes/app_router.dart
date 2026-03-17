// import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/splash/splash_screen.dart';
import '../features/services/services_screen.dart';
import '../features/barbers/barbers_screen.dart';
import '../screens/calendar_screen.dart';
import '../screens/booking_form_screen.dart';
import '../screens/confirmation_screen.dart';

class AppRouter {

  static final router = GoRouter(
    initialLocation: '/',
    routes: [

      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),

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
            barberid: data["barberid"],
            serviceid: data["serviceid"],
          );

        },
      ),

      GoRoute(
        path: '/booking',
        builder: (context, state) {

          final data = state.extra as Map;

          return BookingFormScreen(
            barberid: data["barberid"],
            serviceid: data["serviceid"],
            date: data["date"],
            time: data["time"],
          );

        },
      ),

      GoRoute(
        path: '/confirmation',
        builder: (context, state) {
          
          final data = state.extra as Map;
          
          return ConfirmationScreen(
            name: data["name"],
            date: data["date"],
            time: data["time"],
            );
          },
        ),
    ],
  );

}