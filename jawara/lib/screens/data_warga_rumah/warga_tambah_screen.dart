// lib/screens/data_warga_rumah/warga_tambah_screen.dart
import 'package:flutter/material.dart';
import '../../widgets/dashboard_layout.dart';
import 'package:intl/intl.dart';

class WargaTambahScreen extends StatefulWidget {
  const WargaTambahScreen({Key? key}) : super(key: key);
  static const routeName = '/warga-tambah';

  @override
  State<WargaTambahScreen> createState() => _WargaTambahScreenState();
}

class _WargaTambahScreenState extends State<WargaTambahScreen> {
  final _formKey = GlobalKey<FormState>();

  // controllers
  final TextEditingController _namaCtl = TextEditingController();
  final TextEditingController _nikCtl = TextEditingController();
  final TextEditingController _teleponCtl = TextEditingController();
  final TextEditingController _tempatLahirCtl = TextEditingController();
  final TextEditingController _tanggalLahirCtl = TextEditingController();
  final TextEditingController _pekerjaanCtl = TextEditingController();

  // dropdown values
  int? _selectedKeluargaId; // contoh id keluarga
  String? _selectedJenisKelamin;
  String? _selectedAgama;
  String? _selectedGolonganDarah;
  String? _selectedPeranKeluarga;
  String? _selectedPendidikan;
  String? _selectedStatus;

  // editing id (null => tambah)
  int? _editingId;

  // Dummy keluarga list (silakan sesuaikan / ambil dari daftar nyata)
  final List<Map<String, dynamic>> _dummyKeluarga = [
    {'id': 1, 'label': 'Keluarga Budi Santoso (RT 01)'},
    {'id': 2, 'label': 'Keluarga Andi Wijaya (RT 02)'},
    {'id': 3, 'label': 'Keluarga Rina (RT 03)'},
  ];

