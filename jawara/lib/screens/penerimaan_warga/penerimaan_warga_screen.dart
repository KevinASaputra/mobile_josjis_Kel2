import 'package:flutter/material.dart';
import '../../widgets/sidebar.dart';

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
                          onPressed: () {},
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
                      rows: registrasiData.map((item) {
                        return DataRow(
                          cells: [
                            DataCell(Text(item['no'].toString())),
                            DataCell(Text(item['nama'])),
                            DataCell(Text(item['nik'])),
                            DataCell(Text(item['email'])),
                            DataCell(Text(item['jenisKelamin'])),
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
                                            Image.asset(
                                              'img/${item['fotoIdentitas']}',
                                              fit: BoxFit.contain,
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
                                      // Show detail dialog
                                      break;
                                    case 'edit':
                                      if (item['status'] != 'Diterima') {
                                        // Show edit dialog
                                      }
                                      break;
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
                                  if (item['status'] != 'Diterima')
                                    PopupMenuItem<String>(
                                      value: 'edit',
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
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
