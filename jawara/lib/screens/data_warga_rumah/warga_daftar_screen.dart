// lib/screens/data_warga_rumah/warga_daftar_screen.dart
import 'package:flutter/material.dart';
import '../../widgets/dashboard_layout.dart';

/// Dummy initial data
final List<Map<String, dynamic>> _initialWarga = [
  {
    'id': 1,
    'keluarga_id': 1,
    'nama': 'Budi Santoso',
    'nik': '1234567890123456',
    'telepon': '081234567890',
    'alamat': 'Jl. Melati No.5',
  },
  {
    'id': 2,
    'keluarga_id': 1,
    'nama': 'Siti Aminah',
    'nik': '6543210987654321',
    'telepon': '082345678901',
    'alamat': 'Jl. Melati No.5',
  },
  {
    'id': 3,
    'keluarga_id': 2,
    'nama': 'Andi Wijaya',
    'nik': '9876543210987654',
    'telepon': '083456789012',
    'alamat': 'Jl. Kenanga No.10',
  },
];

class WargaDaftarScreen extends StatefulWidget {
  const WargaDaftarScreen({Key? key}) : super(key: key);
  static const routeName = '/warga/daftar';

  @override
  State<WargaDaftarScreen> createState() => _WargaDaftarScreenState();
}

class _WargaDaftarScreenState extends State<WargaDaftarScreen> {
  late List<Map<String, dynamic>> _wargaList;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    // simulate loading
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _wargaList = List<Map<String, dynamic>>.from(_initialWarga);
        _loading = false;
      });
    });
  }

  /// Buka form tambah tanpa arguments -> mode tambah
  Future<void> _openTambah() async {
    final result = await Navigator.pushNamed(context, '/warga/tambah');
    _handleFormResult(result);
  }

  /// Buka form edit, kirim item sebagai arguments
  Future<void> _openEdit(Map<String, dynamic> item) async {
    final result = await Navigator.pushNamed(
      context,
      '/warga/tambah',
      arguments: item,
    );
    _handleFormResult(result);
  }

  /// Terima hasil dari form (Map) dan update list
  void _handleFormResult(Object? result) {
    if (result is Map<String, dynamic>) {
      // kalau ada id -> update, jika tidak -> new item (tambahkan id baru)
      if (result.containsKey('id') && result['id'] != null) {
        final id = result['id'] as int;
        final idx = _wargaList.indexWhere((w) => w['id'] == id);
        if (idx != -1) {
          setState(() {
            _wargaList[idx] = {..._wargaList[idx], ...result};
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data warga diperbarui')),
          );
          return;
        }
      }

      // tambah baru: beri id incremental
      final nextId = (_wargaList.isEmpty)
          ? 1
          : (_wargaList
                    .map((e) => e['id'] as int)
                    .reduce((a, b) => a > b ? a : b) +
                1);
      final newItem = <String, dynamic>{'id': nextId, ...result};
      setState(() => _wargaList.insert(0, newItem));
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Data warga ditambahkan')));
    }
  }

  void _hapusWarga(int id) {
    showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus Warga'),
        content: const Text('Anda yakin ingin menghapus data ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    ).then((ok) {
      if (ok == true) {
        setState(() {
          _wargaList.removeWhere((w) => w['id'] == id);
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Data warga dihapus')));
      }
    });
  }

  void _openKeluarga(Map<String, dynamic> warga) {
    Navigator.pushNamed(context, '/keluarga', arguments: warga);
  }

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      title: 'Daftar Warga',
      child: _loading
          ? ListView.builder(
              itemCount: 4,
              itemBuilder: (_, __) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Card(
                  child: ListTile(
                    title: SizedBox(height: 12),
                    subtitle: SizedBox(height: 8),
                  ),
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text('Tambah Warga'),
                      onPressed: _openTambah,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _wargaList = List<Map<String, dynamic>>.from(
                            _initialWarga,
                          );
                        });
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reset'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: _wargaList.isEmpty
                      ? const Center(child: Text('Belum ada data warga'))
                      : ListView.separated(
                          itemCount: _wargaList.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, idx) {
                            final w = _wargaList[idx];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              child: ListTile(
                                title: Text(
                                  w['nama'] ?? '-',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  'NIK: ${w['nik'] ?? '-'}\n${w['telepon'] ?? ''}\n${w['alamat'] ?? ''}',
                                ),
                                isThreeLine: true,
                                trailing: PopupMenuButton<String>(
                                  onSelected: (v) {
                                    if (v == 'edit') _openEdit(w);
                                    if (v == 'hapus')
                                      _hapusWarga(w['id'] as int);
                                    if (v == 'keluarga') _openKeluarga(w);
                                  },
                                  itemBuilder: (_) => const [
                                    PopupMenuItem(
                                      value: 'keluarga',
                                      child: Text('Lihat Keluarga'),
                                    ),
                                    PopupMenuItem(
                                      value: 'edit',
                                      child: Text('Edit'),
                                    ),
                                    PopupMenuItem(
                                      value: 'hapus',
                                      child: Text('Hapus'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
