import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class ScanButton extends StatefulWidget {
  final Function(String) onAddBook;

  ScanButton({required this.onAddBook});

  @override
  _ScanButtonState createState() => _ScanButtonState();
}

class _ScanButtonState extends State<ScanButton> {
  Future<void> _scanBarcode(BuildContext context) async {
    final barcode = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SimpleBarcodeScannerPage(),
      ),
    );
    widget.onAddBook(barcode);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Scanned barcode $barcode')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _scanBarcode(context),
      child: const Text('Scan Barcode'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      ),
    );

  }
}
