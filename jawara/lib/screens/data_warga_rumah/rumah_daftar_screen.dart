// lib/screens/data_warga_rumah/rumah_daftar_screen.dart
import 'package:flutter/material.dart';
import '../../widgets/dashboard_layout.dart';

final List<Map<String, dynamic>> _dummyRumah = [
  {'id': 1, 'alamat': 'Komplek Melati, Jl. Melati No.5', 'nomor': '05'},
  {'id': 2, 'alamat': 'Perum Mawar, Jl. Mawar No.2', 'nomor': '02'},
  {'id': 3, 'alamat': 'Cluster Kenanga, Jl. Kenanga No.10', 'nomor': '10'},
];

class RumahDaftarScreen extends StatefulWidget {
  const RumahDaftarScreen({Key? key}) : super(key: key);
  static const routeName = '/rumah/daftar';

  @override
  _RumahDaftarScreenState createState() => _RumahDaftarScreenState();
}

class _RumahDaftarScreenState extends State<RumahDaftarScreen> {
  late List<Map<String, dynamic>> rumahList;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        rumahList = List<Map<String, dynamic>>.from(_dummyRumah);
        _loading = false;
      });
    });
  }

  Future<void> _openTambah() async {
    // gunakan route '/rumah/tambah' — konsisten dengan rumah_tambah_screen.routeName
    final result = await Navigator.pushNamed(context, '/rumah/tambah');
    if (result is Map<String, dynamic>) {
      setState(() {
        final nextId = (rumahList.isEmpty)
            ? 1
            : (rumahList
                      .map((e) => e['id'] as int)
                      .reduce((a, b) => a > b ? a : b) +
                  1);
        result['id'] = nextId;
        rumahList.insert(0, result);
      });
    }
  }

  Future<void> _openEdit(Map<String, dynamic> r) async {
    final result = await Navigator.pushNamed(
      context,
      '/rumah/tambah',
      arguments: r,
    );
    if (result is Map<String, dynamic>) {
      setState(() {
        final idx = rumahList.indexWhere((x) => x['id'] == result['id']);
        if (idx != -1) rumahList[idx] = result;
      });
    }
  }

  void _hapusRumah(int id) {
    showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus rumah?'),
        content: const Text('Apakah Anda yakin ingin menghapus rumah ini?'),
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
        setState(() => rumahList.removeWhere((r) => r['id'] == id));
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Rumah terhapus')));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      title: 'Daftar Rumah',
      child: _loading
          ? ListView.builder(
              itemCount: 3,
              itemBuilder: (_, __) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0),
                child: Card(
                  elevation: 1,
                  child: ListTile(title: SizedBox(height: 12)),
                ),
              ),
            )
          : Column(
              children: [
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: _openTambah,
                      icon: const Icon(Icons.add_home),
                      label: const Text('Tambah Rumah'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: () {
                        setState(
                          () => rumahList = List<Map<String, dynamic>>.from(
                            _dummyRumah,
                          ),
                        );
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reset'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: rumahList.isEmpty
                      ? const Center(child: Text('Belum ada data rumah.'))
                      : ListView.separated(
                          itemCount: rumahList.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, idx) {
                            final r = rumahList[idx];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              child: ListTile(
                                title: Text(
                                  r['alamat'] ?? '-',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text('No: ${r['nomor'] ?? '-'}'),
                                trailing: PopupMenuButton<String>(
                                  onSelected: (v) {
                                    if (v == 'edit') _openEdit(r);
                                    if (v == 'hapus')
                                      _hapusRumah(r['id'] as int);
                                  },
                                  itemBuilder: (_) => const [
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
