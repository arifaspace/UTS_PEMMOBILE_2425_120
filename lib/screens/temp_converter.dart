import 'package:flutter/material.dart';

class TemperatureConverterPage extends StatefulWidget {
  @override
  _TemperatureConverterPageState createState() =>
      _TemperatureConverterPageState();
}

class _TemperatureConverterPageState extends State<TemperatureConverterPage> {
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController resultController = TextEditingController();
  String fromUnit = "Celsius";
  String toUnit = "Fahrenheit";
  bool isLoading = false;

  final List<String> units = ["Celsius", "Fahrenheit", "Kelvin", "Réaumur"];

  void _convertTemperature() {
    setState(() {
      isLoading = true;
    });

    double inputTemperature = double.parse(temperatureController.text);
    double result;

    // Konversi berdasarkan unit suhu yang dipilih
    if (fromUnit == "Celsius" && toUnit == "Fahrenheit") {
      result = (inputTemperature * 9 / 5) + 32;
    } else if (fromUnit == "Celsius" && toUnit == "Kelvin") {
      result = inputTemperature + 273.15;
    } else if (fromUnit == "Celsius" && toUnit == "Réaumur") {
      result = inputTemperature * 4 / 5;
    } else if (fromUnit == "Fahrenheit" && toUnit == "Celsius") {
      result = (inputTemperature - 32) * 5 / 9;
    } else if (fromUnit == "Fahrenheit" && toUnit == "Kelvin") {
      result = (inputTemperature - 32) * 5 / 9 + 273.15;
    } else if (fromUnit == "Fahrenheit" && toUnit == "Réaumur") {
      result = (inputTemperature - 32) * 4 / 9;
    } else if (fromUnit == "Kelvin" && toUnit == "Celsius") {
      result = inputTemperature - 273.15;
    } else if (fromUnit == "Kelvin" && toUnit == "Fahrenheit") {
      result = (inputTemperature - 273.15) * 9 / 5 + 32;
    } else if (fromUnit == "Kelvin" && toUnit == "Réaumur") {
      result = (inputTemperature - 273.15) * 4 / 5;
    } else if (fromUnit == "Réaumur" && toUnit == "Celsius") {
      result = inputTemperature * 5 / 4;
    } else if (fromUnit == "Réaumur" && toUnit == "Fahrenheit") {
      result = (inputTemperature * 9 / 4) + 32;
    } else if (fromUnit == "Réaumur" && toUnit == "Kelvin") {
      result = (inputTemperature * 5 / 4) + 273.15;
    } else {
      result = inputTemperature; // Jika satuannya sama
    }

    setState(() {
      resultController.text = result.toStringAsFixed(2);
      isLoading = false;
    });
  }

  void _swapUnits() {
    setState(() {
      String temp = fromUnit;
      fromUnit = toUnit;
      toUnit = temp;
      _convertTemperature(); // Update hasil konversi setelah menukar unit
    });
  }

  String _getButtonText(int index) {
    const buttonText = [
      '7', '8', '9', 'C', // baris pertama
      '4', '5', '6', '←', // baris kedua
      '1', '2', '3', '00', // baris ketiga
      '0', '.', '+', '-' // baris keempat
    ];
    return buttonText[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Temperature Converter"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman dashboard
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Input suhu
            TextField(
              controller: temperatureController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: "Masukkan suhu",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            // Dropdown untuk memilih unit suhu dari dan ke
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: fromUnit,
                  onChanged: (String? newValue) {
                    setState(() {
                      fromUnit = newValue!;
                    });
                  },
                  items: units.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                IconButton(
                  icon: Icon(Icons.swap_horiz),
                  onPressed: _swapUnits, // Tombol untuk menukar satuan
                ),
                DropdownButton<String>(
                  value: toUnit,
                  onChanged: (String? newValue) {
                    setState(() {
                      toUnit = newValue!;
                    });
                  },
                  items: units.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 16),
            // TextField untuk hasil konversi
            TextField(
              controller: resultController,
              decoration: InputDecoration(
                labelText: "Hasil Konversi",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              readOnly: true,
            ),
            SizedBox(height: 16),
            // Tombol Kalkulator
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 16,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () {
                    String buttonText = _getButtonText(index);
                    if (buttonText == 'C') {
                      temperatureController.clear(); // Clear all
                    } else if (buttonText == '←') {
                      temperatureController.text = temperatureController.text
                          .substring(
                              0,
                              temperatureController.text.length -
                                  1); // Remove 1 character
                    } else {
                      temperatureController.text += buttonText;
                    }
                    _convertTemperature(); // Memanggil konversi otomatis setelah update input
                  },
                  child: Text(
                    _getButtonText(index),
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Background color white
                    foregroundColor: Colors.black, // Text color black
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
