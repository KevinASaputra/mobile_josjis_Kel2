import 'package:flutter/material.dart';
import '../../widgets/sidebar.dart';

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
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366F1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          onPressed: () {
                            // filter action (implement as needed)
                          },
                          icon: const Icon(
                            Icons.filter_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
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
                      rows: mutasiData.map((item) {
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
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text(
                                            'Detail Mutasi Keluarga',
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Tanggal: ${item['tanggal']}',
                                              ),
                                              Text(
                                                'Keluarga: ${item['keluarga']}',
                                              ),
                                              Text(
                                                'Jenis Mutasi: ${item['jenis']}',
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: const Text('Tutup'),
                                            ),
                                          ],
                                        );
                                      },
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
