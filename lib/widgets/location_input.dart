import 'package:flutter/material.dart';

class LocationInput extends StatelessWidget {
  final Function(String) onChangeLocation;

  LocationInput({required this.onChangeLocation});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter Location',
      ),
      onChanged: onChangeLocation,
    );
  }
}
