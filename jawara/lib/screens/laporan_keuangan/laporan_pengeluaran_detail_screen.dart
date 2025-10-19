import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/dashboard_layout.dart';

class LaporanPengeluaranDetailScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  const LaporanPengeluaranDetailScreen({super.key, required this.data});

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
    final nama = data['nama']?.toString() ?? '-';
    final jenis = data['jenis']?.toString() ?? '-';
    final jumlah = data['nominal'] != null
        ? 'Rp ${data['nominal'].toString()}'
        : '-';
    final keterangan = data['keterangan']?.toString() ?? '-';

    return DashboardLayout(
      title: 'Detail Pengeluaran',
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back row
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back, size: 20, color: primaryColor),
                    const SizedBox(width: 4),
                    Text(
                      'Kembali',
                      style: GoogleFonts.inter(
                        color: primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
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
                      'Informasi Pengeluaran',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildDetailRow('Nama Pengeluaran', nama),
                    _buildDetailRow('Jenis Pengeluaran', jenis),
                    _buildDetailRow('Nominal', jumlah),
                    _buildDetailRow('Keterangan', keterangan),
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
