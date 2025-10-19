import 'package:flutter/material.dart';
import '../../widgets/sidebar.dart';

class LogAktifitasScreen extends StatefulWidget {
  const LogAktifitasScreen({super.key});

  @override
  State<LogAktifitasScreen> createState() => _LogAktifitasScreenState();
}

class _LogAktifitasScreenState extends State<LogAktifitasScreen> {
  int currentPage = 1;
  int totalPages = 2;
  int itemsPerPage = 10;

  final List<Map<String, dynamic>> allLogData = [
    {
      'no': 1,
      'deskripsi': 'Mendownload laporan keuangan',
      'aktor': 'Admin Jawara',
      'tanggal': '19 Oktober 2025',
    },
    {
      'no': 2,
      'deskripsi': 'Menambahkan iuran baru: Harian',
      'aktor': 'Admin Jawara',
      'tanggal': '19 Oktober 2025',
    },
    {
      'no': 3,
      'deskripsi': 'Menambahkan iuran baru: Kerja Bakti',
      'aktor': 'Admin Jawara',
      'tanggal': '19 Oktober 2025',
    },
    {
      'no': 4,
      'deskripsi': 'Mendownload laporan keuangan',
      'aktor': 'Admin Jawara',
      'tanggal': '19 Oktober 2025',
    },
    {
      'no': 5,
      'deskripsi': 'Menyetujui registrasi dari : Keluarga Farhan',
      'aktor': 'Admin Jawara',
      'tanggal': '19 Oktober 2025',
    },
    {
      'no': 6,
      'deskripsi': 'Menugaskan tagihan : Mingguan periode Oktober 2025 sebesar Rp. 12',
      'aktor': 'Admin Jawara',
      'tanggal': '18 Oktober 2025',
    },
    {
      'no': 7,
      'deskripsi': 'Menghapus transfer channel: Bank Mega',
      'aktor': 'Admin Jawara',
      'tanggal': '18 Oktober 2025',
    },
    {
      'no': 8,
      'deskripsi': 'Menambahkan rumah baru dengan alamat: Jl. Merlabu',
      'aktor': 'Admin Jawara',
      'tanggal': '18 Oktober 2025',
    },
    {
      'no': 9,
      'deskripsi': 'Mengubah iuran: Agustusan',
      'aktor': 'Admin Jawara',
      'tanggal': '17 Oktober 2025',
    },
    {
      'no': 10,
      'deskripsi': 'Membuat broadcast baru: DJ BAWS',
      'aktor': 'Admin Jawara',
      'tanggal': '17 Oktober 2025',
    },
    {
      'no': 11,
      'deskripsi': 'Menambahkan pengeluaran : Arka sebesar Rp. 6',
      'aktor': 'Admin Jawara',
      'tanggal': '17 Oktober 2025',
    },
    {
      'no': 12,
      'deskripsi': 'Menambahkan akun : dewqedwddw sebagai neighborhood_head',
      'aktor': 'Admin Jawara',
      'tanggal': '17 Oktober 2025',
    },
    {
      'no': 13,
      'deskripsi': 'Memperbarui data warga: varizkv naldiba rintra',
      'aktor': 'Admin Jawara',
      'tanggal': '17 Oktober 2025',
    },
    {
      'no': 14,
      'deskripsi': 'Menyetujui registrasi dari : Keluarga Rendha Putra Rahmadya',
      'aktor': 'Admin Jawara',
      'tanggal': '16 Oktober 2025',
    },
    {
      'no': 15,
      'deskripsi': 'Menugaskan tagihan : Mingguan periode Oktober 2025 sebesar Rp. 12',
      'aktor': 'Admin Jawara',
      'tanggal': '16 Oktober 2025',
    },
    {
      'no': 16,
      'deskripsi': 'Mutasi rumah : Keluarga Ijat pindah Keluar Wilayah',
      'aktor': 'Admin Jawara',
      'tanggal': '16 Oktober 2025',
    },
    {
      'no': 17,
      'deskripsi': 'Menyetujui pesan warga: titootlt',
      'aktor': 'Admin Jawara',
      'tanggal': '16 Oktober 2025',
    },
    {
      'no': 18,
      'deskripsi': 'Menugaskan tagihan : Mingguan periode Oktober 2025 sebesar Rp. 12',
      'aktor': 'Admin Jawara',
      'tanggal': '16 Oktober 2025',
    },
    {
      'no': 19,
      'deskripsi': 'Menambahkan rumah baru dengan alamat: Griyashanta L.203',
      'aktor': 'Admin Jawara',
      'tanggal': '16 Oktober 2025',
    },
    {
      'no': 20,
      'deskripsi': 'Mendownload laporan keuangan',
      'aktor': 'Admin Jawara',
      'tanggal': '16 Oktober 2025',
    },
  ];

  List<Map<String, dynamic>> get currentPageData {
    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    if (endIndex > allLogData.length) endIndex = allLogData.length;
    return allLogData.sublist(startIndex, endIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Aktifitas - Semua Aktifitas'),
        backgroundColor: const Color(0xFF2C3E50),
        foregroundColor: Colors.white,
      ),
      drawer: const Sidebar(),
      body: Container(
        color: const Color(0xFFF1F5F9),
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1000),
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
                    child: SizedBox(
                      width: 920, 
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          columnSpacing: 20,
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
                                width: 450,
                                child: Text('DESKRIPSI'),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 150,
                                child: Text('AKTOR'),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 180,
                                child: Text('TANGGAL'),
                              ),
                            ),
                          ],
                          rows: currentPageData.map((item) {
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
                                    width: 450,
                                    child: Text(
                                      item['deskripsi'],
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF1E293B),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  SizedBox(
                                    width: 150,
                                    child: Text(
                                      item['aktor'],
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  SizedBox(
                                    width: 180,
                                    child: Text(
                                      item['tanggal'],
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
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

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentPage = 1;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: currentPage == 1 ? const Color(0xFF6366F1) : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '1',
                            style: TextStyle(
                              color: currentPage == 1 ? Colors.white : const Color(0xFF64748B),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentPage = 2;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: currentPage == 2 ? const Color(0xFF6366F1) : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '2',
                            style: TextStyle(
                              color: currentPage == 2 ? Colors.white : const Color(0xFF64748B),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
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