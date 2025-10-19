import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pengeluaran_detail_screen.dart';
import '../../widgets/dashboard_layout.dart';

class PengeluaranDaftarScreen extends StatelessWidget {
  const PengeluaranDaftarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF635BFF);

    final data = [
      {
        'no': '1',
        'nama': 'Arka',
        'jenis': 'Operasional RT/RW',
        'tanggal': '17 Oktober 2025',
        'nominal': 'Rp 6,00',
      },
      {
        'no': '2',
        'nama': 'adsad',
        'jenis': 'Pemeliharaan Fasilitas',
        'tanggal': '02 Oktober 2025',
        'nominal': 'Rp 2.112,00',
      },
    ];

    return DashboardLayout(
      title: 'Daftar Pengeluaran',
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 700;

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: isMobile ? double.infinity : 900,
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
                    Align(
                      alignment: isMobile
                          ? Alignment.center
                          : Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => _FilterDialog(primaryColor),
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

                    // === TABLE ===
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isMobile
                            ? constraints.maxWidth - 32
                            : double.infinity,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          headingTextStyle: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                            fontSize: isMobile ? 12 : 14,
                          ),
                          dataTextStyle: GoogleFonts.inter(
                            fontSize: isMobile ? 12 : 14,
                            color: Colors.black87,
                          ),
                          columnSpacing: isMobile ? 16 : 48,
                          horizontalMargin: isMobile ? 8 : 24,
                          columns: const [
                            DataColumn(label: Text('NO')),
                            DataColumn(label: Text('NAMA')),
                            DataColumn(label: Text('JENIS PENGELUARAN')),
                            DataColumn(label: Text('TANGGAL')),
                            DataColumn(label: Text('NOMINAL')),
                            DataColumn(label: Text('AKSI')),
                          ],
                          rows: data.map((item) {
                            return DataRow(
                              cells: [
                                DataCell(Text(item['no']!)),
                                DataCell(
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: isMobile ? 80 : 150,
                                    ),
                                    child: Text(
                                      item['nama']!,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: isMobile ? 120 : 200,
                                    ),
                                    child: Text(
                                      item['jenis']!,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    item['tanggal']!,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    item['nominal']!,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                DataCell(
                                  SizedBox(
                                    width: 40,
                                    child: Builder(
                                      builder: (BuildContext buttonContext) {
                                        return IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          icon: const Icon(
                                            Icons.more_horiz,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            final RenderBox button =
                                                buttonContext.findRenderObject()
                                                    as RenderBox;
                                            final RenderBox overlay =
                                                Navigator.of(context)
                                                        .overlay!
                                                        .context
                                                        .findRenderObject()
                                                    as RenderBox;
                                            final Offset buttonPosition = button
                                                .localToGlobal(
                                                  Offset.zero,
                                                  ancestor: overlay,
                                                );

                                            showMenu<String>(
                                              context: context,
                                              position: RelativeRect.fromLTRB(
                                                buttonPosition.dx,
                                                buttonPosition.dy +
                                                    button.size.height,
                                                buttonPosition.dx +
                                                    button.size.width,
                                                buttonPosition.dy,
                                              ),
                                              color: Colors.white,
                                              items: [
                                                PopupMenuItem<String>(
                                                  value: 'detail',
                                                  child: Text(
                                                    'Detail',
                                                    style: GoogleFonts.inter(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ).then((value) {
                                              if (value == 'detail') {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PengeluaranDetailScreen(
                                                          data: item,
                                                        ),
                                                  ),
                                                );
                                              }
                                            });
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // === PAGINATION ===
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 4,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.chevron_left),
                          color: Colors.black45,
                          padding: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(
                            minWidth: 36,
                            minHeight: 36,
                          ),
                        ),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '1',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.chevron_right),
                          color: Colors.black45,
                          padding: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(
                            minWidth: 36,
                            minHeight: 36,
                          ),
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
}

// ================= FILTER DIALOG =================
class _FilterDialog extends StatefulWidget {
  final Color primaryColor;
  const _FilterDialog(this.primaryColor);

  @override
  State<_FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<_FilterDialog> {
  final _namaController = TextEditingController();
  String? kategori;
  DateTime? dariTanggal;
  DateTime? sampaiTanggal;

  Future<void> _pickDate(BuildContext context, bool isDari) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2025, 10, 17),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isDari) {
          dariTanggal = picked;
        } else {
          sampaiTanggal = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive layout
    final screenWidth = MediaQuery.of(context).size.width;
    final isVerySmall = screenWidth < 400;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      title: Padding(
        padding: const EdgeInsets.only(left: 8, top: 8),
        child: Text(
          'Filter Pengeluaran',
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isVerySmall ? screenWidth * 0.85 : 400,
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: 'Cari nama...',
                  labelStyle: GoogleFonts.inter(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: kategori,
                items: ['Operasional RT/RW', 'Pemeliharaan Fasilitas']
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e,
                          style: GoogleFonts.inter(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                decoration: InputDecoration(
                  labelText: 'Pilih Kategori',
                  labelStyle: GoogleFonts.inter(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
                onChanged: (v) => setState(() => kategori = v),
              ),
              const SizedBox(height: 12),
              // Responsive date pickers - stack on very small screens
              isVerySmall
                  ? Column(
                      children: [
                        GestureDetector(
                          onTap: () => _pickDate(context, true),
                          child: AbsorbPointer(
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Dari Tanggal',
                                labelStyle: GoogleFonts.inter(fontSize: 14),
                                suffixIcon: const Icon(
                                  Icons.calendar_today_outlined,
                                  size: 20,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                                hintText: dariTanggal == null
                                    ? '--/--/----'
                                    : '${dariTanggal!.day}/${dariTanggal!.month}/${dariTanggal!.year}',
                                hintStyle: GoogleFonts.inter(fontSize: 14),
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
                                labelStyle: GoogleFonts.inter(fontSize: 14),
                                suffixIcon: const Icon(
                                  Icons.calendar_today_outlined,
                                  size: 20,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                                hintText: sampaiTanggal == null
                                    ? '--/--/----'
                                    : '${sampaiTanggal!.day}/${sampaiTanggal!.month}/${sampaiTanggal!.year}',
                                hintStyle: GoogleFonts.inter(fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _pickDate(context, true),
                            child: AbsorbPointer(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Dari Tanggal',
                                  labelStyle: GoogleFonts.inter(fontSize: 14),
                                  suffixIcon: const Icon(
                                    Icons.calendar_today_outlined,
                                    size: 20,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  hintText: dariTanggal == null
                                      ? '--/--/----'
                                      : '${dariTanggal!.day}/${dariTanggal!.month}/${dariTanggal!.year}',
                                  hintStyle: GoogleFonts.inter(fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _pickDate(context, false),
                            child: AbsorbPointer(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Sampai Tanggal',
                                  labelStyle: GoogleFonts.inter(fontSize: 14),
                                  suffixIcon: const Icon(
                                    Icons.calendar_today_outlined,
                                    size: 20,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  hintText: sampaiTanggal == null
                                      ? '--/--/----'
                                      : '${sampaiTanggal!.day}/${sampaiTanggal!.month}/${sampaiTanggal!.year}',
                                  hintStyle: GoogleFonts.inter(fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      actions: [
        Flexible(
          child: TextButton(
            onPressed: () {
              setState(() {
                _namaController.clear();
                kategori = null;
                dariTanggal = null;
                sampaiTanggal = null;
              });
            },
            child: Text(
              'Reset Filter',
              style: GoogleFonts.inter(color: Colors.black54, fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Flexible(
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            child: Text(
              'Terapkan',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
