import 'package:flutter/material.dart';

class DateIntervalCalculatorPage extends StatefulWidget {
  @override
  _DateIntervalCalculatorPageState createState() =>
      _DateIntervalCalculatorPageState();
}

class _DateIntervalCalculatorPageState
    extends State<DateIntervalCalculatorPage> {
  DateTime? fromDate;
  DateTime? toDate;
  int? years, months, days;

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != fromDate) {
      setState(() {
        fromDate = picked;
        _calculateDateDifference();
      });
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != toDate) {
      setState(() {
        toDate = picked;
        _calculateDateDifference();
      });
    }
  }

  void _calculateDateDifference() {
    if (fromDate != null && toDate != null) {
      final difference = toDate!.difference(fromDate!);

      // Menghitung tahun, bulan, dan hari secara akurat
      int totalDays = difference.inDays;
      years = totalDays ~/ 365;
      totalDays %= 365; // Menghitung sisa hari setelah mengurangi tahun penuh

      months = totalDays ~/
          30; // Menghitung bulan dengan asumsi rata-rata 30 hari per bulan
      totalDays %= 30; // Sisa hari setelah bulan penuh

      days = totalDays; // Sisa hari
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Date Interval Calculator",
            style: TextStyle(color: Color(0xFF6E3482))),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman dashboard
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Baris pertama dengan tanggal awal dan akhir di bawah satu sama lain
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tanggal Awal
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("From: ",
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                      ElevatedButton(
                        onPressed: () => _selectFromDate(context),
                        child: Text(fromDate == null
                            ? 'Pilih Tanggal Awal'
                            : '${fromDate!.toLocal()}'.split(' ')[0]),
                      ),
                    ],
                  ),
                ),
                // Tanggal Akhir
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("To: ",
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                    ElevatedButton(
                      onPressed: () => _selectToDate(context),
                      child: Text(toDate == null
                          ? 'Pilih Tanggal Akhir'
                          : '${toDate!.toLocal()}'.split(' ')[0]),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            // Garis pembatas antara "Difference" dan bagian "From/To"
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            SizedBox(height: 10),
            // Menampilkan hasil perhitungan selisih tanggal
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white, // background menjadi putih
                  boxShadow: [
                    // menambahkan sedikit bayangan untuk desain
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3), // posisi bayangan
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "Difference",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6E3482),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Years",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            SizedBox(height: 5),
                            Text(
                              years?.toString() ?? '0',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Column(
                          children: [
                            Text(
                              "Months",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            SizedBox(height: 5),
                            Text(
                              months?.toString() ?? '0',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Column(
                          children: [
                            Text(
                              "Days",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            SizedBox(height: 5),
                            Text(
                              days?.toString() ?? '0',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Tampilkan From dan To dengan tanggal yang dipilih atau tanggal saat ini
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "From: ${fromDate?.toLocal().toString().split(' ')[0] ?? DateTime.now().toLocal().toString().split(' ')[0]}",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          "To: ${toDate?.toLocal().toString().split(' ')[0] ?? DateTime.now().toLocal().toString().split(' ')[0]}",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
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
