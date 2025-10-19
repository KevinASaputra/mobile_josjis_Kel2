import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/dashboard_layout.dart';

class PenggunaEditScreen extends StatelessWidget {
  final String nama;
  final String email;
  final String noHp;
  final String jabatan;

  final TextEditingController namaController;
  final TextEditingController emailController;
  final TextEditingController noHpController;
  final TextEditingController passwordBaruController = TextEditingController();
  final TextEditingController konfirmasiPasswordController =
      TextEditingController();

  PenggunaEditScreen({
    super.key,
    required this.nama,
    required this.email,
    required this.noHp,
    required this.jabatan,
  }) : namaController = TextEditingController(text: nama),
       emailController = TextEditingController(text: email),
       noHpController = TextEditingController(text: noHp);

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF635BFF);

    return DashboardLayout(
      title: 'Edit Akun Pengguna',
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

            // Card form
            LayoutBuilder(
              builder: (context, constraints) {
                bool isMobile = constraints.maxWidth < 700;

                return Container(
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
                      _buildLabel('Nama Lengkap'),
                      _buildTextField(controller: namaController),

                      _buildLabel('Email'),
                      _buildTextField(controller: emailController),

                      _buildLabel('Nomor HP'),
                      _buildTextField(
                        controller: noHpController,
                        keyboardType: TextInputType.phone,
                      ),

                      _buildLabel(
                        'Password Baru (kosongkan jika tidak diganti)',
                      ),
                      _buildTextField(
                        controller: passwordBaruController,
                        obscureText: true,
                      ),

                      _buildLabel('Konfirmasi Password Baru'),
                      _buildTextField(
                        controller: konfirmasiPasswordController,
                        obscureText: true,
                      ),

                      _buildLabel('Role (tidak dapat diubah)'),
                      _buildDisabledDropdown(jabatan),

                      const SizedBox(height: 24),

                      Align(
                        alignment: isMobile
                            ? Alignment.center
                            : Alignment.centerLeft,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  "Data pengguna diperbarui! 🎉",
                                ),
                                backgroundColor: Colors.green.shade600,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Perbarui',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ========================== Helper Widgets ==========================

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF635BFF), width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildDisabledDropdown(String value) {
    return DropdownButtonFormField<String>(
      value: value,
      items: [DropdownMenuItem(value: value, child: Text(value))],
      onChanged: null, // Disabled
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
