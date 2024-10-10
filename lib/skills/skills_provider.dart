import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'skills_model.dart';

final skillsProvider = StateNotifierProvider<SkillsNotifier, SkillsModel>(
  (ref) => SkillsNotifier(),
);

class SkillsNotifier extends StateNotifier<SkillsModel> {
  SkillsNotifier() : super(SkillsModel());

  void updateSkill(String skill, int value) {
    state = SkillsModel(
      acrobatics: skill == 'acrobatics' ? value : state.acrobatics,
      animalHandling: skill == 'animalHandling' ? value : state.animalHandling,
      arcana: skill == 'arcana' ? value : state.arcana,
      athletics: skill == 'athletics' ? value : state.athletics,
      deception: skill == 'deception' ? value : state.deception,
      history: skill == 'history' ? value : state.history,
      insight: skill == 'insight' ? value : state.insight,
      intimidation: skill == 'intimidation' ? value : state.intimidation,
      investigation: skill == 'investigation' ? value : state.investigation,
      medicine: skill == 'medicine' ? value : state.medicine,
      nature: skill == 'nature' ? value : state.nature,
      perception: skill == 'perception' ? value : state.perception,
      performance: skill == 'performance' ? value : state.performance,
      persuasion: skill == 'persuasion' ? value : state.persuasion,
      religion: skill == 'religion' ? value : state.religion,
      sleightOfHand: skill == 'sleightOfHand' ? value : state.sleightOfHand,
      stealth: skill == 'stealth' ? value : state.stealth,
      survival: skill == 'survival' ? value : state.survival,
    );
  }
}
