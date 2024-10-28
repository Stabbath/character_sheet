import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

class ConsumerStatefulTextInput extends ConsumerStatefulWidget {
  final String initialValue;
  final String? label;
  final TextInputType textInputType;
  final ValueChanged<String> onChanged;
  final int? minLines;
  final int? maxLines;
  final bool expands;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final InputBorder? border;

  const ConsumerStatefulTextInput({
    super.key,
    required this.initialValue,
    this.label,
    required this.onChanged,
    required this.textInputType,
    this.minLines,
    this.maxLines,
    this.expands = false,
    this.textAlign = TextAlign.start,
    this.border = const OutlineInputBorder(),
  }) : textAlignVertical = textAlign == TextAlign.start ? TextAlignVertical.top : TextAlignVertical.center;

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

  @override
  void didUpdateWidget(ConsumerStatefulTextInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Only update the controller if the initialValue has changed
    if (widget.initialValue != oldWidget.initialValue) {
      _controller.text = widget.initialValue;
    }
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
      keyboardType: widget.textInputType,
      onChanged: _onTextChanged,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      decoration: InputDecoration(
        labelText: widget.label,
        border: widget.border,
        contentPadding: const EdgeInsets.all(8.0),
      ),
    );
  }
}
