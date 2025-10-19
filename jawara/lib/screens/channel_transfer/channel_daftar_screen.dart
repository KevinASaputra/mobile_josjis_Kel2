import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'channel_detail_screen.dart';
import 'channel_edit_screen.dart';

class ChannelDaftarScreen extends StatelessWidget {
  const ChannelDaftarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF635BFF);
    const Color bgColor = Color(0xFFF5F7FB);

    final List<Map<String, String>> data = [
      {
        'no': '1',
        'nama': '234234',
        'tipe': 'ewallet',
        'an': '23234',
        'thumbnail': '-',
      },
      {
        'no': '2',
        'nama': 'Transfer via BCA',
        'tipe': 'bank',
        'an': 'RT Jawara Karangploso',
        'thumbnail': '-',
      },
      {
        'no': '3',
        'nama': 'Gopay Ketua RT',
        'tipe': 'ewallet',
        'an': 'Budi Santoso',
        'thumbnail': '-',
      },
      {
        'no': '4',
        'nama': 'QRIS Resmi RT 08',
        'tipe': 'qris',
        'an': 'RW 08 Karangploso',
        'thumbnail': '-',
      },
    ];

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          'Daftar Channel',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        backgroundColor: bgColor,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 700;

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: isMobile ? double.infinity : 950,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // === TABEL ===
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: DataTable(
                        headingTextStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                        dataTextStyle: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                        columnSpacing: isMobile ? 24 : 48,
                        columns: const [
                          DataColumn(label: Text('NO')),
                          DataColumn(label: Text('NAMA')),
                          DataColumn(label: Text('TIPE')),
                          DataColumn(label: Text('A/N')),
                          DataColumn(label: Text('THUMBNAIL')),
                          DataColumn(label: Text('AKSI')),
                        ],
                        rows: data.map((item) {
                          return DataRow(
                            cells: [
                              DataCell(Text(item['no']!)),
                              DataCell(Text(item['nama']!)),
                              DataCell(Text(item['tipe']!)),
                              DataCell(Text(item['an']!)),
                              DataCell(Text(item['thumbnail']!)),
                              DataCell(_buildPopupMenu(context, item)),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // === PAGINATION ===
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _paginationButton(
                          Icons.arrow_back_ios_new,
                          enabled: false,
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '1',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        _paginationButton(
                          Icons.arrow_forward_ios,
                          enabled: true,
                        ),
                      ],
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

  // === POPUP MENU (⋯) ===
  static Widget _buildPopupMenu(
    BuildContext context,
    Map<String, String> channelData,
  ) {
    return PopupMenuButton<String>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onSelected: (value) {
        if (value == 'detail') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ChannelDetailScreen(channelData: channelData),
            ),
          );
        } else if (value == 'edit') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChannelEditScreen(channelData: channelData),
            ),
          );
        } else if (value == 'hapus') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Channel dihapus!"),
              backgroundColor: Colors.red.shade600,
              behavior: SnackBarBehavior.floating,
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
        PopupMenuItem(
          value: 'hapus',
          child: Text('Hapus', style: GoogleFonts.inter(color: Colors.red)),
        ),
      ],
      icon: const Icon(Icons.more_horiz),
    );
  }

  // === PAGINATION BUTTON ===
  static Widget _paginationButton(IconData icon, {required bool enabled}) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: enabled ? Colors.white : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        icon,
        size: 18,
        color: enabled ? Colors.black87 : Colors.grey,
      ),
    );
  }
}
