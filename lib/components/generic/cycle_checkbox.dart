import 'package:flutter/material.dart';

class CycleCheckbox extends StatefulWidget {
  final List<Widget> symbols;
  final void Function(int) onChangedIndex;
  final int initialIndex;

  const CycleCheckbox({
    super.key,
    required this.symbols,
    this.initialIndex = 0,
    required this.onChangedIndex,
  });

  @override
  CycleCheckboxState createState() => CycleCheckboxState();
}

class CycleCheckboxState extends State<CycleCheckbox> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _nextSymbol() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % widget.symbols.length;
    });
    widget.onChangedIndex(_currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _nextSymbol,
      child: SizedBox(
        width: 50,
        height: 50,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black, // Border color
              width: 1.0, // Border width
            ),
            borderRadius: BorderRadius.circular(4.0), // Optional: rounded corners
          ),
          padding: const EdgeInsets.all(10.0),
          child: Center(child: widget.symbols[_currentIndex]),
        )
      ),
    );
  }
}
