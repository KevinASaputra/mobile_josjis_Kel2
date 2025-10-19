// lib/screens/data_warga_rumah/warga_daftar_screen.dart
import 'package:flutter/material.dart';
import '../../widgets/dashboard_layout.dart';

/// Dummy data (frontend-only)
final List<Map<String, dynamic>> _dummyWarga = [
  {
    'id': 1,
    'nama': 'Budi Santoso',
    'nik': '1234567890123456',
    'alamat': 'Jl. Melati No.5',
    'rumah_id': 1,
  },
  {
    'id': 2,
    'nama': 'Siti Aminah',
    'nik': '6543210987654321',
    'alamat': 'Jl. Mawar No.2',
    'rumah_id': 1,
  },
  {
    'id': 3,
    'nama': 'Andi Wijaya',
    'nik': '9876543210987654',
    'alamat': 'Jl. Kenanga No.10',
    'rumah_id': 2,
  },
];

class WargaDaftarScreen extends StatefulWidget {
  const WargaDaftarScreen({Key? key}) : super(key: key);
  static const routeName = '/warga-daftar';

  @override
  _WargaDaftarScreenState createState() => _WargaDaftarScreenState();
}

class _WargaDaftarScreenState extends State<WargaDaftarScreen> {
  late List<Map<String, dynamic>> wargaList;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    // simulate load
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        wargaList = List<Map<String, dynamic>>.from(_dummyWarga);
        _loading = false;
      });
    });
  }

  Future<void> _openTambah() async {
    final result = await Navigator.pushNamed(context, '/warga-tambah');
    // expect result as Map<String,dynamic>
    if (result is Map<String, dynamic>) {
      setState(() {
        // assign an id
        final nextId = (wargaList.isEmpty)
            ? 1
            : (wargaList
                      .map((e) => e['id'] as int)
                      .reduce((a, b) => a > b ? a : b) +
                  1);
        result['id'] = nextId;
        wargaList.insert(0, result);
      });
    }
  }

  Future<void> _openEdit(Map<String, dynamic> data) async {
    final result = await Navigator.pushNamed(
      context,
      '/warga-tambah',
      arguments: data,
    );
    if (result is Map<String, dynamic>) {
      setState(() {
        final idx = wargaList.indexWhere((w) => w['id'] == result['id']);
        if (idx != -1) wargaList[idx] = result;
      });
    }
  }

  void _openKeluarga(Map<String, dynamic> warga) {
    Navigator.pushNamed(context, '/keluarga', arguments: warga);
  }

  void _hapusWarga(int id) {
    showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus warga?'),
        content: const Text(
          'Apakah Anda yakin ingin menghapus data warga ini?',
        ),
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
          wargaList.removeWhere((w) => w['id'] == id);
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Data warga terhapus')));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      title: 'Daftar Warga',
      child: _loading
          ? ListView.builder(
              itemCount: 4,
              itemBuilder: (_, __) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0),
                child: Card(
                  elevation: 1,
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
                      onPressed: _openTambah,
                      icon: const Icon(Icons.add),
                      label: const Text('Tambah Warga'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          wargaList = List<Map<String, dynamic>>.from(
                            _dummyWarga,
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
                  child: wargaList.isEmpty
                      ? const Center(child: Text('Belum ada data warga.'))
                      : ListView.separated(
                          itemCount: wargaList.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (context, i) {
                            final w = wargaList[i];
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
                                  'NIK: ${w['nik'] ?? '-'}\n${w['alamat'] ?? '-'}',
                                ),
                                isThreeLine: true,
                                trailing: PopupMenuButton<String>(
                                  onSelected: (v) {
                                    if (v == 'edit') _openEdit(w);
                                    if (v == 'hapus')
                                      _hapusWarga(w['id'] as int);
                                    if (v == 'keluarga') _openKeluarga(w);
                                  },
                                  itemBuilder: (ctx) => const [
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
