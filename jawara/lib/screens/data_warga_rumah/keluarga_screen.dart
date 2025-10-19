// lib/screens/data_warga_rumah/keluarga_screen.dart
import 'package:flutter/material.dart';
import '../../widgets/dashboard_layout.dart';

/// Dummy keluarga mapping berdasarkan warga id
final Map<int, List<Map<String, String>>> _dummyKeluargaById = {
  1: [
    {'nama': 'Budi Santoso', 'hubungan': 'Kepala Keluarga'},
    {'nama': 'Siti Aminah', 'hubungan': 'Istri'},
    {'nama': 'Dedi Putra', 'hubungan': 'Anak'},
  ],
  2: [
    {'nama': 'Andi Wijaya', 'hubungan': 'Kepala Keluarga'},
    {'nama': 'Rina', 'hubungan': 'Istri'},
  ],
};

class KeluargaScreen extends StatelessWidget {
  const KeluargaScreen({Key? key}) : super(key: key);
  static const routeName = '/warga/keluarga';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    Map<String, dynamic>? warga;
    if (args is Map<String, dynamic>) warga = args;
    final nama = warga?['nama'] ?? 'Detail Keluarga';
    final id = warga?['id'] as int?;
    final anggota = (id != null && _dummyKeluargaById.containsKey(id))
        ? _dummyKeluargaById[id]!
        : <Map<String, String>>[];

    return DashboardLayout(
      title: 'Keluarga - $nama',
      child: anggota.isEmpty
          ? const Center(child: Text('Belum ada anggota keluarga.'))
          : ListView.separated(
              itemCount: anggota.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, idx) {
                final a = anggota[idx];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    title: Text(
                      a['nama'] ?? '-',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text('Hubungan: ${a['hubungan'] ?? '-'}'),
                  ),
                );
              },
            ),
    );
  }
}
