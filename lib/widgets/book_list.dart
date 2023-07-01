import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Book {
  final String barcode;
  final String location;
  final String note;
  final String count;
  final DateTime timestamp;


  Book({required this.barcode, required this.location, required this.timestamp, required this.note, required this.count});

  Map<String, dynamic> toJson() => {
    'barcode': barcode,
    'location': location,
    'timestamp': timestamp.toIso8601String(),
    'count': count,
    'note': note,
  };
}

class BookList extends StatelessWidget {
  final List<Book> books;
  final Function(int) onDeleteBook;

  const BookList({super.key, required this.books, required this.onDeleteBook});

  Future<void> _searchBarcode(String barcode) async {
    final url = Uri.parse('https://www.google.com/search?q=$barcode');
    if(await canLaunchUrl(url)){
      await launchUrl(url);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) => ListTile(
          leading: IconButton(
            icon: const Icon(Icons.search, color:Colors.purpleAccent),
            onPressed: () => _searchBarcode(books[index].barcode),
          ),
          title: Text(books[index].barcode),
          subtitle:
          Text('${books[index].location} - ${DateFormat.yMMMd().format(books[index].timestamp)}'),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.red,
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Delete book?'),
                content: const Text('Are you sure you want to delete this book?'),
                actions: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  TextButton(
                    child: const Text('Delete'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      onDeleteBook(index);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
