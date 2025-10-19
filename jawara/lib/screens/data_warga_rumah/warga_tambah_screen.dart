// lib/screens/data_warga_rumah/warga_tambah_screen.dart
import 'package:flutter/material.dart';
import '../../widgets/dashboard_layout.dart';

class WargaTambahScreen extends StatefulWidget {
  const WargaTambahScreen({Key? key}) : super(key: key);
  static const routeName = '/warga-tambah';

  @override
  _WargaTambahScreenState createState() => _WargaTambahScreenState();
}

class _WargaTambahScreenState extends State<WargaTambahScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nama = TextEditingController();
  final _nik = TextEditingController();
  final _alamat = TextEditingController();
  String? _rumahId;
  int? _editingId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // if arguments exist, treat as edit
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic>) {
      _editingId = args['id'] as int?;
      _nama.text = args['nama'] ?? '';
      _nik.text = args['nik'] ?? '';
      _alamat.text = args['alamat'] ?? '';
      _rumahId = args['rumah_id']?.toString();
    }
  }

  @override
  void dispose() {
    _nama.dispose();
    _nik.dispose();
    _alamat.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final result = {
      if (_editingId != null) 'id': _editingId,
      'nama': _nama.text.trim(),
      'nik': _nik.text.trim(),
      'alamat': _alamat.text.trim(),
      'rumah_id': _rumahId,
    };
    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = _editingId != null;
    return DashboardLayout(
      title: isEdit ? 'Edit Warga' : 'Tambah Warga',
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nama,
                  decoration: const InputDecoration(labelText: 'Nama'),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Nama wajib diisi' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _nik,
                  decoration: const InputDecoration(labelText: 'NIK'),
                  keyboardType: TextInputType.number,
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'NIK wajib diisi' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _alamat,
                  decoration: const InputDecoration(labelText: 'Alamat'),
                  maxLines: 2,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: _rumahId,
                  decoration: const InputDecoration(
                    labelText: 'ID Rumah (opsional)',
                  ),
                  onChanged: (v) => _rumahId = v,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _save,
                      child: Text(isEdit ? 'Update' : 'Simpan'),
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
