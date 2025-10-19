import 'package:flutter/material.dart';
import '../../widgets/sidebar.dart';

class MutasiTambahScreen extends StatefulWidget {
  const MutasiTambahScreen({super.key});

  @override
  State<MutasiTambahScreen> createState() => _MutasiTambahScreenState();
}

class _MutasiTambahScreenState extends State<MutasiTambahScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _jenisMutasi;
  String? _keluarga;
  String? _alasanMutasi;
  DateTime? _tanggalMutasi;

  final List<String> keluargaOptions = ['Keluarga Ijat', 'Keluarga Waguri'];

  Future<void> _pickTanggalMutasi(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _tanggalMutasi = picked;
      });
    }
  }

  void _resetForm() {
    setState(() {
      _jenisMutasi = null;
      _keluarga = null;
      _alasanMutasi = null;
      _tanggalMutasi = null;
    });
    _formKey.currentState?.reset();
  }

  void _simpanForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Simpan data logic here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data mutasi berhasil disimpan!')),
      );
      _resetForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Mutasi Keluarga'),
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
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Jenis Mutasi *',
                    ),
                    value: _jenisMutasi,
                    items: const [
                      DropdownMenuItem(
                        value: 'Pindah Rumah',
                        child: Text('Pindah Rumah'),
                      ),
                      DropdownMenuItem(
                        value: 'Keluar Perumahan',
                        child: Text('Keluar Perumahan'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _jenisMutasi = value;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Jenis Mutasi wajib diisi' : null,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Keluarga *'),
                    value: _keluarga,
                    items: keluargaOptions
                        .map((k) => DropdownMenuItem(value: k, child: Text(k)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _keluarga = value;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Keluarga wajib dipilih' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Alasan Mutasi',
                    ),
                    onChanged: (value) => _alasanMutasi = value,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Tanggal Mutasi *',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => _pickTanggalMutasi(context),
                      ),
                    ),
                    controller: TextEditingController(
                      text: _tanggalMutasi == null
                          ? ''
                          : '${_tanggalMutasi!.day}/${_tanggalMutasi!.month}/${_tanggalMutasi!.year}',
                    ),
                    validator: (value) {
                      if (_tanggalMutasi == null) {
                        return 'Tanggal Mutasi wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _simpanForm,
                        icon: const Icon(Icons.save),
                        label: const Text('Simpan'),
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
