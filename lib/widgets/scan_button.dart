import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class ScanButton extends StatefulWidget {
  final Function(String) onAddBook;

  const ScanButton({super.key, required this.onAddBook});

  @override
  _ScanButtonState createState() => _ScanButtonState();
}

class _ScanButtonState extends State<ScanButton> {
  Future<void> _scanBarcode(BuildContext context) async {
    final navigator = Navigator.of(context); // store the Navigator
    final scaffoldMessenger = ScaffoldMessenger.of(context); // store the ScaffoldMessenger
    final barcode = await navigator.push(
      MaterialPageRoute(
        builder: (context) => const SimpleBarcodeScannerPage(),
      ),
    );
    widget.onAddBook(barcode);
    scaffoldMessenger.showSnackBar(
      SnackBar(content: Text('Scanned barcode $barcode')),
    );
  }




  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _scanBarcode(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      ),
      child: const Text('Scan Barcode'),
    );

  }
}
