import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import '../../widgets/dashboard_layout.dart';

class PengeluaranTambahScreen extends StatefulWidget {
  const PengeluaranTambahScreen({super.key});

  @override
  State<PengeluaranTambahScreen> createState() =>
      _PengeluaranTambahScreenState();
}

class _PengeluaranTambahScreenState extends State<PengeluaranTambahScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _nominalController = TextEditingController();
  DateTime? _tanggal;
  String? _kategori;
  File? _buktiFile;

  final Color primaryColor = const Color(0xFF635BFF);

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _tanggal = picked);
    }
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        _buktiFile = File(result.files.single.path!);
      });
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _namaController.clear();
    _nominalController.clear();
    _tanggal = null;
    _kategori = null;
    _buktiFile = null;
    setState(() {});
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green.shade100,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            left: 16,
            right: 16,
          ),
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Pengeluaran berhasil dibuat! 🎉',
                  style: GoogleFonts.inter(
                    color: Colors.green.shade900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          duration: const Duration(seconds: 3),
        ),
      );
      _resetForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      title: 'Buat Pengeluaran Baru',
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 700;

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: isMobile ? double.infinity : 900,
                padding: const EdgeInsets.all(20),
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Nama Pengeluaran'),
                      TextFormField(
                        controller: _namaController,
                        decoration: _inputDecoration(
                          'Masukkan nama pengeluaran',
                        ),
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Wajib diisi' : null,
                      ),
                      const SizedBox(height: 16),

                      _buildLabel('Tanggal Pengeluaran'),
                      GestureDetector(
                        onTap: _pickDate,
                        child: AbsorbPointer(
                          child: TextFormField(
                            decoration: _inputDecoration(
                              _tanggal == null
                                  ? '--/--/----'
                                  : '${_tanggal!.day}/${_tanggal!.month}/${_tanggal!.year}',
                              suffixIcon: const Icon(
                                Icons.calendar_today_outlined,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      _buildLabel('Kategori Pengeluaran'),
                      DropdownButtonFormField<String>(
                        value: _kategori,
                        items:
                            [
                                  'Operasional RT/RW',
                                  'Pemeliharaan Fasilitas',
                                  'Konsumsi',
                                  'Transportasi',
                                ]
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e, style: GoogleFonts.inter()),
                                  ),
                                )
                                .toList(),
                        decoration: _inputDecoration(
                          '-- Pilih Kategori --',
                          hasHint: false,
                        ),
                        onChanged: (v) => setState(() => _kategori = v),
                        validator: (v) => v == null ? 'Wajib dipilih' : null,
                      ),
                      const SizedBox(height: 16),

                      _buildLabel('Nominal'),
                      TextFormField(
                        controller: _nominalController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration('Masukkan nominal'),
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Wajib diisi' : null,
                      ),
                      const SizedBox(height: 16),

                      _buildLabel('Bukti Pengeluaran'),
                      GestureDetector(
                        onTap: _pickFile,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F3F3),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Text(
                            _buktiFile != null
                                ? _buktiFile!.path.split('/').last
                                : 'Upload bukti pengeluaran (.png/.jpg)',
                            style: GoogleFonts.inter(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 24,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Submit',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          OutlinedButton(
                            onPressed: _resetForm,
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey.shade300),
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 24,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Reset',
                              style: GoogleFonts.inter(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(
    String hint, {
    Widget? suffixIcon,
    bool hasHint = true,
  }) {
    return InputDecoration(
      hintText: hasHint ? hint : null,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
    );
  }
}
