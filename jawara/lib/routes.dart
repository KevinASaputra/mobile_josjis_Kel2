import 'package:flutter/material.dart';
import 'package:jawara/screens/dashboard/keuangan_screen.dart';
import 'package:jawara/screens/kegiatan_broadcast/kegiatan_daftar_screen.dart';
import 'package:jawara/screens/kegiatan_broadcast/broadcast_daftar_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';

Map<String, WidgetBuilder> routes = {
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/dashboard/keuangan': (context) => const KeuanganScreen(),
  '/kegiatan/daftar': (context) => const KegiatanDaftarScreen(),
  '/broadcast/daftar': (context) => const BroadcastDaftarScreen(),
};
