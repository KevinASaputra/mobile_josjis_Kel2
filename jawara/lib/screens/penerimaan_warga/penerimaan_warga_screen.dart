import 'package:flutter/material.dart';
import '../../widgets/sidebar.dart';
import 'penerimaan_warga_detail_screen.dart';
import 'penerimaan_warga_edit_screen.dart';

class PenerimaanWargaScreen extends StatefulWidget {
  const PenerimaanWargaScreen({super.key});

  @override
  State<PenerimaanWargaScreen> createState() => _PenerimaanWargaScreenState();
}

class _PenerimaanWargaScreenState extends State<PenerimaanWargaScreen> {
  int currentPage = 1;
  int totalPages = 1;

  final List<Map<String, dynamic>> registrasiData = [
    {
      'no': 1,
      'nama': 'Ijat',
      'nik': '3217010101010001',
      'email': 'ijat@email.com',
      'jenisKelamin': 'Laki-laki',
      'fotoIdentitas': 'ijat.jpeg',
      'status': 'Pending',
    },
    {
      'no': 2,
      'nama': 'Waguri',
      'nik': '3217010101010002',
      'email': 'waguri@email.com',
      'jenisKelamin': 'Perempuan',
      'fotoIdentitas': 'waguri.jpeg',
      'status': 'Diterima',
    },
    {
      'no': 3,
      'nama': 'Prabowo',
      'nik': '3217010101010003',
      'email': 'prabowo@email.com',
      'jenisKelamin': 'Laki-laki',
      'fotoIdentitas': 'prabowo.png',
      'status': 'Ditolak',
    },
  ];

  // filter state
  String? _filterNama;
  String _filterJenisKelamin = 'Semua';
  String _filterStatus = 'Semua';

  List<String> get _jenisKelaminOptions {
    final set = <String>{};
    for (var e in registrasiData) {
      if (e['jenisKelamin'] != null) set.add(e['jenisKelamin'] as String);
    }
    final list = set.toList()..sort();
    return ['Semua', ...list];
  }

  List<String> get _statusOptions {
    final set = <String>{};
    for (var e in registrasiData) {
      if (e['status'] != null) set.add(e['status'] as String);
    }
    final list = set.toList()..sort();
    return ['Semua', ...list];
  }

