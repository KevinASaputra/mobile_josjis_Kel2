import 'package:flutter/material.dart';
import '../../widgets/dashboard_layout.dart';
import 'package:fl_chart/fl_chart.dart';

class KeuanganScreen extends StatelessWidget {
  const KeuanganScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      title: 'Dashboard Keuangan',
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Summary Cards Row
              Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      'Total Pemasukan',
                      'Rp 0',
                      const Color(0xFF5B8FF9), // Light blue color
                      Icons.arrow_upward,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildSummaryCard(
                      'Total Pengeluaran',
                      'Rp 0',
                      const Color(0xFFFF6B6B), // Coral red color
                      Icons.arrow_downward,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildSummaryCard(
                      'Jumlah Transaksi',
                      '5',
                      const Color(0xFFFFB957), // Orange color
                      Icons.swap_horiz,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Monthly Income Chart
              _buildChartCard(
                'Pemasukan per Bulan',
                SizedBox(
                  height: 300,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 60,
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              const titles = ['Sep', 'Okt'];
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
                              return Text('${value.toInt()} Jt');
                            },
                            interval: 15,
                          ),
                        ),
                      ),
                      barGroups: [
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(
                              toY: 45,
                              color: const Color(
                                0xFF5B8FF9,
                              ), // Light blue for income
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 1,
                          barRods: [
                            BarChartRodData(
                              toY: 30,
                              color: const Color(
                                0xFF5B8FF9,
                              ), // Light blue for income
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Monthly Expense Chart
              _buildChartCard(
                'Pengeluaran per Bulan',
                SizedBox(
                  height: 300,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 2.2,
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              const titles = ['Sep', 'Okt'];
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
                              final labels = [
                                '0',
                                '550',
                                '1.1rb',
                                '1.6rb',
                                '2.2rb',
                              ];
                              final index = (value / 0.55).floor();
                              if (index >= 0 && index < labels.length) {
                                return Text(labels[index]);
                              }
                              return const Text('');
                            },
                            interval: 0.55,
                          ),
                        ),
                      ),
                      barGroups: [
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(
                              toY: 1.65,
                              color: const Color(
                                0xFFFF6B6B,
                              ), // Coral red for expense
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 1,
                          barRods: [
                            BarChartRodData(
                              toY: 1.1,
                              color: const Color(
                                0xFFFF6B6B,
                              ), // Coral red for expense
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Category Charts Column
              Column(
                children: [
                  // First Pie Chart
                  _buildChartCard(
                    'Pemasukan Berdasarkan Kategori',
                    Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: PieChart(
                            PieChartData(
                              sections: [
                                PieChartSectionData(
                                  value: 70,
                                  title: '',
                                  color: const Color(
                                    0xFF5B8FF9,
                                  ), // Light blue for government aid
                                  radius: 80,
                                ),
                                PieChartSectionData(
                                  value: 30,
                                  title: '',
                                  color: const Color(
                                    0xFFFFB957,
                                  ), // Orange for other income
                                  radius: 80,
                                ),
                              ],
                              sectionsSpace: 0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildLegendItem(
                              'Dana Bantuan\nPemerintah',
                              const Color(0xFF5B8FF9),
                            ),
                            const SizedBox(width: 24),
                            _buildLegendItem(
                              'Pendapatan\nLainnya',
                              const Color(0xFFFFB957),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Second Pie Chart
                  _buildChartCard(
                    'Pengeluaran Berdasarkan Kategori',
                    Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: PieChart(
                            PieChartData(
                              sections: [
                                PieChartSectionData(
                                  value: 60,
                                  title: '',
                                  color: const Color(
                                    0xFFFF6B6B,
                                  ), // Coral red for operational
                                  radius: 80,
                                ),
                                PieChartSectionData(
                                  value: 40,
                                  title: '',
                                  color: const Color(
                                    0xFFFFB957,
                                  ), // Orange for maintenance
                                  radius: 80,
                                ),
                              ],
                              sectionsSpace: 0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildLegendItem(
                              'Operasional RT/RW',
                              const Color(0xFFFF6B6B),
                            ),
                            const SizedBox(width: 24),
                            _buildLegendItem(
                              'Pemeliharaan\nFasilitas',
                              const Color(0xFFFFB957),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
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
  ) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartCard(String title, Widget chart) {
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
            chart,
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
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: Colors.black87),
        ),
      ],
    );
  }
}
