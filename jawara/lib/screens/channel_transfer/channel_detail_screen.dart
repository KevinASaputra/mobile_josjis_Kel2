import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChannelDetailScreen extends StatelessWidget {
  final Map<String, String> channelData;

  const ChannelDetailScreen({super.key, required this.channelData});

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xFFF5F7FB);
    const Color primaryColor = Color(0xFF635BFF);

    // Use the passed channel data
    final Map<String, String> channel = {
      'nama': channelData['nama'] ?? '',
      'tipe': channelData['tipe'] ?? '',
      'rekening': channelData['no'] ?? '', // Use 'no' as rekening for now
      'pemilik': channelData['an'] ?? '',
      'catatan':
          channelData['thumbnail'] ?? '', // Use thumbnail as catatan for now
    };

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tombol kembali
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.arrow_back, size: 20, color: primaryColor),
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

              // Judul
              Text(
                'Detail Transfer Channel',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              // Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabelValue('Nama Channel', channel['nama']!),
                    _buildLabelValue('Tipe Channel', channel['tipe']!),
                    _buildLabelValue(
                      'Nomor Rekening / Akun',
                      channel['rekening']!,
                    ),
                    _buildLabelValue('Nama Pemilik', channel['pemilik']!),
                    _buildLabelValue('Catatan', channel['catatan']!),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =============== Helper Widget ===============
  Widget _buildLabelValue(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
