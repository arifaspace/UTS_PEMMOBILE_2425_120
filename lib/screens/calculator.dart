import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';
import 'dashboard.dart'; // Pastikan import halaman dashboard yang sesuai

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _input = '';
  String _result = '';

  void _onPressed(String value) {
    setState(() {
      if (value == 'C') {
        _input = '';
        _result = '';
      } else if (value == '=') {
        _calculateResult();
      } else if (value == '%') {
        _input += '/100'; // Mengubah % menjadi /100 dalam ekspresi
      } else {
        _input += value;
      }
    });
  }

  void _calculateResult() {
    try {
      // Preprocessing: Ganti '×' dengan '*' dan '÷' dengan '/'
      String processedInput = _input
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('%', '/100'); // Persentase sebagai pembagian 100

      final expression = Expression.parse(processedInput);
      final evaluator = ExpressionEvaluator();
      final result = evaluator.eval(expression, {});

      setState(() {
        _result = result.toString();
      });
    } catch (e) {
      setState(() {
        _result = 'Error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang putih
      appBar: AppBar(
        backgroundColor: Colors.white, // Bagian atas menjadi putih
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Mengarahkan kembali ke halaman dashboard
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DashboardPage()), // Sesuaikan dengan halaman DashboardPage Anda
            );
          },
        ),
        title: const Text(
          'Calculator',
          style: TextStyle(
            fontFamily: 'Pop', // Menggunakan font Pop (Poppins)
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Tampilan input
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              _input,
              style: const TextStyle(
                fontFamily: 'Pop', // Menggunakan font Pop (Poppins)
                fontSize: 36,
                color: Colors.black, // Warna teks hitam
              ),
            ),
          ),
          // Tampilan hasil
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              _result,
              style: const TextStyle(
                fontFamily: 'Pop', // Menggunakan font Pop (Poppins)
                fontSize: 48,
                color: Colors.black, // Warna teks hitam
              ),
            ),
          ),
          const Divider(color: Colors.grey),
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    final List<String> buttons = [
      'C',
      '(',
      ')',
      '%',
      '7',
      '8',
      '9',
      '÷',
      '4',
      '5',
      '6',
      '×',
      '1',
      '2',
      '3',
      '-',
      '0',
      '.',
      '=',
      '+',
    ];

    return GridView.builder(
      shrinkWrap: true,
      itemCount: buttons.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.2,
      ),
      itemBuilder: (context, index) {
        return ElevatedButton(
          onPressed: () => _onPressed(buttons[index]),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, // Latar belakang tombol putih
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(10),
          ),
          child: Text(
            buttons[index],
            style: const TextStyle(
              fontFamily: 'Pop', // Menggunakan font Pop (Poppins)
              fontSize: 24,
              color: Colors.black, // Warna teks tombol hitam
            ),
          ),
        );
      },
    );
  }
}
