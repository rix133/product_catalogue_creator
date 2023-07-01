import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../widgets/location_input.dart';
import '../widgets/book_list.dart';
import '../widgets/scan_button.dart';
import '../widgets/save_button.dart';
import '../widgets/note_input.dart';
import '../widgets/count_input.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _location = '';
  String _note = '';
  String _count = '1';
  List<Book> _books = [];

  final GlobalKey<CountInputState> _countInputKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  void _loadBooks() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/books.json');
    if (await file.exists()) {
      final booksJson = jsonDecode(await file.readAsString());
      setState(() {
        _books = booksJson
            .map<Book>((book) => Book(
          barcode: book['barcode'],
          location: book['location'],
          timestamp: DateTime.parse(book['timestamp']),
          count: book['count'],
          note: book['note'],
        ))
            .toList();
      });
    }
  }

  void _saveBooks() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/books.json');
    await file.writeAsString(jsonEncode(_books));
  }

  void _changeLocation(String location) {
    setState(() {
      _location = location;
    });
  }

  void _changeCount(String count) {
    setState(() {
      _count = count;
    });
  }

  void _addBook(String barcode) {
    setState(() {
      _books.insert(
          0,
          Book(
              barcode: barcode,
              location: _location,
              timestamp: DateTime.now(),
              note: _note,
              count: _count
          )
      );
      _saveBooks();
      _countInputKey.currentState?.reset();

    });
  }


  void _clearBooks() {
    setState(() {
      _books.clear();
      _saveBooks();
    });
  }

  void _deleteBook(int index) {
    setState(() {
      _books.removeAt(index);
      _saveBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Scanner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Clear books?'),
                content:
                const Text('Are you sure you want to clear the book list?'),
                actions: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  TextButton(
                    child: const Text('Clear'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _clearBooks();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          LocationInput(onChangeLocation: _changeLocation),
          CountInput(key: _countInputKey, onChangeCount: _changeCount),
          NoteInput(onChangeNote: (note) => setState(() => _note = note)),
          ScanButton(onAddBook: _addBook),
          BookList(books: _books, onDeleteBook: _deleteBook),
          const SizedBox(height: 15),
          SaveButton(books: _books),
        ],
      ),
    );
  }
}
