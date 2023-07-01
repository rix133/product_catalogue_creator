import 'package:flutter/material.dart';

class LocationInput extends StatelessWidget {
  final Function(String) onChangeLocation;

  const LocationInput({super.key, required this.onChangeLocation});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter Location',
      ),
      onChanged: onChangeLocation,
    );
  }
}
