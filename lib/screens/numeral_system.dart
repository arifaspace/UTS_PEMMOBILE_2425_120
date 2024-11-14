import 'package:flutter/material.dart';

class NumeralSystemConverterPage extends StatefulWidget {
  @override
  _NumeralSystemConverterPageState createState() =>
      _NumeralSystemConverterPageState();
}

class _NumeralSystemConverterPageState
    extends State<NumeralSystemConverterPage> {
  final TextEditingController inputController = TextEditingController();
  final TextEditingController resultController = TextEditingController();
  String fromBase = 'Decimal';
  String toBase = 'Binary';

  final List<String> numeralSystems = [
    'Binary',
    'Octal',
    'Decimal',
    'Hexadecimal'
  ];

  void _convertNumeralSystem() {
    String input = inputController.text;

    // Jika input kosong, hasil konversi dikosongkan dan keluar dari fungsi
    if (input.isEmpty) {
      resultController.clear();
      return;
    }

    int? number;

    try {
      // Parse input based on the selected "from" base
      switch (fromBase) {
        case 'Binary':
          number = int.parse(input, radix: 2);
          break;
        case 'Octal':
          number = int.parse(input, radix: 8);
          break;
        case 'Decimal':
          number = int.parse(input, radix: 10);
          break;
        case 'Hexadecimal':
          number = int.parse(input, radix: 16);
          break;
      }

      if (number == null) return;

      // Convert the parsed number to the selected "to" base
      switch (toBase) {
        case 'Binary':
          resultController.text = number.toRadixString(2);
          break;
        case 'Octal':
          resultController.text = number.toRadixString(8);
          break;
        case 'Decimal':
          resultController.text = number.toString();
          break;
        case 'Hexadecimal':
          resultController.text = number.toRadixString(16).toUpperCase();
          break;
      }
    } catch (e) {
      resultController.text = 'Error: Invalid input for $fromBase';
    }
  }

  void _swapBases() {
    setState(() {
      // Swap the selected bases and clear the result for a fresh calculation
      String temp = fromBase;
      fromBase = toBase;
      toBase = temp;
      resultController.clear(); // Clear result when bases are swapped
    });
  }

  String _getButtonText(int index) {
    const buttonText = [
      'C',
      '←',
      'F',
      'E',
      '7',
      '8',
      '9',
      'D',
      '4',
      '5',
      '6',
      'C',
      '1',
      '2',
      '3',
      'B',
      '00',
      '0',
      '.',
      'A'
    ];
    return buttonText[index];
  }

  @override
  void initState() {
    super.initState();
    // Listen for changes in the input field
    inputController.addListener(_convertNumeralSystem);
  }

  @override
  void dispose() {
    inputController.removeListener(_convertNumeralSystem);
    inputController.dispose();
    resultController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Numeral System Converter"),
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
          children: [
            // TextField for input number
            TextField(
              controller: inputController,
              decoration: InputDecoration(labelText: "Input Number"),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 16),
            // Dropdown for choosing the base to convert from
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: fromBase,
                  onChanged: (String? newValue) {
                    setState(() {
                      fromBase = newValue!;
                    });
                    _convertNumeralSystem();
                  },
                  items: numeralSystems.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                IconButton(
                  icon: Icon(Icons.swap_horiz),
                  onPressed: _swapBases, // Menukar basis
                ),
                DropdownButton<String>(
                  value: toBase,
                  onChanged: (String? newValue) {
                    setState(() {
                      toBase = newValue!;
                    });
                    _convertNumeralSystem();
                  },
                  items: numeralSystems.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Output textfield to show the result
            TextField(
              controller: resultController,
              decoration: InputDecoration(labelText: "Converted Result"),
              readOnly: true,
            ),
            SizedBox(height: 20),
            // Tombol Kalkulator
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 20,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () {
                    // Action sesuai dengan tombol
                    if (index == 0) {
                      inputController.clear(); // Clear all
                    } else if (index == 1) {
                      inputController.text = inputController.text.substring(
                          0,
                          inputController.text.length -
                              1); // Remove 1 character
                    } else {
                      String buttonText = _getButtonText(index);
                      inputController.text += buttonText;
                    }
                    // Memanggil konversi otomatis setelah update input
                    _convertNumeralSystem();
                  },
                  child: Text(
                    _getButtonText(index),
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Background color white
                    foregroundColor: Colors.black, // Text color black
                    padding: EdgeInsets.symmetric(vertical: 10),
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
