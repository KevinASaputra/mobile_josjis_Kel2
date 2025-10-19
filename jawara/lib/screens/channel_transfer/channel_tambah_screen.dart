import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChannelTambahScreen extends StatefulWidget {
  const ChannelTambahScreen({super.key});

  @override
  State<ChannelTambahScreen> createState() => _ChannelTambahScreenState();
}

class _ChannelTambahScreenState extends State<ChannelTambahScreen> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController nomorController = TextEditingController();
  final TextEditingController pemilikController = TextEditingController();
  final TextEditingController catatanController = TextEditingController();

  String? selectedTipe;

  void _resetForm() {
    setState(() {
      namaController.clear();
      nomorController.clear();
      pemilikController.clear();
      catatanController.clear();
      selectedTipe = null;
    });
  }

  void _showSuccessNotification(String message) {
    OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 40,
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              border: Border.all(color: Colors.green.shade300),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    message,
                    style: GoogleFonts.inter(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry?.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF635BFF);
    const Color bgColor = Color(0xFFF5F7FB);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(16),
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
                // Title
                Text(
                  'Buat Transfer Channel',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),

                // Nama Channel
                _buildLabel('Nama Channel'),
                _buildTextField(
                  controller: namaController,
                  hintText: 'Contoh: BCA, Dana, QRIS RT',
                ),

                const SizedBox(height: 16),

                // Tipe Dropdown
                _buildLabel('Tipe'),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text('-- Pilih Tipe --', style: GoogleFonts.inter(color: Colors.grey)),
                      value: selectedTipe,
                      isExpanded: true,
                      items: ['E-Wallet', 'Bank', 'QRIS']
                          .map((tipe) => DropdownMenuItem(
                                value: tipe,
                                child: Text(tipe, style: GoogleFonts.inter(fontSize: 14)),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedTipe = value;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Nomor Rekening
                _buildLabel('Nomor Rekening / Akun'),
                _buildTextField(
                  controller: nomorController,
                  hintText: 'Contoh: 1234567890',
                ),

                const SizedBox(height: 16),

                // Nama Pemilik
                _buildLabel('Nama Pemilik'),
                _buildTextField(
                  controller: pemilikController,
                  hintText: 'Contoh: John Doe',
                ),

                const SizedBox(height: 16),

                // QR Upload Box
                _buildLabel('QR'),
                _buildUploadBox('Upload foto QR (jika ada) png/jpeg/jpg'),

                const SizedBox(height: 16),

                // Thumbnail Upload Box
                _buildLabel('Thumbnail'),
                _buildUploadBox('Upload thumbnail (jika ada) png/jpeg/jpg'),

                const SizedBox(height: 16),

                // Catatan
                _buildLabel('Catatan (Opsional)'),
                _buildTextField(
                  controller: catatanController,
                  hintText: 'Contoh: Transfer hanya dari bank yang sama agar instan',
                  maxLines: 3,
                ),

                const SizedBox(height: 20),

                // Buttons
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        _showSuccessNotification('Channel berhasil ditambahkan 🎉');
                      },
                      child: Text('Simpan', style: GoogleFonts.inter(color: Colors.white)),
                    ),
                    const SizedBox(width: 12),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey.shade100,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: _resetForm,
                      child: Text('Reset', style: GoogleFonts.inter(color: Colors.black87)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===== Helper Widgets =====

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.inter(),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.inter(color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF635BFF)),
        ),
      ),
    );
  }

  Widget _buildUploadBox(String text) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(color: Colors.grey.shade600, fontSize: 13),
      ),
    );
  }
}
