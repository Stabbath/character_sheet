import 'package:flutter/material.dart';

class StaticStatInput extends StatelessWidget {
  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  const StaticStatInput({super.key, required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label),
        SizedBox(
          width: 50,
          height: 50,
          child: TextFormField(
            initialValue: value.toString(),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(8.0),
            ),
            onChanged: (newValue) {
              onChanged(int.tryParse(newValue) ?? value);
            },
          ),
        ),
      ],
    );
  }
}


