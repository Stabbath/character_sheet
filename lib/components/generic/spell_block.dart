import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'single_spell_input.dart';

class SpellBlockWidget extends ConsumerStatefulWidget {
  final String title;
  final int currentSlots;
  final int maxSlots;
  final ValueChanged<String> onTitleChanged;
  final ValueChanged<int> onCurrentSlotsChanged;
  final ValueChanged<int> onMaxSlotsChanged;

  const SpellBlockWidget({
    super.key,
    required this.title,
    required this.currentSlots,
    required this.maxSlots,
    required this.onTitleChanged,
    required this.onCurrentSlotsChanged,
    required this.onMaxSlotsChanged,
  });

  @override
  SpellBlockWidgetState createState() => SpellBlockWidgetState();
}

class SpellBlockWidgetState extends ConsumerState<SpellBlockWidget> {
  List<Map<String, dynamic>> spellList = [];

  void addSpell() {
    setState(() {
      spellList.add({"spellName": "", "isPrepared": false});
    });
  }

  void removeSpell(int index) {
    setState(() {
      spellList.removeAt(index);
    });
  }

  void updateSpellName(int index, String name) {
    setState(() {
      spellList[index]["spellName"] = name;
    });
  }

  void togglePrepared(int index, bool value) {
    setState(() {
      spellList[index]["isPrepared"] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title and Slot Fields
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(labelText: 'Spell Block'),
                controller: TextEditingController(text: widget.title),
                onChanged: widget.onTitleChanged,
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 60,
              child: TextField(
                decoration: const InputDecoration(labelText: 'Current'),
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: widget.currentSlots.toString()),
                onChanged: (value) {
                  widget.onCurrentSlotsChanged(int.tryParse(value) ?? 0);
                },
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 60,
              child: TextField(
                decoration: const InputDecoration(labelText: 'Spell Slots'),
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: widget.maxSlots.toString()),
                onChanged: (value) {
                  widget.onMaxSlotsChanged(int.tryParse(value) ?? 0);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Spell List
        for (int i = 0; i < spellList.length; i++)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: SingleSpellInput(
                spellName: spellList[i]["spellName"],
                isPrepared: spellList[i]["isPrepared"],
                onSpellNameChanged: (name) => updateSpellName(i, name),
                onPreparedChanged: (value) => togglePrepared(i, value),
                onRemove: () => removeSpell(i),
              ),
            ),
          ),
        const SizedBox(height: 8),
        // Add Spell Button
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed: addSpell,
                icon: const Icon(Icons.add),
                label: const Text('Add Spell'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
