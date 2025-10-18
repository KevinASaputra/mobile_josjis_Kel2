import 'package:flutter/material.dart';
import 'package:jawara/screens/dashboard/keuangan_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';

Map<String, WidgetBuilder> routes = {
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/dashboard/keuangan': (context) => const KeuanganScreen(),
};
