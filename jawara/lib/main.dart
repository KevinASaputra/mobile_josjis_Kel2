// lib/main.dart
import 'package:flutter/material.dart';
import 'routes.dart'; // semua route sudah didefinisikan di sini
import 'screens/auth/login_screen.dart';

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
