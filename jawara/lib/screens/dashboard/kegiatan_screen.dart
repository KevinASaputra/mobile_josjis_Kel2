import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../widgets/dashboard_layout.dart';

class KegiatanScreen extends StatelessWidget {
  const KegiatanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      title: 'Dashboard Kegiatan',
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Summary Cards Row
              _buildSummaryCard(
                'Total Kegiatan',
                '1',
                Colors.blue,
                Icons.event,
                'Jumlah seluruh event yang sudah ada',
              ),
              const SizedBox(height: 24),

              // Kegiatan per Kategori
              _buildChartCard(
                'Kegiatan per Kategori',
                Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              value: 100,
                              title: '',
                              color: const Color(0xFF5B8FF9),
                              radius: 80,
                            ),
                          ],
                          sectionsSpace: 0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildLegendItem(
                          'Komunitas & Sosial',
                          const Color(0xFF5B8FF9),
                        ),
                        _buildLegendItem('Kebersihan & Keamanan', Colors.green),
                        _buildLegendItem('Keagamaan', Colors.orange),
                        _buildLegendItem('Pendidikan', Colors.purple),
                        _buildLegendItem('Kesehatan & Olahraga', Colors.red),
                        _buildLegendItem('Lainnya', Colors.grey),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Kegiatan berdasarkan Waktu Card
              _buildInfoCard('Kegiatan berdasarkan Waktu', [
                InfoRow('Sudah Lewat', '1'),
                InfoRow('Hari Ini', '0'),
                InfoRow('Akan Datang', '0'),
              ], Colors.amber[100]!),
              const SizedBox(height: 24),

              // Penanggung Jawab Card
              _buildInfoCard('Penanggung Jawab Terbanyak', [
                InfoRow('Pak', '1'),
              ], Colors.purple[100]!),
              const SizedBox(height: 24),

              // Bar Chart
              _buildChartCard(
                'Kegiatan per Bulan (Tahun Ini)',
                SizedBox(
                  height: 200,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 1,
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              const titles = ['Okt'];
                              if (value.toInt() < titles.length) {
                                return Text(titles[value.toInt()]);
                              }
                              return const Text('');
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return Text(value.toStringAsFixed(2));
                            },
                            interval: 0.25,
                          ),
                        ),
                      ),
                      barGroups: [
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(
                              toY: 1,
                              color: const Color(0xFFFF69B4),
                              width: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    Color color,
    IconData icon,
    String subtitle,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartCard(String title, Widget content) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String title, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.rectangle),
        ),
        const SizedBox(width: 4),
        Text(title, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildInfoCard(
    String title,
    List<InfoRow> rows,
    Color backgroundColor,
  ) {
    return Card(
      elevation: 2,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        color: backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...rows.map(
              (row) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(row.label),
                    Text(
                      row.value,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoRow {
  final String label;
  final String value;

  InfoRow(this.label, this.value);
}
