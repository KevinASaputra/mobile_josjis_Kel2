// lib/main.dart
import 'package:flutter/material.dart';

import 'routes.dart'; // semua route sudah didefinisikan di sini
import 'screens/auth/login_screen.dart';
import 'package:jawara/screens/laporan_keuangan/laporan_pemasukan_screen.dart';
import 'package:jawara/screens/laporan_keuangan/laporan_pengeluaran_screen.dart';
import 'package:jawara/screens/laporan_keuangan/cetak_laporan_screen.dart';
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
import 'package:jawara/screens/mutasi_keluarga/mutasi_daftar_screen.dart';
import 'package:jawara/screens/mutasi_keluarga/mutasi_tambah_screen.dart';
import 'package:jawara/screens/penerimaan_warga/penerimaan_warga_screen.dart';
import 'package:jawara/screens/manajemen_pengguna/pengguna_daftar_screen.dart';
import 'package:jawara/screens/manajemen_pengguna/pengguna_tambah_screen.dart';
import 'package:jawara/screens/channel_transfer/channel_daftar_screen.dart';
import 'package:jawara/screens/channel_transfer/channel_tambah_screen.dart';
import 'package:jawara/screens/pengeluaran/pengeluaran_daftar_screen.dart';
import 'package:jawara/screens/pengeluaran/pengeluaran_tambah_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jawara Pintar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF2C3E50),
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2C3E50),
          foregroundColor: Colors.white,
        ),
      ),
      // Set halaman awal
      initialRoute: '/login',

      // Gunakan routes dari routes.dart
      routes: routes,

      // Fallback jika route tidak ditemukan
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text('404 - Route Not Found')),
          body: Center(child: Text('Tidak ada halaman untuk ${settings.name}')),
        ),
      ),
    );
  }
}
