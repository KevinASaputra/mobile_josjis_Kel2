import 'package:flutter/material.dart';
import '../../widgets/sidebar.dart';
import 'laporan_pemasukan_detail_screen.dart'; // added import

class LaporanPemasukanScreen extends StatefulWidget {
  const LaporanPemasukanScreen({super.key});

  @override
  State<LaporanPemasukanScreen> createState() => _LaporanPemasukanScreenState();
}

class _LaporanPemasukanScreenState extends State<LaporanPemasukanScreen> {
  // pagination state
  int currentPage = 1;
  int totalPages = 1;

  // sample pemasukan data (updated keys)
  final List<Map<String, dynamic>> pemasukanData = [
    {
      'no': 1,
      'nama': 'Iuran RT 05',
      'kategori': 'Iuran Warga',
      'nominal': 150000,
      'tanggal': DateTime(2025, 10, 12),
      'keterangan': 'Iuran bulanan RT',
      'verifikator': 'Admin A',
    },
    {
      'no': 2,
      'nama': 'Donatur A',
      'kategori': 'Donasi',
      'nominal': 250000,
      'tanggal': DateTime(2025, 10, 20),
      'keterangan': 'Donasi acara kebersihan',
      'verifikator': 'Admin B',
    },
  ];

  // --- filter state ---
  String? _filterNama;
  String _filterKategori = 'Semua';
  DateTime? _filterDari;
  DateTime? _filterSampai;

  List<String> get _kategoriOptions {
    final set = <String>{};
    for (var e in pemasukanData) {
      if (e['kategori'] != null) set.add(e['kategori'] as String);
    }
    final list = set.toList()..sort();
    return ['Semua', ...list];
  }

  List<Map<String, dynamic>> get _filteredPemasukanData {
    return pemasukanData.where((item) {
      final matchesNama = _filterNama == null || _filterNama!.isEmpty
          ? true
          : (item['nama']?.toString().toLowerCase() ?? '').contains(
              _filterNama!.toLowerCase(),
            );
      final matchesKategori =
          _filterKategori == 'Semua' || item['kategori'] == _filterKategori;
      final tanggal = item['tanggal'] as DateTime?;
      final matchesDari =
          _filterDari == null ||
          (tanggal != null && !tanggal.isBefore(_filterDari!));
      final matchesSampai =
          _filterSampai == null ||
          (tanggal != null && !tanggal.isAfter(_filterSampai!));
      return matchesNama && matchesKategori && matchesDari && matchesSampai;
    }).toList();
  }
  // --- end filter state ---

  Future<void> _pickDate(BuildContext context, bool isDari) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isDari) {
          _filterDari = picked;
        } else {
          _filterSampai = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan Pemasukan'),
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
                // filter button (opens dialog)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () async {
                        final result = await showDialog<Map<String, dynamic>>(
                          context: context,
                          builder: (context) => _FilterDialog(
                            nama: _filterNama,
                            kategori: _filterKategori,
                            dari: _filterDari,
                            sampai: _filterSampai,
                            kategoriOptions: _kategoriOptions,
                          ),
                        );
                        if (result != null) {
                          setState(() {
                            _filterNama = result['nama'] as String?;
                            _filterKategori =
                                result['kategori'] as String? ?? 'Semua';
                            _filterDari = result['dari'] as DateTime?;
                            _filterSampai = result['sampai'] as DateTime?;
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
                        DataColumn(label: Text('No')),
                        DataColumn(label: Text('Nama')),
                        DataColumn(label: Text('Kategori')),
                        DataColumn(label: Text('Tanggal')),
                        DataColumn(label: Text('Nominal')),
                        DataColumn(label: Text('Aksi')),
                      ],
                      rows: _filteredPemasukanData.map((item) {
                        final tanggal = item['tanggal'] as DateTime?;
                        final tanggalText = tanggal == null
                            ? '-'
                            : '${tanggal.day}/${tanggal.month}/${tanggal.year}';
                        return DataRow(
                          cells: [
                            DataCell(Text(item['no'].toString())),
                            DataCell(Text(item['nama'] ?? 'N/A')),
                            DataCell(Text(item['kategori'] ?? 'N/A')),
                            DataCell(Text(tanggalText)),
                            DataCell(Text('Rp ${item['nominal'].toString()}')),
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            LaporanPemasukanDetailScreen(
                                              data: item,
                                            ),
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

// --- Filter Dialog ---
class _FilterDialog extends StatefulWidget {
  final String? nama;
  final String kategori;
  final DateTime? dari;
  final DateTime? sampai;
  final List<String> kategoriOptions;

  const _FilterDialog({
    this.nama,
    required this.kategori,
    this.dari,
    this.sampai,
    required this.kategoriOptions,
  });

  @override
  State<_FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<_FilterDialog> {
  late TextEditingController _namaController;
  late String _kategori;
  DateTime? _dari;
  DateTime? _sampai;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.nama);
    _kategori = widget.kategori;
    _dari = widget.dari;
    _sampai = widget.sampai;
  }

  Future<void> _pickDate(BuildContext context, bool isDari) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isDari
          ? (_dari ?? DateTime.now())
          : (_sampai ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isDari)
          _dari = picked;
        else
          _sampai = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: const Text('Filter Pemasukan'),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _kategori,
              items: widget.kategoriOptions
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => _kategori = v ?? 'Semua'),
              decoration: const InputDecoration(labelText: 'Kategori'),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => _pickDate(context, true),
              child: AbsorbPointer(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Dari Tanggal',
                    hintText: _dari == null
                        ? ''
                        : '${_dari!.day}/${_dari!.month}/${_dari!.year}',
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => _pickDate(context, false),
              child: AbsorbPointer(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Sampai Tanggal',
                    hintText: _sampai == null
                        ? ''
                        : '${_sampai!.day}/${_sampai!.month}/${_sampai!.year}',
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              _namaController.clear();
              _kategori = 'Semua';
              _dari = null;
              _sampai = null;
            });
          },
          child: const Text('Reset'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop({
              'nama': _namaController.text.isEmpty
                  ? null
                  : _namaController.text,
              'kategori': _kategori,
              'dari': _dari,
              'sampai': _sampai,
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6366F1),
          ),
          child: const Text('Terapkan', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