  // pilihan dropdown
  final List<String> _jenisKelamin = ['Laki-laki', 'Perempuan'];
  final List<String> _agamaList = [
    'Islam',
    'Kristen',
    'Katolik',
    'Hindu',
    'Buddha',
    'Konghucu',
    'Lainnya',
  ];
  final List<String> _golonganDarah = ['A', 'B', 'AB', 'O', '-'];
  final List<String> _peranKeluarga = [
    'Kepala Keluarga',
    'Istri',
    'Anak',
    'Saudara',
    'Lainnya',
  ];
  final List<String> _pendidikan = [
    'SD',
    'SMP',
    'SMA/SMK',
    'D1/D2/D3',
    'S1',
    'S2',
    'S3',
    'Tidak Sekolah',
  ];
  final List<String> _statusList = [
    'Kawin',
    'Belum Kawin',
    'Cerai',
    'Janda/Duda',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // jika ada arguments berupa Map, isi form untuk mode edit
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic> && args.isNotEmpty) {
      // only fill once
      if (_editingId == null) {
        _editingId = args['id'] as int?;
        _namaCtl.text = args['nama']?.toString() ?? '';
        _nikCtl.text = args['nik']?.toString() ?? '';
        _teleponCtl.text = args['telepon']?.toString() ?? '';
        _tempatLahirCtl.text = args['tempat_lahir']?.toString() ?? '';
        _tanggalLahirCtl.text = args['tanggal_lahir']?.toString() ?? '';
        _pekerjaanCtl.text = args['pekerjaan']?.toString() ?? '';
        _selectedKeluargaId = args['keluarga_id'] is int
            ? args['keluarga_id'] as int
            : null;
        _selectedJenisKelamin = args['jenis_kelamin'] as String?;
        _selectedAgama = args['agama'] as String?;
        _selectedGolonganDarah = args['golongan_darah'] as String?;
        _selectedPeranKeluarga = args['peran_keluarga'] as String?;
        _selectedPendidikan = args['pendidikan_terakhir'] as String?;
        _selectedStatus = args['status'] as String?;
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    _namaCtl.dispose();
    _nikCtl.dispose();
    _teleponCtl.dispose();
    _tempatLahirCtl.dispose();
    _tanggalLahirCtl.dispose();
    _pekerjaanCtl.dispose();
    super.dispose();
  }

  void _pickDate() async {
    final now = DateTime.now();
    final initial = DateTime(now.year - 20, now.month, now.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: _tanggalLahirCtl.text.isNotEmpty
          ? DateFormat('yyyy-MM-dd').parse(_tanggalLahirCtl.text)
          : initial,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Pilih Tanggal Lahir',
    );
    if (picked != null) {
      _tanggalLahirCtl.text = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {});
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _namaCtl.clear();
    _nikCtl.clear();
    _teleponCtl.clear();
    _tempatLahirCtl.clear();
    _tanggalLahirCtl.clear();
    _pekerjaanCtl.clear();
    _selectedKeluargaId = null;
    _selectedJenisKelamin = null;
    _selectedAgama = null;
    _selectedGolonganDarah = null;
    _selectedPeranKeluarga = null;
    _selectedPendidikan = null;
    _selectedStatus = null;
    // if editing, keep editing id until canceled
    setState(() {});
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final Map<String, dynamic> result = {
      if (_editingId != null) 'id': _editingId,
      'keluarga_id': _selectedKeluargaId,
      'nama': _namaCtl.text.trim(),
      'nik': _nikCtl.text.trim(),
      'telepon': _teleponCtl.text.trim(),
      'tempat_lahir': _tempatLahirCtl.text.trim(),
      'tanggal_lahir': _tanggalLahirCtl.text.trim(),
      'jenis_kelamin': _selectedJenisKelamin,
      'agama': _selectedAgama,
      'golongan_darah': _selectedGolonganDarah,
      'peran_keluarga': _selectedPeranKeluarga,
      'pendidikan_terakhir': _selectedPendidikan,
      'pekerjaan': _pekerjaanCtl.text.trim(),
      'status': _selectedStatus,
    };

    // kembalikan data ke pemanggil
    Navigator.pop(context, result);
  }

  Widget _buildDropdown<T>({
    required String label,
    required T? value,
    required List<T> items,
    required void Function(T?) onChanged,
    String? hint,
    bool requiredField = false,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),
      isExpanded: true,
      hint: hint != null ? Text(hint) : null,
      items: items.map((it) {
        return DropdownMenuItem<T>(value: it, child: Text(it.toString()));
      }).toList(),
      onChanged: onChanged,
      validator: requiredField
          ? (v) {
              if (v == null || (v is String && v.isEmpty))
                return 'Harap pilih $label';
              return null;
            }
          : null,
    );
  }

