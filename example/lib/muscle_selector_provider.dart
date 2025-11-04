import 'package:flutter/material.dart';
import 'package:muscle_selector/muscle_selector.dart';

class MuscleSelectorProvider extends ChangeNotifier {
  bool _isFrontView = true;
  Set<Muscle> _selectedMuscles = {};

  bool get isFrontView => _isFrontView;

  Set<Muscle> get selectedMuscles => _selectedMuscles;

  void toggleView() {
    _isFrontView = !_isFrontView;
    notifyListeners();
  }

  void setSelectedMuscles(Set<Muscle>? muscles) {
    if (muscles != null) {
      debugPrint(
          "Selected muscles (${_isFrontView ? 'Front' : 'Back'}): ${muscles.map((muscle) => muscle.title).toList()}");
    }
    _selectedMuscles = muscles ?? {};
    notifyListeners();
  }

  void clearSelection() {
    _selectedMuscles.clear();
    notifyListeners();
  }

  void clearAllSelections() {
    _selectedMuscles.clear();
    notifyListeners();
  }
}
