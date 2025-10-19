import 'package:flutter/material.dart';
import 'package:jawara/screens/dashboard/keuangan_screen.dart';
import 'package:jawara/screens/kegiatan_broadcast/kegiatan_daftar_screen.dart';
import 'package:jawara/screens/kegiatan_broadcast/broadcast_daftar_screen.dart';
import 'package:jawara/screens/kegiatan_broadcast/kegiatan_tambah_screen.dart';
import 'package:jawara/screens/kegiatan_broadcast/broadcast_tambah_screen.dart';
import 'package:jawara/screens/log_aktifitas/semua_aktifitas_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'package:jawara/screens/laporan_keuangan/laporan_pemasukan_screen.dart';
import 'package:jawara/screens/laporan_keuangan/laporan_pengeluaran_screen.dart';
import 'package:jawara/screens/laporan_keuangan/cetak_laporan_screen.dart';
import 'package:jawara/screens/mutasi_keluarga/mutasi_daftar_screen.dart';
import 'package:jawara/screens/mutasi_keluarga/mutasi_tambah_screen.dart';

Map<String, WidgetBuilder> routes = {
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/dashboard/keuangan': (context) => const KeuanganScreen(),
  '/kegiatan/daftar': (context) => const KegiatanDaftarScreen(),
  '/broadcast/daftar': (context) => const BroadcastDaftarScreen(),
  '/kegiatan/tambah': (context) => const KegiatanTambahScreen(),
  '/broadcast/tambah': (context) => const BroadcastTambahScreen(),
  '/log/aktifitas': (context) => const LogAktifitasScreen(),
  '/laporan-keuangan/pemasukan': (context) => const LaporanPemasukanScreen(),
  '/laporan-keuangan/pengeluaran': (context) =>
      const LaporanPengeluaranScreen(),
  '/laporan-keuangan/cetak': (context) => const CetakLaporanScreen(),
  '/mutasi-keluarga/daftar': (context) => const MutasiDaftarScreen(),
  '/mutasi-keluarga/tambah': (context) => const MutasiTambahScreen(),
};
