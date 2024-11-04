import 'package:character_sheet/components/generic/consumer_stateful_text_input.dart';
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
  late List<Map<String, dynamic>> _spellList;

  @override
  void initState() {
    super.initState();
    _spellList = List<Map<String, dynamic>>.from(widget.list);
  }

  void _updateParent(String key, dynamic value) {
    widget.onChange({
      'title': widget.title,
      'slots': widget.currentSlots,
      'max_slots': widget.maxSlots,
      'list': _spellList,
      key: value,
    });
  }

  void addSpell() {
    setState(() {
      _spellList.add({
        'name': widget.defaultListEntry['name'],
        'checked': widget.defaultListEntry['checked'],
      });
      _updateParent('list', _spellList);
    });
  }

  void removeSpell(int index) {
    setState(() {
      _spellList.removeAt(index);
      _updateParent('list', _spellList);
    });
  }

  void updateSpellName(int index, String name) {
    setState(() {
      _spellList[index]['name'] = name;
      _updateParent('list', _spellList);
    });
  }

  void togglePrepared(int index, bool value) {
    setState(() {
      _spellList[index]['checked'] = value;
      _updateParent('list', _spellList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Slot Fields
            Row(
              children: [
                SizedBox(
                  width: 120,
                  child: ConsumerStatefulTextInput(
                    label: 'Spell Block',
                    onChanged: (newValue) => _updateParent('title', newValue),
                    initialValue: widget.title,
                    textInputType: TextInputType.text,
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: 60,
                  child: ConsumerStatefulTextInput(
                    label: 'Slots',
                    textInputType: TextInputType.number,
                    onChanged: (newValue) => _updateParent('slots', int.tryParse(newValue) ?? 0),
                    initialValue: widget.currentSlots.toString(),
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: 60,
                  child: ConsumerStatefulTextInput(
                    label: 'Max',
                    textInputType: TextInputType.number,
                    onChanged: (newValue) => _updateParent('max_slots', int.tryParse(newValue) ?? 0),
                    initialValue: widget.maxSlots.toString(),
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
