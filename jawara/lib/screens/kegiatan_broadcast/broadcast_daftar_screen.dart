import 'package:flutter/material.dart';
import '../../widgets/sidebar.dart';

class BroadcastDaftarScreen extends StatefulWidget {
  const BroadcastDaftarScreen({super.key});

  @override
  State<BroadcastDaftarScreen> createState() => _BroadcastDaftarScreenState();
}

class _BroadcastDaftarScreenState extends State<BroadcastDaftarScreen> {
  int currentPage = 1;
  int totalPages = 1;

  // Sample data for broadcast list
  final List<Map<String, dynamic>> broadcastData = [
    {
      'no': 1,
      'pengirim': 'Admin Jawara',
      'judul': 'DJ BAWS',
      'tanggal': '17 Oktober 2025',
    },
    {
      'no': 2,
      'pengirim': 'Admin Jawara',
      'judul': 'gotong royong',
      'tanggal': '14 Oktober 2025',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Broadcast - Daftar'),
        backgroundColor: const Color(0xFF2C3E50),
        foregroundColor: Colors.white,
      ),
      drawer: const Sidebar(),
      body: Container(
        color: const Color(0xFFF1F5F9),
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 900),
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
                // Filter button section
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
                            // Handle filter action
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
                
                // Data Table
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: DataTable(
                      columnSpacing: 60,
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
                          label: SizedBox(
                            width: 60,
                            child: Text('NO'),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 150,
                            child: Text('PENGIRIM'),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 200,
                            child: Text('JUDUL'),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 150,
                            child: Text('TANGGAL'),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 80,
                            child: Text('AKSI'),
                          ),
                        ),
                      ],
                      rows: broadcastData.map((item) {
                        return DataRow(
                          cells: [
                            DataCell(
                              SizedBox(
                                width: 60,
                                child: Text(item['no'].toString()),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 150,
                                child: Text(
                                  item['pengirim'],
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 200,
                                child: Text(
                                  item['judul'],
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 150,
                                child: Text(
                                  item['tanggal'],
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 80,
                                child: PopupMenuButton<String>(
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
                                        // Handle detail
                                        print('Detail selected');
                                        break;
                                      case 'edit':
                                        // Handle edit
                                        print('Edit selected');
                                        break;
                                      case 'hapus':
                                        // Handle delete
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
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
                
                // Pagination
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