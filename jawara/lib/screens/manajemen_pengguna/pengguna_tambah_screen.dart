import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PenggunaTambahScreen extends StatefulWidget {
  const PenggunaTambahScreen({super.key});

  @override
  State<PenggunaTambahScreen> createState() => _PenggunaTambahScreenState();
}

class _PenggunaTambahScreenState extends State<PenggunaTambahScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController noHpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController konfirmasiPasswordController =
      TextEditingController();

  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xFFF5F7FB);
    const Color primaryColor = Color(0xFF635BFF);

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
                'Tambah Akun Pengguna',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              // Card Form
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('Nama Lengkap'),
                          _buildTextField(
                            controller: namaController,
                            hintText: 'Masukkan nama lengkap',
                          ),

                          _buildLabel('Email'),
                          _buildTextField(
                            controller: emailController,
                            hintText: 'Masukkan email aktif',
                            keyboardType: TextInputType.emailAddress,
                          ),

                          _buildLabel('Nomor HP'),
                          _buildTextField(
                            controller: noHpController,
                            hintText: 'Masukkan nomor HP (cth: 08xxxxxxxxxx)',
                            keyboardType: TextInputType.phone,
                          ),

                          _buildLabel('Password'),
                          _buildTextField(
                            controller: passwordController,
                            hintText: 'Masukkan password',
                            obscureText: true,
                          ),

                          _buildLabel('Konfirmasi Password'),
                          _buildTextField(
                            controller: konfirmasiPasswordController,
                            hintText: 'Masukkan ulang password',
                            obscureText: true,
                          ),

                          _buildLabel('Role'),
                          DropdownButtonFormField<String>(
                            value: selectedRole,
                            items: ['Admin', 'Ketua RW', 'Warga']
                                .map(
                                  (role) => DropdownMenuItem<String>(
                                    value: role,
                                    child: Text(role),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() => selectedRole = value);
                            },
                            decoration: InputDecoration(
                              hintText: '-- Pilih Role --',
                              hintStyle: GoogleFonts.inter(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                          "Akun pengguna berhasil ditambahkan! 🎉",
                                        ),
                                        backgroundColor: Colors.green.shade600,
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  }
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
                                  elevation: 0,
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
                                  emailController.clear();
                                  noHpController.clear();
                                  passwordController.clear();
                                  konfirmasiPasswordController.clear();
                                  setState(() => selectedRole = null);
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
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ======================== Helper Widgets =========================

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
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
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
}
