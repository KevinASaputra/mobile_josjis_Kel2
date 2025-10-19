import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../widgets/dashboard_layout.dart';

class KependudukanScreen extends StatelessWidget {
  const KependudukanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      title: 'Dashboard Kependudukan',
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
                      'Total Keluarga',
                      '7',
                      const Color(0xFF5B8FF9), // Warna biru
                      Icons.family_restroom,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildSummaryCard(
                      'Total Penduduk',
                      '9',
                      const Color(0xFF52C41A), // Warna hijau
                      Icons.people,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Status Penduduk Chart
              _buildChartCard(
                'Status Penduduk',
                Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              value: 78,
                              title: '78%',
                              color: Colors.green,
                              radius: 80,
                            ),
                            PieChartSectionData(
                              value: 22,
                              title: '22%',
                              color: Colors.brown,
                              radius: 80,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildLegendItem('Aktif', Colors.green),
                        const SizedBox(width: 24),
                        _buildLegendItem('Nonaktif', Colors.brown),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Jenis Kelamin Chart
              _buildChartCard(
                'Jenis Kelamin',
                Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              value: 89,
                              title: '89%',
                              color: Colors.blue,
                              radius: 80,
                            ),
                            PieChartSectionData(
                              value: 11,
                              title: '11%',
                              color: Colors.red,
                              radius: 80,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildLegendItem('Laki-laki', Colors.blue),
                        const SizedBox(width: 24),
                        _buildLegendItem('Perempuan', Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Pekerjaan Penduduk Chart
              _buildChartCard(
                'Pekerjaan Penduduk',
                Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              value: 67,
                              title: '67%',
                              color: Colors.purple,
                              radius: 80,
                            ),
                            PieChartSectionData(
                              value: 33,
                              title: '33%',
                              color: Colors.pink,
                              radius: 80,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildLegendItem('Lainnya', Colors.purple),
                        const SizedBox(width: 24),
                        _buildLegendItem('Pelajar', Colors.pink),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Peran dalam Keluarga Chart
              _buildChartCard(
                'Peran dalam Keluarga',
                Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              value: 78,
                              title: '78%',
                              color: Colors.blue,
                              radius: 80,
                            ),
                            PieChartSectionData(
                              value: 11,
                              title: '11%',
                              color: Colors.red,
                              radius: 80,
                            ),
                            PieChartSectionData(
                              value: 11,
                              title: '11%',
                              color: Colors.green,
                              radius: 80,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildLegendItem('Kepala Keluarga', Colors.blue),
                        _buildLegendItem('Anak', Colors.red),
                        _buildLegendItem('Anggota Lain', Colors.green),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Agama Chart
              _buildChartCard(
                'Agama',
                Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              value: 67,
                              title: '67%',
                              color: Colors.blue,
                              radius: 80,
                            ),
                            PieChartSectionData(
                              value: 33,
                              title: '33%',
                              color: Colors.red,
                              radius: 80,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildLegendItem('Islam', Colors.blue),
                        const SizedBox(width: 24),
                        _buildLegendItem('Katolik', Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Pendidikan Chart
              _buildChartCard(
                'Pendidikan',
                Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              value: 100,
                              title: '100%',
                              color: Colors.grey,
                              radius: 80,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildLegendItem('Sarjana/Diploma', Colors.grey),
                  ],
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
  ) {
    return Card(
      elevation: 2,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
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
            const SizedBox(height: 8),
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
}
