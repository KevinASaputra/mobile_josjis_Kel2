import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pengguna_detail_screen.dart';
import 'pengguna_edit_screen.dart';
import '../../widgets/dashboard_layout.dart';

class PenggunaDaftarScreen extends StatefulWidget {
  const PenggunaDaftarScreen({super.key});

  @override
  State<PenggunaDaftarScreen> createState() => _PenggunaDaftarScreenState();
}

class _PenggunaDaftarScreenState extends State<PenggunaDaftarScreen> {
  final Color primaryColor = const Color(0xFF635BFF);

  final List<Map<String, String>> data = [
    {
      'no': '1',
      'nama': 'mimin',
      'jabatan': 'Ketua RW',
      'nik': '3201234567890123',
      'email': 'mimin@gmail.com',
      'noHp': '08123456789',
      'jenisKelamin': 'Laki-laki',
      'status': 'Diterima',
    },
    {
      'no': '2',
      'nama': 'Farhan',
      'jabatan': 'Sekretaris',
      'nik': '3201234567890124',
      'email': 'farhan@gmail.com',
      'noHp': '08123456788',
      'jenisKelamin': 'Laki-laki',
      'status': 'Diterima',
    },
    {
      'no': '3',
      'nama': 'dewqedwdw',
      'jabatan': 'Bendahara',
      'nik': '3201234567890125',
      'email': 'admiwewen1@gmail.com',
      'noHp': '08123456787',
      'jenisKelamin': 'Perempuan',
      'status': 'Pending',
    },
    {
      'no': '4',
      'nama': 'Rendha Putra Rahmadya',
      'jabatan': 'Ketua RT',
      'nik': '3201234567890126',
      'email': 'rendhazuper@gmail.com',
      'noHp': '08123456786',
      'jenisKelamin': 'Laki-laki',
      'status': 'Ditolak',
    },
    {
      'no': '5',
      'nama': 'bla',
      'jabatan': 'Warga',
      'nik': '3201234567890127',
      'email': 'y@gmail.com',
      'noHp': '08123456785',
      'jenisKelamin': 'Perempuan',
      'status': 'Diterima',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      title: 'Daftar Pengguna',
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 700;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Container(
                width: isMobile ? null : 950,
                constraints: isMobile
                    ? null
                    : const BoxConstraints(maxWidth: 950),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: isMobile
                          ? Alignment.center
                          : Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => _buildFilterDialog(context),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 18,
                          ),
                          elevation: 0,
                        ),
                        child: const Icon(
                          Icons.filter_list,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // === TABEL DATA ===
                    SizedBox(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: isMobile
                                ? constraints.maxWidth - 64
                                : 800,
                          ),
                          child: DataTable(
                            headingTextStyle: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                            dataTextStyle: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                            columnSpacing: isMobile ? 16 : 32,
                            horizontalMargin: 8,
                            columns: const [
                              DataColumn(label: Text('NO')),
                              DataColumn(label: Text('NAMA')),
                              DataColumn(label: Text('EMAIL')),
                              DataColumn(label: Text('STATUS REGISTRASI')),
                              DataColumn(label: Text('AKSI')),
                            ],
                            rows: data.map((item) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(item['no']!)),
                                  DataCell(Text(item['nama']!)),
                                  DataCell(Text(item['email']!)),
                                  DataCell(_buildStatusBadge(item['status']!)),
                                  DataCell(_buildPopupMenu(context, item)),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ==========================================================
  // ===============  FILTER DIALOG (POPUP) ===================
  // ==========================================================
  Widget _buildFilterDialog(BuildContext context) {
    final TextEditingController namaController = TextEditingController();
    String? selectedStatus;

    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            'Filter Manajemen Pengguna',
            style: GoogleFonts.inter(fontWeight: FontWeight.w600),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nama',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: namaController,
                  decoration: InputDecoration(
                    hintText: 'Cari nama...',
                    hintStyle: GoogleFonts.inter(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Status',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  initialValue: selectedStatus,
                  items: ['Diterima', 'Pending', 'Ditolak']
                      .map(
                        (status) => DropdownMenuItem<String>(
                          value: status,
                          child: Text(status, style: GoogleFonts.inter()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: '-- Pilih Status --',
                    hintStyle: GoogleFonts.inter(color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                namaController.clear();
                setState(() => selectedStatus = null);
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                backgroundColor: Colors.grey.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Reset Filter',
                style: GoogleFonts.inter(color: Colors.black87),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Terapkan',
                style: GoogleFonts.inter(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // ================  STATUS BADGE WIDGET ====================
  // ==========================================================
  static Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case 'Pending':
        bgColor = Colors.orange.shade100;
        textColor = Colors.orange.shade700;
        break;
      case 'Ditolak':
        bgColor = Colors.red.shade100;
        textColor = Colors.red.shade700;
        break;
      default:
        bgColor = Colors.green.shade100;
        textColor = Colors.green.shade700;
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  // ==========================================================
  // ===================  AKSI POPUP MENU =====================
  // ==========================================================
  static Widget _buildPopupMenu(
    BuildContext context,
    Map<String, String> item,
  ) {
    return PopupMenuButton<String>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onSelected: (value) {
        if (value == 'detail') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PenggunaDetailScreen(
                nama: item['nama'] ?? '',
                jabatan: item['jabatan'] ?? '',
                nik: item['nik'] ?? '',
                email: item['email'] ?? '',
                noHp: item['noHp'] ?? '',
                jenisKelamin: item['jenisKelamin'] ?? '',
                status: item['status'] ?? '',
              ),
            ),
          );
        } else if (value == 'edit') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PenggunaEditScreen(
                nama: item['nama'] ?? '',
                email: item['email'] ?? '',
                noHp: item['noHp'] ?? '',
                jabatan: item['jabatan'] ?? '',
              ),
            ),
          );
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'detail',
          child: Text('Detail', style: GoogleFonts.inter()),
        ),
        PopupMenuItem(
          value: 'edit',
          child: Text('Edit', style: GoogleFonts.inter()),
        ),
      ],
      icon: const Icon(Icons.more_horiz),
    );
  }
}
