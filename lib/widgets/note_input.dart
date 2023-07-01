import 'package:flutter/material.dart';

class NoteInput extends StatefulWidget {
  final Function(String) onChangeNote;

  const NoteInput({super.key, required this.onChangeNote});

  @override
  _NoteInputState createState() => _NoteInputState();
}

class _NoteInputState extends State<NoteInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _controller,
        decoration: const InputDecoration(labelText: 'Note'),
        onChanged: widget.onChangeNote,
      ),
    );
  }
}
