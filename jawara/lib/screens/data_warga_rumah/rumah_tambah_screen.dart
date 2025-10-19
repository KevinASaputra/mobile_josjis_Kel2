// lib/screens/data_warga_rumah/rumah_tambah_screen.dart
import 'package:flutter/material.dart';
import '../../widgets/dashboard_layout.dart';

class RumahTambahScreen extends StatefulWidget {
  const RumahTambahScreen({Key? key}) : super(key: key);
  static const routeName = '/rumah-tambah';

  @override
  _RumahTambahScreenState createState() => _RumahTambahScreenState();
}

class _RumahTambahScreenState extends State<RumahTambahScreen> {
  final _formKey = GlobalKey<FormState>();
  final _alamat = TextEditingController();
  final _nomor = TextEditingController();
  int? _editingId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic>) {
      _editingId = args['id'] as int?;
      _alamat.text = args['alamat'] ?? '';
      _nomor.text = args['nomor']?.toString() ?? '';
    }
  }

  @override
  void dispose() {
    _alamat.dispose();
    _nomor.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final result = {
      if (_editingId != null) 'id': _editingId,
      'alamat': _alamat.text.trim(),
      'nomor': _nomor.text.trim(),
    };
    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = _editingId != null;
    return DashboardLayout(
      title: isEdit ? 'Edit Rumah' : 'Tambah Rumah',
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _alamat,
                  decoration: const InputDecoration(labelText: 'Alamat'),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Alamat wajib diisi' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _nomor,
                  decoration: const InputDecoration(labelText: 'Nomor Rumah'),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _save,
                      child: const Text('Simpan'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Batal'),
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
