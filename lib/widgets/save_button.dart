import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';


import 'book_list.dart';

class SaveButton extends StatelessWidget {
  final List<Book> books;

  const SaveButton({super.key, required this.books});

  Future<void> _saveToCsv(BuildContext context) async {
    final List<List<dynamic>> rows = [
      ['barcode',  'count','location', 'timestamp', 'note'],
      ...books.map((book) => [book.barcode, book.count, book.location,
        DateFormat('M/d/yyyy H:mm').format(book.timestamp), book.note]),
    ];

    final String csv = const ListToCsvConverter().convert(rows);

    final Directory directory = await getTemporaryDirectory();
      final String filePath = '${directory.path}/books.csv';
      final File file = File(filePath);

      await file.writeAsString(csv);

      if (file.existsSync()) {
        final XFile xFile = XFile(filePath, mimeType: 'text/csv');
        Share.shareXFiles([xFile]);
      }


  }


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100)
          )
      ),
      onPressed: () => _saveToCsv(context),
      child: const Icon(Icons.save),
    );

  }
}