  List<Map<String, dynamic>> get _filteredRegistrasiData {
    return registrasiData.where((item) {
      final matchesNama = _filterNama == null || _filterNama!.isEmpty
          ? true
          : (item['nama']?.toString().toLowerCase() ?? '').contains(
              _filterNama!.toLowerCase(),
            );
      final matchesJenis =
          _filterJenisKelamin == 'Semua' ||
          item['jenisKelamin'] == _filterJenisKelamin;
      final matchesStatus =
          _filterStatus == 'Semua' || item['status'] == _filterStatus;
      return matchesNama && matchesJenis && matchesStatus;
    }).toList();
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Diterima':
        return Colors.green.shade100;
      case 'Pending':
        return Colors.yellow.shade100;
      case 'Ditolak':
        return Colors.red.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  Color _statusTextColor(String status) {
    switch (status) {
      case 'Diterima':
        return Colors.green.shade700;
      case 'Pending':
        return Colors.orange.shade700;
      case 'Ditolak':
        return Colors.red.shade700;
      default:
        return Colors.grey.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Registrasi Warga'),
        backgroundColor: const Color(0xFF2C3E50),
        foregroundColor: Colors.white,
      ),
      drawer: const Sidebar(),
      body: Container(
        color: const Color(0xFFF1F5F9),
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
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
                // Filter button (opens dialog)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () async {
                        final result = await showDialog<Map<String, String>>(
                          context: context,
                          builder: (context) => _FilterDialog(
                            nama: _filterNama,
                            jenisKelamin: _filterJenisKelamin,
                            status: _filterStatus,
                            jenisOptions: _jenisKelaminOptions,
                            statusOptions: _statusOptions,
                          ),
                        );
                        if (result != null) {
                          setState(() {
                            _filterNama = result['nama']?.isEmpty == true
                                ? null
                                : result['nama'];
                            _filterJenisKelamin = result['jenis'] ?? 'Semua';
                            _filterStatus = result['status'] ?? 'Semua';
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
                      dataRowHeight: 72,
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
                      columns: const [
                        DataColumn(label: Text('NO')),
                        DataColumn(label: Text('NAMA')),
                        DataColumn(label: Text('NIK')),
                        DataColumn(label: Text('EMAIL')),
                        DataColumn(label: Text('JENIS\nKELAMIN')),
                        DataColumn(label: Text('FOTO\nIDENTITAS')),
                        DataColumn(label: Text('STATUS\nREGISTRASI')),
                        DataColumn(label: Text('AKSI')),
                      ],
                      rows: _filteredRegistrasiData.map((item) {
                        return DataRow(
                          cells: [
                            DataCell(Text(item['no'].toString())),
                            DataCell(Text(item['nama'] ?? '-')),
                            DataCell(Text(item['nik'] ?? '-')),
                            DataCell(Text(item['email'] ?? '-')),
                            DataCell(Text(item['jenisKelamin'] ?? '-')),
                            DataCell(
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Preview Identitas',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            ConstrainedBox(
                                              constraints: const BoxConstraints(
                                                maxWidth: 400,
                                                maxHeight: 400,
                                              ),
                                              child: Image.asset(
                                                'img/${item['fotoIdentitas']}',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    'img/${item['fotoIdentitas']}',
                                    width: 48,
                                    height: 48,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: _statusColor(item['status']),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  item['status'],
                                  style: TextStyle(
                                    color: _statusTextColor(item['status']),
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
                                  switch (value) {
                                    case 'detail':
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PenerimaanWargaDetailScreen(
                                                data: item,
                                              ),
                                        ),
                                      );
                                      break;
                                    case 'edit':
                                      if (item['status'] != 'Diterima') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PenerimaanWargaEditScreen(
                                                  data: item,
                                                ),
                                          ),
                                        );
                                      }
                                      break;
                                  }
                                },
                                itemBuilder: (BuildContext context) => [
                                  const PopupMenuItem<String>(
                                    value: 'detail',
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.visibility_outlined,
                                          size: 18,
                                          color: Color(0xFF64748B),
                                        ),
                                        SizedBox(width: 12),
                                        Text('Detail'),
                                      ],
                                    ),
                                  ),
                                  if (item['status'] != 'Diterima')
                                    const PopupMenuItem<String>(
                                      value: 'edit',
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.edit_outlined,
                                            size: 18,
                                            color: Color(0xFF64748B),
                                          ),
                                          SizedBox(width: 12),
                                          Text('Edit'),
                                        ],
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
  final String jenisKelamin;
  final String status;
  final List<String> jenisOptions;
  final List<String> statusOptions;

  const _FilterDialog({
    this.nama,
    required this.jenisKelamin,
    required this.status,
    required this.jenisOptions,
    required this.statusOptions,
  });

  @override
  State<_FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<_FilterDialog> {
  late TextEditingController _namaController;
  late String _jenis;
  late String _status;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.nama);
    _jenis = widget.jenisKelamin;
    _status = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: const Text('Filter Penerimaan Warga'),
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
              value: _jenis,
              items: widget.jenisOptions
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => _jenis = v ?? 'Semua'),
              decoration: const InputDecoration(labelText: 'Jenis Kelamin'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _status,
              items: widget.statusOptions
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => _status = v ?? 'Semua'),
              decoration: const InputDecoration(labelText: 'Status'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              _namaController.clear();
              _jenis = 'Semua';
              _status = 'Semua';
            });
          },
          child: const Text('Reset'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop({
              'nama': _namaController.text,
              'jenis': _jenis,
              'status': _status,
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
