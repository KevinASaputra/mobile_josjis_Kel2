import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  Map<String, bool> _expandedSections = {
    'Dashboard': false,
    'Laporan Keuangan': false,
    'Data Warga & Rumah': false,
    'Kegiatan & Broadcast': false,
    'Penerimaan Warga': false,
    'Mutasi Keluarga': false,
    'Manajemen Pengguna': false,
    'Channel Transfer': false,
    'Log Aktifitas': false,
  };

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF2C3E50)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'Jawara Pintar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
              ],
            ),
          ),
          // Dashboard Section
          ExpansionTile(
            title: Text(
              'Dashboard',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            leading: Icon(Icons.dashboard, size: 20),
            children: [
              _buildNavItem(
                context,
                'Keuangan',
                '/dashboard/keuangan',
                Icons.monetization_on,
                indent: 16,
              ),
              _buildNavItem(
                context,
                'Kegiatan',
                '/dashboard/kegiatan',
                Icons.event,
                indent: 16,
              ),
              _buildNavItem(
                context,
                'Kependudukan',
                '/dashboard/kependudukan',
                Icons.people,
                indent: 16,
              ),
            ],
          ),

          const Divider(),

          // Data Warga & Rumah Section
          ExpansionTile(
            title: Text(
              'Data Warga & Rumah',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            leading: Icon(Icons.people_outline, size: 20),
            children: [
              _buildNavItem(
                context,
                'Daftar Warga',
                '/warga/daftar',
                Icons.person_outline,
                indent: 16,
              ),
              _buildNavItem(
                context,
                'Tambah Warga',
                '/warga/tambah',
                Icons.person_add,
                indent: 16,
              ),
              _buildNavItem(
                context,
                'Keluarga',
                '/warga/keluarga',
                Icons.family_restroom,
                indent: 16,
              ),
              _buildNavItem(
                context,
                'Daftar Rumah',
                '/rumah/daftar',
                Icons.home_outlined,
                indent: 16,
              ),
              _buildNavItem(
                context,
                'Tambah Rumah',
                '/rumah/tambah',
                Icons.add_home,
                indent: 16,
              ),
            ],
          ),

          const Divider(),

          // Pengeluaran Section
          ExpansionTile(
            title: Text(
              'Pengeluaran',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            leading: Icon(Icons.money_off, size: 20),
            children: [
              _buildNavItem(
                context,
                'Daftar Pengeluaran',
                '/pengeluaran/daftar',
                Icons.list_alt,
                indent: 16,
              ),
              _buildNavItem(
                context,
                'Tambah Pengeluaran',
                '/pengeluaran/tambah',
                Icons.add_circle_outline,
                indent: 16,
              ),
            ],
          ),

          const Divider(),

          // Laporan Keuangan Section
          ExpansionTile(
            title: Text(
              'Laporan Keuangan',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            leading: Icon(Icons.receipt_long, size: 20),
            children: [
              _buildNavItem(
                context,
                'Semua Pemasukan',
                '/laporan-keuangan/pemasukan',
                Icons.monetization_on,
                indent: 16,
              ),
              _buildNavItem(
                context,
                'Semua Pengeluaran',
                '/laporan-keuangan/pengeluaran',
                Icons.money_off,
                indent: 16,
              ),
              _buildNavItem(
                context,
                'Cetak Laporan',
                '/laporan-keuangan/cetak',
                Icons.print,
                indent: 16,
              ),
            ],
          ),

          const Divider(),

          // Kegiatan & Broadcast Section
          ExpansionTile(
            title: Text(
              'Kegiatan & Broadcast',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            leading: Icon(Icons.event_note, size: 20),
            children: [
              _buildNavItem(
                context,
                'Kegiatan - Daftar',
                '/kegiatan/daftar',
                Icons.list_alt,
                indent: 16,
              ),
              _buildNavItem(
                context,
                'Kegiatan - Tambah',
                '/kegiatan/tambah',
                Icons.add_circle_outline,
                indent: 16,
              ),
              _buildNavItem(
                context,
                'Broadcast - Daftar',
                '/broadcast/daftar',
                Icons.broadcast_on_personal,
                indent: 16,
              ),
              _buildNavItem(
                context,
                'Broadcast - Tambah',
                '/broadcast/tambah',
                Icons.add_box,
                indent: 16,
              ),
            ],
          ),

          const Divider(),

          // Penerimaan Warga Section
          ExpansionTile(
            title: Text(
              'Penerimaan Warga',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            leading: Icon(Icons.person_add, size: 20),
            children: [
              _buildNavItem(
                context,
                'Penerimaan Warga',
                '/penerimaan-warga/daftar',
                Icons.list_alt,
                indent: 16,
              ),
            ],
          ),

          const Divider(),

          // Mutasi Keluarga Section
          ExpansionTile(
            title: Text(
              'Mutasi Keluarga',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            leading: Icon(Icons.swap_horiz, size: 20),
            children: [
              _buildNavItem(
                context,
                'Daftar',
                '/mutasi-keluarga/daftar',
                Icons.list,
                indent: 16,
              ),
              _buildNavItem(
                context,
                'Tambah',
                '/mutasi-keluarga/tambah',
                Icons.add,
                indent: 16,
              ),
            ],
          ),

          const Divider(),

          ExpansionTile(
            title: Text(
              'Log Aktifitas',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            leading: Icon(Icons.history, size: 20),
            children: [
              _buildNavItem(
                context,
                'Semua Aktifitas',
                '/log/aktifitas',
                Icons.list,
                indent: 16,
              ),
            ],
          ),

          const Divider(),

          // Manajemen Pengguna Section
          ExpansionTile(
            title: Text(
              'Manajemen Pengguna',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            leading: Icon(Icons.manage_accounts, size: 20),
            children: [
              _buildNavItem(
                context,
                'Pengguna - Daftar',
                '/manajemen-pengguna/daftar',
                Icons.list_alt,
                indent: 16,
              ),
              _buildNavItem(
                context,
                'Pengguna - Tambah',
                '/manajemen-pengguna/tambah',
                Icons.person_add,
                indent: 16,
              ),
            ],
          ),

          const Divider(),

          // Channel Transfer Section
          ExpansionTile(
            title: Text(
              'Channel Transfer',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            leading: Icon(Icons.transfer_within_a_station, size: 20),
            children: [
              _buildNavItem(
                context,
                'Channel - Daftar',
                '/channel-transfer/daftar',
                Icons.list_alt,
                indent: 16,
              ),
              _buildNavItem(
                context,
                'Channel - Tambah',
                '/channel-transfer/tambah',
                Icons.add_box,
                indent: 16,
              ),
            ],
          ),

          // Add other expandable sections...
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    String title,
    String route,
    IconData icon, {
    double indent = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: indent),
      child: ListTile(
        leading: Icon(icon, size: 20, color: Colors.black),
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
        onTap: () {
          Navigator.of(context).pushReplacementNamed(route);
        },
        dense: true,
      ),
    );
  }
}
