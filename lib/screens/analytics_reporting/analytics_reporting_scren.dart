import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:csv/csv.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class AnalyticsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> ordersData = [
    {"date": "2024-02-01", "orders": 120, "revenue": 5000},
    {"date": "2024-02-02", "orders": 150, "revenue": 6200},
    {"date": "2024-02-03", "orders": 100, "revenue": 4800},
    {"date": "2024-02-04", "orders": 130, "revenue": 5400},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Analytics & Reporting")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Dashboard Metrics", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

            SizedBox(height: 16),

            // Dashboard Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDashboardCard("Total Orders", "500", Color.fromARGB(208, 69, 38, 241)),
                _buildDashboardCard("Total Revenue", "\$25,000", Color.fromARGB(
                    208, 62, 246, 57)),
                _buildDashboardCard("Active Users", "1200", Color.fromARGB(
                    208, 241, 140, 38)),
              ],
            ),

            SizedBox(height: 16),

            // Graphs Section
            Expanded(
              child: Row(
                children: [
                  Expanded(child: _buildLineChart()), // Orders Trend
                  SizedBox(width: 20),
                  Expanded(child: _buildBarChart()), // Revenue Trend
                ],
              ),
            ),

            SizedBox(height: 16),

            // Export Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.download),
                  label: Text("Export CSV"),
                  onPressed: exportCSV,
                ),
                SizedBox(width: 16),
                ElevatedButton.icon(
                  icon: Icon(Icons.picture_as_pdf),
                  label: Text("Export PDF"),
                  onPressed: exportPDF,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //? Dashboard Metric Card
  Widget _buildDashboardCard(String title, String value, Color color) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(color: Colors.white, fontSize: 14)),
          SizedBox(height: 8),
          Text(value, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  //? Line Chart (Orders Trend)
  Widget _buildLineChart() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Orders Trend", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Expanded(
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: ordersData.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value["orders"].toDouble())).toList(),
                      isCurved: true,
                      color: Color.fromARGB(208, 69, 38, 241),
                      belowBarData: BarAreaData(show: true,
                          color:  Color.fromARGB(208, 62, 246, 57).withOpacity(0.3)),
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

  //? Bar Chart (Revenue Trend)
  Widget _buildBarChart() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Revenue Trend", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Expanded(
              child: BarChart(
                BarChartData(
                  barGroups: ordersData.asMap().entries.map((e) {
                    return BarChartGroupData(
                      x: e.key,
                      barRods: [BarChartRodData(fromY: e.value["revenue"].toDouble(),
                          color: Color.fromARGB(208, 62, 246, 57),

                          toY:20 )],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //? Export Data as CSV
  Future<void> exportCSV() async {
    List<List<dynamic>> csvData = [
      ["Date", "Orders", "Revenue"],
      ...ordersData.map((e) => [e["date"], e["orders"], e["revenue"]]),
    ];
    String csv = const ListToCsvConverter().convert(csvData);

    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/analytics_report.csv";
    final file = File(path);
    await file.writeAsString(csv);

    print("CSV Exported: $path");
  }

  //? Export Data as PDF
  Future<void> exportPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Table.fromTextArray(
            headers: ["Date", "Orders", "Revenue"],
            data: ordersData.map((e) => [e["date"], e["orders"], e["revenue"]]).toList(),
          );
        },
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/analytics_report.pdf";
    final file = File(path);
    await file.writeAsBytes(await pdf.save());

    print("PDF Exported: $path");
  }
}