  String? _validateNIK(String? v) {
    if (v == null || v.trim().isEmpty) return 'NIK wajib diisi';
    final onlyDigits = v.trim().replaceAll(RegExp(r'\D'), '');
    if (onlyDigits.length != 16) return 'NIK harus 16 digit angka';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = _editingId != null;
    // warna utama Jawara
    const primaryColor = Color(0xFF2C3E50);

    return DashboardLayout(
      title: isEdit ? 'Edit Warga' : 'Tambah Warga',
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Card(
            elevation: 1,
            margin: const EdgeInsets.only(top: 8),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 22.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Keluarga (dropdown)
                    _buildDropdown<int>(
                      label: 'Pilih Keluarga',
                      value: _selectedKeluargaId,
                      items: _dummyKeluarga.map((e) => e['id'] as int).toList(),
                      hint: '-- Pilih Keluarga --',
                      onChanged: (v) => setState(() => _selectedKeluargaId = v),
                      requiredField: false,
                    ),
                    const SizedBox(height: 16),

                    // Nama
                    TextFormField(
                      controller: _namaCtl,
                      decoration: const InputDecoration(
                        labelText: 'Nama',
                        hintText: 'Masukkan nama lengkap',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                      ),
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Nama wajib diisi'
                          : null,
                    ),
                    const SizedBox(height: 16),

                    // NIK
                    TextFormField(
                      controller: _nikCtl,
                      decoration: const InputDecoration(
                        labelText: 'NIK',
                        hintText: 'Masukkan NIK sesuai KTP',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: _validateNIK,
                    ),
                    const SizedBox(height: 16),

                    // Nomor Telepon
                    TextFormField(
                      controller: _teleponCtl,
                      decoration: const InputDecoration(
                        labelText: 'Nomor Telepon',
                        hintText: '08xxxxxxxx',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),

                    // Tempat Lahir
                    TextFormField(
                      controller: _tempatLahirCtl,
                      decoration: const InputDecoration(
                        labelText: 'Tempat Lahir',
                        hintText: 'Masukkan tempat lahir',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Tanggal Lahir (date picker)
                    TextFormField(
                      controller: _tanggalLahirCtl,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Tanggal Lahir',
                        hintText: '--/--/----',
                        border: const OutlineInputBorder(),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today_outlined),
                          onPressed: _pickDate,
                        ),
                      ),
                      onTap: _pickDate,
                    ),
                    const SizedBox(height: 16),

                    // Jenis Kelamin
                    _buildDropdown<String>(
                      label: 'Jenis Kelamin',
                      value: _selectedJenisKelamin,
                      items: _jenisKelamin,
                      hint: '-- Pilih Jenis Kelamin --',
                      onChanged: (v) =>
                          setState(() => _selectedJenisKelamin = v),
                      requiredField: false,
                    ),
                    const SizedBox(height: 16),

                    // Agama
                    _buildDropdown<String>(
                      label: 'Agama',
                      value: _selectedAgama,
                      items: _agamaList,
                      hint: '-- Pilih Agama --',
                      onChanged: (v) => setState(() => _selectedAgama = v),
                      requiredField: false,
                    ),
                    const SizedBox(height: 16),

                    // Golongan Darah
                    _buildDropdown<String>(
                      label: 'Golongan Darah',
                      value: _selectedGolonganDarah,
                      items: _golonganDarah,
                      hint: '-- Pilih Golongan Darah --',
                      onChanged: (v) =>
                          setState(() => _selectedGolonganDarah = v),
                      requiredField: false,
                    ),
                    const SizedBox(height: 16),

                    // Peran Keluarga
                    _buildDropdown<String>(
                      label: 'Peran Keluarga',
                      value: _selectedPeranKeluarga,
                      items: _peranKeluarga,
                      hint: '-- Pilih Peran Keluarga --',
                      onChanged: (v) =>
                          setState(() => _selectedPeranKeluarga = v),
                      requiredField: false,
                    ),
                    const SizedBox(height: 16),

                    // Pendidikan Terakhir
                    _buildDropdown<String>(
                      label: 'Pendidikan Terakhir',
                      value: _selectedPendidikan,
                      items: _pendidikan,
                      hint: '-- Pilih Pendidikan Terakhir --',
                      onChanged: (v) => setState(() => _selectedPendidikan = v),
                      requiredField: false,
                    ),
                    const SizedBox(height: 16),

                    // Pekerjaan
                    TextFormField(
                      controller: _pekerjaanCtl,
                      decoration: const InputDecoration(
                        labelText: 'Pekerjaan',
                        hintText: '-- Pilih Jenis Pekerjaan --',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Status
                    _buildDropdown<String>(
                      label: 'Status',
                      value: _selectedStatus,
                      items: _statusList,
                      hint: '-- Pilih Status --',
                      onChanged: (v) => setState(() => _selectedStatus = v),
                      requiredField: false,
                    ),
                    const SizedBox(height: 22),

                    // Buttons (Submit & Reset)
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 14,
                            ),
                          ),
                          child: Text(
                            isEdit ? 'Update' : 'Submit',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton(
                          onPressed: _resetForm,
                          child: const Text('Reset'),
                        ),
                        const SizedBox(width: 8),
                        if (isEdit)
                          TextButton(
                            onPressed: () {
                              // cancel edit and pop without result
                              Navigator.pop(context);
                            },
                            child: const Text('Batal'),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
