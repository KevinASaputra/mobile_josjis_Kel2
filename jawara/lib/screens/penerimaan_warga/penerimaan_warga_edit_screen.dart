import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/dashboard_layout.dart';

class PenerimaanWargaEditScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  const PenerimaanWargaEditScreen({super.key, required this.data});

  @override
  State<PenerimaanWargaEditScreen> createState() =>
      _PenerimaanWargaEditScreenState();
}

class _PenerimaanWargaEditScreenState extends State<PenerimaanWargaEditScreen> {
  late TextEditingController _namaController;
  late TextEditingController _emailController;
  late TextEditingController _nikController;
  late TextEditingController _alamatController;
  String _jenisKelamin = 'Laki-laki';
  String _statusKepemilikan = 'Milik Sendiri';
  String? _fotoIdentitas;

  @override
  void initState() {
    super.initState();
    final data = widget.data;
    _namaController = TextEditingController(text: data['nama'] ?? '');
    _emailController = TextEditingController(text: data['email'] ?? '');
    _nikController = TextEditingController(text: data['nik'] ?? '');
    _alamatController = TextEditingController(text: data['alamatRumah'] ?? '');
    _jenisKelamin = data['jenisKelamin'] ?? 'Laki-laki';
    _statusKepemilikan = data['statusKepemilikan'] ?? 'Milik Sendiri';
    _fotoIdentitas = data['fotoIdentitas'];
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF635BFF);

    return DashboardLayout(
      title: 'Edit Penerimaan Warga',
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 700),
            padding: const EdgeInsets.all(24),
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
                // Kembali row
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
                // Removed profile picture row, only show name and email fields
                TextField(
                  controller: _namaController,
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    labelStyle: GoogleFonts.inter(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: GoogleFonts.inter(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _nikController,
                  decoration: InputDecoration(
                    labelText: 'NIK',
                    labelStyle: GoogleFonts.inter(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _jenisKelamin,
                  items: const [
                    DropdownMenuItem(
                      value: 'Laki-laki',
                      child: Text('Laki-laki'),
                    ),
                    DropdownMenuItem(
                      value: 'Perempuan',
                      child: Text('Perempuan'),
                    ),
                  ],
                  onChanged: (v) =>
                      setState(() => _jenisKelamin = v ?? 'Laki-laki'),
                  decoration: InputDecoration(
                    labelText: 'Jenis Kelamin',
                    labelStyle: GoogleFonts.inter(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 16),
                // Foto Identitas preview
                Text(
                  'Foto Identitas KK/KTP',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 8),
                if (_fotoIdentitas != null && _fotoIdentitas!.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'img/$_fotoIdentitas',
                      width: 120,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  Container(
                    width: 120,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.image,
                      size: 40,
                      color: Colors.grey.shade700,
                    ),
                  ),
                const SizedBox(height: 16),
                TextField(
                  controller: _alamatController,
                  decoration: InputDecoration(
                    labelText: 'Alamat Rumah',
                    labelStyle: GoogleFonts.inter(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _statusKepemilikan,
                  items: const [
                    DropdownMenuItem(
                      value: 'Milik Sendiri',
                      child: Text('Milik Sendiri'),
                    ),
                    DropdownMenuItem(
                      value: 'Kontrak/Sewa',
                      child: Text('Kontrak/Sewa'),
                    ),
                    DropdownMenuItem(
                      value: 'Menumpang',
                      child: Text('Menumpang'),
                    ),
                  ],
                  onChanged: (v) =>
                      setState(() => _statusKepemilikan = v ?? 'Milik Sendiri'),
                  decoration: InputDecoration(
                    labelText: 'Status Kepemilikan Rumah',
                    labelStyle: GoogleFonts.inter(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Setujui logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Setujui'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        // Tolak logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Tolak'),
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
}
