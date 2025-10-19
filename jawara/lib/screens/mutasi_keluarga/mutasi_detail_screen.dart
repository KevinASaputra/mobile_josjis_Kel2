import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/dashboard_layout.dart';

class MutasiDetailScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  const MutasiDetailScreen({super.key, required this.data});

  @override
  State<MutasiDetailScreen> createState() => _MutasiDetailScreenState();
}

class _MutasiDetailScreenState extends State<MutasiDetailScreen> {
  bool _isHoveringBack = false;

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value.isEmpty ? '-' : value,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Divider(color: Colors.grey.shade200),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF635BFF);
    final keluarga = widget.data['keluarga']?.toString() ?? '-';
    final alamatLama = widget.data['alamatLama']?.toString() ?? '-';
    final alamatBaru = widget.data['alamatBaru']?.toString() ?? '-';
    final tanggal = widget.data['tanggal']?.toString() ?? '-';
    final jenis = widget.data['jenis']?.toString() ?? '-';
    final alasan = widget.data['alasan']?.toString() ?? '-';

    return DashboardLayout(
      title: 'Detail Mutasi',
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) => setState(() => _isHoveringBack = true),
                onExit: (_) => setState(() => _isHoveringBack = false),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        size: 20,
                        color: _isHoveringBack
                            ? primaryColor.withOpacity(0.95)
                            : primaryColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Kembali',
                        style: GoogleFonts.inter(
                          color: _isHoveringBack
                              ? primaryColor.withOpacity(0.95)
                              : primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          decoration: _isHoveringBack
                              ? TextDecoration.underline
                              : TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                constraints: const BoxConstraints(maxWidth: 700),
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Informasi Mutasi',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildDetailRow('Keluarga', keluarga),
                    _buildDetailRow('Alamat Lama', alamatLama),
                    _buildDetailRow('Alamat Baru', alamatBaru),
                    _buildDetailRow('Tanggal Mutasi', tanggal),
                    _buildDetailRow('Jenis Mutasi', jenis),
                    _buildDetailRow('Alasan', alasan),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
