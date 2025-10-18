import 'package:flutter/material.dart';
import '../../widgets/sidebar.dart';

class KegiatanDaftarScreen extends StatefulWidget {
  const KegiatanDaftarScreen({super.key});

  @override
  State<KegiatanDaftarScreen> createState() => _KegiatanDaftarScreenState();
}

class _KegiatanDaftarScreenState extends State<KegiatanDaftarScreen> {
  int currentPage = 1;
  int totalPages = 1;

  final List<Map<String, dynamic>> kegiatanData = [
    {
      'no': 1,
      'namaKegiatan': 'Musy',
      'kategori': 'Komunitas & Sosial',
      'penanggungJawab': 'Pak',
      'tanggalPelaksanaan': '12 Oktober 2025',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kegiatan - Daftar'),
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
                        DataColumn(
                          label: Text('NO'),
                        ),
                        DataColumn(
                          label: Text('NAMA\nKEGIATAN'),
                        ),
                        DataColumn(
                          label: Text('KATEGORI'),
                        ),
                        DataColumn(
                          label: Text('PENANGGUNG\nJAWAB'),
                        ),
                        DataColumn(
                          label: Text('TANGGAL\nPELAKSANAAN'),
                        ),
                        DataColumn(
                          label: Text('AKSI'),
                        ),
                      ],
                      rows: kegiatanData.map((item) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(item['no'].toString()),
                            ),
                            DataCell(
                              Text(item['namaKegiatan']),
                            ),
                            DataCell(
                              Text(item['kategori']),
                            ),
                            DataCell(
                              Text(item['penanggungJawab']),
                            ),
                            DataCell(
                              Text(item['tanggalPelaksanaan']),
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
                                      print('Detail selected');
                                      break;
                                    case 'edit':
                                      print('Edit selected');
                                      break;
                                    case 'hapus':
                                      print('Hapus selected');
                                      break;
                                  }
                                },
                                itemBuilder: (BuildContext context) => [
                                  PopupMenuItem<String>(
                                    value: 'detail',
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 8),
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
                                  PopupMenuItem<String>(
                                    value: 'edit',
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      child: const Row(
                                        children: [
                                          Icon(
                                            Icons.edit_outlined,
                                            size: 18,
                                            color: Color(0xFF64748B),
                                          ),
                                          SizedBox(width: 12),
                                          Text(
                                            'Edit',
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
                                  PopupMenuItem<String>(
                                    value: 'hapus',
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      child: const Row(
                                        children: [
                                          Icon(
                                            Icons.delete_outline,
                                            size: 18,
                                            color: Color(0xFFEF4444),
                                          ),
                                          SizedBox(width: 12),
                                          Text(
                                            'Hapus',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFFEF4444),
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
                        onPressed: currentPage > 1 ? () {
                          setState(() {
                            currentPage--;
                          });
                        } : null,
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
                        onPressed: currentPage < totalPages ? () {
                          setState(() {
                            currentPage++;
                          });
                        } : null,
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