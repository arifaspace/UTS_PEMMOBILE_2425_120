import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class CurrencyConverterPage extends StatefulWidget {
  @override
  _CurrencyConverterPageState createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  final TextEditingController amountController = TextEditingController();
  String fromCurrency = "USD";
  String toCurrency = "IDR";
  double conversionResult = 0.0;
  bool isLoading = false;
  Map<String, double> exchangeRates = {};
  List<String> currencies = [];

  // Fungsi untuk memuat data nilai tukar dari file JSON
  Future<void> _loadExchangeRates() async {
    final String response = await rootBundle.loadString('assets/rates.json');
    final data = json.decode(response);

    setState(() {
      exchangeRates = Map<String, double>.from(data);
      currencies = exchangeRates.keys.toList();
      fromCurrency = currencies.first;
      toCurrency = currencies.length > 1 ? currencies[1] : currencies.first;
    });
  }

  // Fungsi untuk mengkonversi mata uang
  void _convertCurrency() {
    if (exchangeRates.isEmpty) {
      _showSnackBar("Error: Nilai tukar tidak ditemukan.");
      return;
    }

    setState(() {
      isLoading = true;
    });

    double fromRate = exchangeRates[fromCurrency] ?? 1.0;
    double toRate = exchangeRates[toCurrency] ?? 1.0;
    double amount = double.tryParse(amountController.text) ?? 0.0;

    setState(() {
      conversionResult = (amount / fromRate) * toRate;
      isLoading = false;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void initState() {
    super.initState();
    _loadExchangeRates();
  }

  // Fungsi untuk menukar mata uang
  void _swapCurrencies() {
    setState(() {
      String temp = fromCurrency;
      fromCurrency = toCurrency;
      toCurrency = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Currency Converter"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: "Amount"),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: fromCurrency,
                  onChanged: (String? newValue) {
                    setState(() {
                      fromCurrency = newValue!;
                    });
                  },
                  items: currencies.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value), // Menampilkan simbol mata uang
                    );
                  }).toList(),
                ),
                IconButton(
                  icon: Icon(Icons.swap_horiz),
                  onPressed: _swapCurrencies,
                ),
                DropdownButton<String>(
                  value: toCurrency,
                  onChanged: (String? newValue) {
                    setState(() {
                      toCurrency = newValue!;
                    });
                  },
                  items: currencies.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value), // Menampilkan simbol mata uang
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: isLoading ? null : _convertCurrency,
              child: isLoading ? CircularProgressIndicator() : Text("Convert"),
            ),
            SizedBox(height: 16),
            Text(
              "Converted Result: ${conversionResult.toStringAsFixed(2)} $toCurrency",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
