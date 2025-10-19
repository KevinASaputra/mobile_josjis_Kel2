import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChannelEditScreen extends StatefulWidget {
  final Map<String, String> channelData;

  const ChannelEditScreen({super.key, required this.channelData});

  @override
  State<ChannelEditScreen> createState() => _ChannelEditScreenState();
}

class _ChannelEditScreenState extends State<ChannelEditScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController namaController;
  late final TextEditingController rekeningController;
  late final TextEditingController pemilikController;
  late final TextEditingController catatanController;

  String? selectedTipe;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with passed data
    namaController = TextEditingController(
      text: widget.channelData['nama'] ?? '',
    );
    rekeningController = TextEditingController(
      text: widget.channelData['no'] ?? '',
    );
    pemilikController = TextEditingController(
      text: widget.channelData['an'] ?? '',
    );
    catatanController = TextEditingController(
      text: widget.channelData['thumbnail'] ?? '',
    );

    // Set selected type based on passed data
    String tipeData = widget.channelData['tipe'] ?? '';
    if (tipeData.toLowerCase() == 'ewallet') {
      selectedTipe = 'E - Wallet';
    } else if (tipeData.toLowerCase() == 'bank') {
      selectedTipe = 'Bank';
    } else if (tipeData.toLowerCase() == 'qris') {
      selectedTipe = 'QRIS';
    } else {
      selectedTipe = 'E - Wallet';
    }
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

              // Judul halaman
              Text(
                'Edit Transfer Channel',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              // Form Card
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Nama Channel'),
                      _buildTextField(controller: namaController),

                      _buildLabel('Tipe'),
                      DropdownButtonFormField<String>(
                        value: selectedTipe,
                        items: ['E - Wallet', 'Bank', 'QRIS'].map((tipe) {
                          return DropdownMenuItem(
                            value: tipe,
                            child: Text(tipe),
                          );
                        }).toList(),
                        onChanged: (value) =>
                            setState(() => selectedTipe = value),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                        ),
                      ),

                      _buildLabel('Nomor Rekening / Akun'),
                      _buildTextField(controller: rekeningController),

                      _buildLabel('Nama Pemilik'),
                      _buildTextField(controller: pemilikController),

                      _buildLabel('Thumbnail'),
                      _buildUploadBox(
                        'Upload thumbnail baru jika ingin mengganti',
                      ),

                      _buildLabel('QR'),
                      _buildUploadBox('Upload QR baru jika ingin mengganti'),

                      _buildLabel('Catatan (Opsional)'),
                      _buildTextField(
                        controller: catatanController,
                        maxLines: 3,
                        hintText: 'Tambahkan catatan jika perlu',
                      ),

                      const SizedBox(height: 24),

                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    "Perubahan berhasil disimpan 🎉",
                                  ),
                                  backgroundColor: Colors.green.shade600,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Simpan',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          TextButton(
                            onPressed: () {
                              namaController.clear();
                              rekeningController.clear();
                              pemilikController.clear();
                              catatanController.clear();
                              setState(() => selectedTipe = null);
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              backgroundColor: Colors.grey.shade100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Reset',
                              style: GoogleFonts.inter(
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===================== Helper Widgets =====================

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    String? hintText,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.inter(color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF635BFF), width: 2),
        ),
      ),
    );
  }

  Widget _buildUploadBox(String hint) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        hint,
        style: GoogleFonts.inter(color: Colors.black54, fontSize: 14),
      ),
    );
  }
}
