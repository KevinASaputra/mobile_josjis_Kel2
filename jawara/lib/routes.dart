// lib/routes.dart
import 'package:flutter/material.dart';

// Auth
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';

// Dashboard
import 'screens/dashboard/keuangan_screen.dart';
import 'screens/dashboard/kegiatan_screen.dart';
import 'screens/dashboard/kependudukan_screen.dart';

// Kegiatan & Broadcast
import 'screens/kegiatan_broadcast/kegiatan_daftar_screen.dart';
import 'screens/kegiatan_broadcast/broadcast_daftar_screen.dart';
import 'screens/kegiatan_broadcast/kegiatan_tambah_screen.dart';
import 'screens/kegiatan_broadcast/broadcast_tambah_screen.dart';

// Log Aktivitas
import 'screens/log_aktifitas/semua_aktifitas_screen.dart';

// Data Warga & Rumah
import 'screens/data_warga_rumah/warga_daftar_screen.dart';
import 'screens/data_warga_rumah/rumah_daftar_screen.dart';
import 'screens/data_warga_rumah/warga_tambah_screen.dart';
import 'screens/data_warga_rumah/rumah_tambah_screen.dart';
import 'screens/data_warga_rumah/keluarga_screen.dart';

Map<String, WidgetBuilder> routes = {
  // Auth
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),

  // Dashboard
  '/dashboard/keuangan': (context) => const KeuanganScreen(),
  '/dashboard/kegiatan': (context) => const KegiatanScreen(),
  '/dashboard/kependudukan': (context) => const KependudukanScreen(),

  // Kegiatan & Broadcast
  '/kegiatan/daftar': (context) => const KegiatanDaftarScreen(),
  '/broadcast/daftar': (context) => const BroadcastDaftarScreen(),
  '/kegiatan/tambah': (context) => const KegiatanTambahScreen(),
  '/broadcast/tambah': (context) => const BroadcastTambahScreen(),

  // Log Aktivitas
  '/log/aktifitas': (context) => const LogAktifitasScreen(),

  // Data Warga & Rumah
  '/warga/daftar': (context) => const WargaDaftarScreen(),
  '/rumah/daftar': (context) => const RumahDaftarScreen(),
  '/warga/tambah': (context) => const WargaTambahScreen(),
  '/rumah/tambah': (context) => const RumahTambahScreen(),
  '/keluarga': (context) => const KeluargaScreen(),
  '/warga/keluarga': (context) => const KeluargaScreen(),
};
