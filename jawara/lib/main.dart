import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/dashboard/keuangan_screen.dart';
import 'screens/dashboard/kegiatan_screen.dart';
import 'screens/dashboard/kependudukan_screen.dart';
import 'package:jawara/screens/kegiatan_broadcast/kegiatan_daftar_screen.dart';
import 'package:jawara/screens/kegiatan_broadcast/broadcast_daftar_screen.dart';
import 'package:jawara/screens/kegiatan_broadcast/kegiatan_tambah_screen.dart';
import 'package:jawara/screens/kegiatan_broadcast/broadcast_tambah_screen.dart';
import 'package:jawara/screens/log_aktifitas/semua_aktifitas_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jawara Pintar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/': (context) => const LoginScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/dashboard/keuangan': (context) => const KeuanganScreen(),
        '/dashboard/kegiatan': (context) => const KegiatanScreen(),
        '/dashboard/kependudukan': (context) => const KependudukanScreen(),
        '/kegiatan/daftar': (context) => const KegiatanDaftarScreen(),
        '/broadcast/daftar': (context) => const BroadcastDaftarScreen(),
        '/kegiatan/tambah': (context) => const KegiatanTambahScreen(),
        '/broadcast/tambah': (context) => const BroadcastTambahScreen(),
        '/log/aktifitas': (context) => const LogAktifitasScreen(),
      },
    );
  }
}
