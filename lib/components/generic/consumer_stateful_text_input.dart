import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

class ConsumerStatefulTextInput extends ConsumerStatefulWidget {
  final String initialValue;
  final String label;
  final bool isNumeric;
  final ValueChanged<String> onChanged;
  final int? minLines;
  final int? maxLines;
  final bool expands;

  const ConsumerStatefulTextInput({
    super.key,
    required this.initialValue,
    required this.label,
    required this.onChanged,
    required this.isNumeric,
    this.minLines,
    this.maxLines = 1,
    this.expands = false,
  });

  @override
  ConsumerStatefulTextInputState createState() => ConsumerStatefulTextInputState();
}

class ConsumerStatefulTextInputState extends ConsumerState<ConsumerStatefulTextInput> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;  
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        widget.onChanged(_controller.text);
      }
    });
  }

  void _onTextChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      widget.onChanged(value);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      expands: widget.expands,
      controller: _controller,
      focusNode: _focusNode,
      keyboardType: widget.isNumeric ? TextInputType.number : TextInputType.text,
      onChanged: _onTextChanged,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        labelText: widget.label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.all(8.0),
      ),
    );
  }
}
