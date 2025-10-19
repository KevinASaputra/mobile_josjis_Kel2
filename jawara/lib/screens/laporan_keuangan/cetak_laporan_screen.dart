import 'package:flutter/material.dart';
import '../../widgets/sidebar.dart';

class CetakLaporanScreen extends StatefulWidget {
  const CetakLaporanScreen({super.key});

  @override
  State<CetakLaporanScreen> createState() => _CetakLaporanScreenState();
}

class _CetakLaporanScreenState extends State<CetakLaporanScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _tanggalMulai;
  DateTime? _tanggalAkhir;
  String _jenisLaporan = 'Semua';

  Future<void> _pickDate(BuildContext context, bool isMulai) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isMulai) {
          _tanggalMulai = picked;
        } else {
          _tanggalAkhir = picked;
        }
      });
    }
  }

  void _resetForm() {
    setState(() {
      _tanggalMulai = null;
      _tanggalAkhir = null;
      _jenisLaporan = 'Semua';
    });
    _formKey.currentState?.reset();
  }

  void _downloadPDF() {
    if (_formKey.currentState?.validate() ?? false) {
      // Implement PDF generation logic here
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('PDF berhasil didownload!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cetak Laporan Keuangan'),
        backgroundColor: const Color(0xFF2C3E50),
        foregroundColor: Colors.white,
      ),
      drawer: const Sidebar(),
      body: Container(
        color: const Color(0xFFF1F5F9),
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Tanggal Mulai
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Tanggal Mulai *',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => _pickDate(context, true),
                      ),
                    ),
                    controller: TextEditingController(
                      text: _tanggalMulai == null
                          ? ''
                          : '${_tanggalMulai!.day}/${_tanggalMulai!.month}/${_tanggalMulai!.year}',
                    ),
                    validator: (value) {
                      if (_tanggalMulai == null) {
                        return 'Tanggal Mulai wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Tanggal Akhir
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Tanggal Akhir *',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => _pickDate(context, false),
                      ),
                    ),
                    controller: TextEditingController(
                      text: _tanggalAkhir == null
                          ? ''
                          : '${_tanggalAkhir!.day}/${_tanggalAkhir!.month}/${_tanggalAkhir!.year}',
                    ),
                    validator: (value) {
                      if (_tanggalAkhir == null) {
                        return 'Tanggal Akhir wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Jenis Laporan
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Jenis Laporan',
                    ),
                    value: _jenisLaporan,
                    items: const [
                      DropdownMenuItem(value: 'Semua', child: Text('Semua')),
                      DropdownMenuItem(
                        value: 'Pemasukan',
                        child: Text('Pemasukan'),
                      ),
                      DropdownMenuItem(
                        value: 'Pengeluaran',
                        child: Text('Pengeluaran'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _jenisLaporan = value ?? 'Semua';
                      });
                    },
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _downloadPDF,
                        icon: const Icon(Icons.download),
                        label: const Text('Download PDF'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6366F1),
                          foregroundColor: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: _resetForm,
                        child: const Text('Reset'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
