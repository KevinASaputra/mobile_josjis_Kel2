import 'package:flutter/material.dart';
import 'sidebar.dart';

class DashboardLayout extends StatelessWidget {
  final Widget child;
  final String title;

  const DashboardLayout({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white, // Add this
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ), // Add this for the hamburger menu
        backgroundColor: const Color(0xFF2C3E50),
      ),
      drawer: const Sidebar(), // This adds the drawer functionality
      body: Container(
        color: Colors.grey[100],
        child: Padding(padding: const EdgeInsets.all(16.0), child: child),
      ),
    );
  }
}
