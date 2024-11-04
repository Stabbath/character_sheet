import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'single_spell_input.dart';

class SpellBlockWidget extends ConsumerStatefulWidget {
  final String title;
  final int currentSlots;
  final int maxSlots;
  final List<Map<String, dynamic>> list;
  final Map<String, dynamic> defaultListEntry;
  final ValueChanged<Map<String, dynamic>> onChange;

  const SpellBlockWidget({
    super.key,
    required this.title,
    required this.currentSlots,
    required this.maxSlots,
    required this.list,
    required this.defaultListEntry,
    required this.onChange,
  });

  @override
  SpellBlockWidgetState createState() => SpellBlockWidgetState();
}

class SpellBlockWidgetState extends ConsumerState<SpellBlockWidget> {
  late TextEditingController _titleController;
  late TextEditingController _currentSlotsController;
  late TextEditingController _maxSlotsController;
  late List<Map<String, dynamic>> _spellList;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _currentSlotsController = TextEditingController(text: widget.currentSlots.toString());
    _maxSlotsController = TextEditingController(text: widget.maxSlots.toString());
    _spellList = List<Map<String, dynamic>>.from(widget.list);
  }

  void _updateParent() {
    widget.onChange({
      'title': _titleController.text,
      'slots': int.tryParse(_currentSlotsController.text) ?? 0,
      'max_slots': int.tryParse(_maxSlotsController.text) ?? 0,
      'list': _spellList,
    });
  }

  void addSpell() {
    setState(() {
      _spellList.add({
        'name': widget.defaultListEntry['name'],
        'checked': widget.defaultListEntry['checked'],
      });
      _updateParent();
    });
  }

  void removeSpell(int index) {
    setState(() {
      _spellList.removeAt(index);
      _updateParent();
    });
  }

  void updateSpellName(int index, String name) {
    setState(() {
      _spellList[index]['name'] = name;
      _updateParent();
    });
  }

  void togglePrepared(int index, bool value) {
    setState(() {
      _spellList[index]['checked'] = value;
      _updateParent();
    });
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Slot Fields
            Row(
              children: [
                SizedBox(
                  width: 120,
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Spell Block'),
                    controller: _titleController,
                    onChanged: (_) => _updateParent(),
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: 60,
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Current'),
                    keyboardType: TextInputType.number,
                    controller: _currentSlotsController,
                    onChanged: (_) => _updateParent(),
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: 60,
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Max Slots'),
                    keyboardType: TextInputType.number,
                    controller: _maxSlotsController,
                    onChanged: (_) => _updateParent(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Spell List
            ...List.generate(_spellList.length, (index) {
              final spell = _spellList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: SingleSpellInput(
                  spellName: spell['name'],
                  isPrepared: spell['checked'],
                  onSpellNameChanged: (name) => updateSpellName(index, name),
                  onPreparedChanged: (value) => togglePrepared(index, value),
                  onRemove: () => removeSpell(index),
                ),
              );
            }),
            const SizedBox(height: 8),
            // Add Spell Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: addSpell,
                icon: const Icon(Icons.add),
                label: const Text('Add Spell'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
