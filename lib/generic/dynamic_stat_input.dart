import 'package:flutter/material.dart';

class DynamicStatInput extends StatelessWidget {
  final String label;
  final int currentValue;
  final int maxValue;

  final ValueChanged<Map<String, int>> onChanged;

  const DynamicStatInput({super.key, required this.label, required this.currentValue, required this.maxValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: TextFormField(
                initialValue: currentValue.toString(),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(8.0),
                ),
                onChanged: (value) {
                  onChanged({
                    'currentValue': int.tryParse(value) ?? 0,
                    'maxValue': maxValue,
                  });
                },
              ),
            ),
            const Text(' / ', style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 50,
              width: 50,
              child: TextFormField(
                initialValue: maxValue.toString(),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(8.0),
                ),
                onChanged: (value) {
                  onChanged({
                    'currentValue': currentValue,
                    'maxValue': int.tryParse(value) ?? 0,
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
