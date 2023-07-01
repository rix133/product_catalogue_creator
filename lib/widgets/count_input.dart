import 'package:flutter/material.dart';

class CountInput extends StatefulWidget {
  final Function(String) onChangeCount;

  const CountInput({Key? key, required this.onChangeCount}) : super(key: key);

  @override
  CountInputState createState() => CountInputState();
}

class CountInputState extends State<CountInput> {
  final TextEditingController _controller = TextEditingController(text:"1");

  void reset() {
    _controller.text = "1";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _controller,
        decoration: const InputDecoration(labelText: 'Count'),
        keyboardType: TextInputType.number,
        onChanged: widget.onChangeCount,
      ),
    );
  }
}
