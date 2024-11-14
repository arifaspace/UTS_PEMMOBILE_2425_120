import 'package:flutter/material.dart';
import 'calculator.dart';
import 'currency_converter.dart';
import 'bmi_calculator.dart';
import 'temp_converter.dart';
import 'numeral_system.dart';
import 'date_calculator.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFA56ABD),
                Color(0xFFF5EBFA),
              ],
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.transparent, // Transparent for background
                ),
                child: Text(
                  'Menu Aplikasi',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildMenuTile(context, 'Kalkulator', CalculatorPage()),
              _buildMenuTile(
                  context, 'Konversi Mata Uang', CurrencyConverterPage()),
              _buildMenuTile(context, 'BMI Calculator', BMIPage()),
              _buildMenuTile(
                  context, 'Konversi Suhu', TemperatureConverterPage()),
              _buildMenuTile(
                  context, 'Sistem Bilangan', NumeralSystemConverterPage()),
              _buildMenuTile(
                  context, 'Kalkulator Tanggal', DateIntervalCalculatorPage()),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6E3482),
              Color(0xFFA56ABD),
              Color(0xFFF5EBFA),
            ],
          ),
        ),
        child: Center(
          child: Text(
            'Selamat datang di Dashboard!',
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuTile(BuildContext context, String title, Widget page) {
    return MouseRegion(
      onEnter: (_) {
        print('Hovered on $title');
      },
      onExit: (_) {
        print('Exited $title');
      },
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        tileColor: Colors.transparent,
        hoverColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      ),
    );
  }
}
