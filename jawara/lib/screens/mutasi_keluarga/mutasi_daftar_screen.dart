import 'package:flutter/material.dart';
import '../../widgets/sidebar.dart';
import 'mutasi_detail_screen.dart'; // added import

class MutasiDaftarScreen extends StatefulWidget {
  const MutasiDaftarScreen({super.key});

  @override
  State<MutasiDaftarScreen> createState() => _MutasiDaftarScreenState();
}

class _MutasiDaftarScreenState extends State<MutasiDaftarScreen> {
  int currentPage = 1;
  int totalPages = 1;

  final List<Map<String, dynamic>> mutasiData = [
    {
      'no': 1,
      'tanggal': '10 Oktober 2025',
      'keluarga': 'Keluarga Ijat',
      'jenis': 'Keluar Wilayah',
    },
    {
      'no': 2,
      'tanggal': '15 Oktober 2025',
      'keluarga': 'Keluarga Waguri',
      'jenis': 'Pindah Rumah',
    },
  ];

  // --- added filter state ---
  String _selectedJenisFilter = 'Semua';
  String _selectedKeluargaFilter = 'Semua';

  List<String> get _keluargaOptions {
    final set = <String>{};
    for (var e in mutasiData) {
      if (e['keluarga'] != null) set.add(e['keluarga'] as String);
    }
    final list = set.toList()..sort();
    return ['Semua', ...list];
  }

  List<String> get _jenisOptions {
    final set = <String>{};
    for (var e in mutasiData) {
      if (e['jenis'] != null) set.add(e['jenis'] as String);
    }
    final list = set.toList()..sort();
    return ['Semua', ...list];
  }

  List<Map<String, dynamic>> get _filteredMutasiData {
    return mutasiData.where((item) {
      final matchesJenis =
          _selectedJenisFilter == 'Semua' ||
          item['jenis'] == _selectedJenisFilter;
      final matchesKeluarga =
          _selectedKeluargaFilter == 'Semua' ||
          item['keluarga'] == _selectedKeluargaFilter;
      return matchesJenis && matchesKeluarga;
    }).toList();
  }
  // --- end added filter state ---

  Color _jenisColor(String jenis) {
    if (jenis == 'Keluar Wilayah') {
      return Colors.red.shade100;
    } else if (jenis == 'Pindah Rumah') {
      return Colors.green.shade100;
    }
    return Colors.grey.shade200;
  }

  Color _jenisTextColor(String jenis) {
    if (jenis == 'Keluar Wilayah') {
      return Colors.red.shade400;
    } else if (jenis == 'Pindah Rumah') {
      return Colors.green.shade400;
    }
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mutasi Keluarga - Daftar'),
        backgroundColor: const Color(0xFF2C3E50),
        foregroundColor: Colors.white,
      ),
      drawer: const Sidebar(),
      body: Container(
        color: const Color(0xFFF1F5F9),
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  spreadRadius: 0,
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // header replaced with filter button (design like pengeluaran_daftar_screen)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () async {
                        final result = await showDialog<Map<String, String>>(
                          context: context,
                          builder: (context) => _FilterDialog(
                            selectedJenis: _selectedJenisFilter,
                            selectedKeluarga: _selectedKeluargaFilter,
                            jenisOptions: _jenisOptions,
                            keluargaOptions: _keluargaOptions,
                          ),
                        );
                        if (result != null) {
                          setState(() {
                            _selectedJenisFilter = result['jenis'] ?? 'Semua';
                            _selectedKeluargaFilter =
                                result['keluarga'] ?? 'Semua';
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366F1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 18,
                        ),
                        elevation: 0,
                      ),
                      child: const Icon(Icons.filter_list, color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: DataTable(
                      columnSpacing: 40,
                      headingRowHeight: 60,
                      dataRowHeight: 60,
                      headingRowColor: MaterialStateProperty.all(
                        Colors.transparent,
                      ),
                      headingTextStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B),
                        letterSpacing: 0.5,
                      ),
                      dataTextStyle: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF1E293B),
                        fontWeight: FontWeight.w500,
                      ),
                      dividerThickness: 0,
                      columns: const [
                        DataColumn(label: Text('NO')),
                        DataColumn(label: Text('TANGGAL')),
                        DataColumn(label: Text('KELUARGA')),
                        DataColumn(label: Text('JENIS MUTASI')),
                        DataColumn(label: Text('AKSI')),
                      ],
                      // use filtered data here
                      rows: _filteredMutasiData.map((item) {
                        return DataRow(
                          cells: [
                            DataCell(Text(item['no'].toString())),
                            DataCell(Text(item['tanggal'] ?? '')),
                            DataCell(Text(item['keluarga'] ?? '')),
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: _jenisColor(item['jenis']),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  item['jenis'],
                                  style: TextStyle(
                                    color: _jenisTextColor(item['jenis']),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              PopupMenuButton<String>(
                                icon: const Icon(
                                  Icons.more_horiz,
                                  color: Color(0xFF64748B),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 8,
                                offset: const Offset(0, 8),
                                color: Colors.white,
                                onSelected: (value) {
                                  if (value == 'detail') {
                                    // navigate to detail screen (replaces inline dialog)
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MutasiDetailScreen(data: item),
                                      ),
                                    );
                                  }
                                },
                                itemBuilder: (BuildContext context) => [
                                  PopupMenuItem<String>(
                                    value: 'detail',
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      child: const Row(
                                        children: [
                                          Icon(
                                            Icons.visibility_outlined,
                                            size: 18,
                                            color: Color(0xFF64748B),
                                          ),
                                          SizedBox(width: 12),
                                          Text(
                                            'Detail',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF1E293B),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: currentPage > 1
                            ? () {
                                setState(() {
                                  currentPage--;
                                });
                              }
                            : null,
                        icon: const Icon(
                          Icons.chevron_left,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366F1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          currentPage.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: currentPage < totalPages
                            ? () {
                                setState(() {
                                  currentPage++;
                                });
                              }
                            : null,
                        icon: const Icon(
                          Icons.chevron_right,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FilterDialog extends StatefulWidget {
  final String selectedJenis;
  final String selectedKeluarga;
  final List<String> jenisOptions;
  final List<String> keluargaOptions;

  const _FilterDialog({
    required this.selectedJenis,
    required this.selectedKeluarga,
    required this.jenisOptions,
    required this.keluargaOptions,
  });

  @override
  State<_FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<_FilterDialog> {
  late String? _jenis;
  late String? _keluarga;

  @override
  void initState() {
    super.initState();
    _jenis = widget.selectedJenis;
    _keluarga = widget.selectedKeluarga;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: const Text('Filter Mutasi Keluarga'),
      content: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Jenis Mutasi'),
              value: _jenis,
              items: widget.jenisOptions
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => _jenis = v),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Keluarga'),
              value: _keluarga,
              items: widget.keluargaOptions
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => _keluarga = v),
            ),
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      actions: [
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _jenis = 'Semua';
                    _keluarga = 'Semua';
                  });
                },
                child: const Text('Reset'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop({
                    'jenis': _jenis ?? 'Semua',
                    'keluarga': _keluarga ?? 'Semua',
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Terapkan'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
