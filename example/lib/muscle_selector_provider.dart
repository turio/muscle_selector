import 'package:flutter/material.dart';
import 'package:muscle_selector/muscle_selector.dart';

class MuscleSelectorProvider extends ChangeNotifier {
  bool _isFrontView = true;
  Set<Muscle> _frontViewMuscles = {};
  Set<Muscle> _backViewMuscles = {};

  bool get isFrontView => _isFrontView;

  Set<Muscle> get selectedMuscles =>
      _isFrontView ? _frontViewMuscles : _backViewMuscles;

  void toggleView() {
    _isFrontView = !_isFrontView;
    notifyListeners();
  }

  void setSelectedMuscles(Set<Muscle>? muscles) {
    if (muscles != null) {
      print(
          "Selected muscles (${_isFrontView ? 'Front' : 'Back'}): ${muscles.map((muscle) => muscle.title).toList()}");
    }
    if (_isFrontView) {
      _frontViewMuscles = muscles ?? {};
    } else {
      _backViewMuscles = muscles ?? {};
    }
    notifyListeners();
  }

  void clearSelection() {
    if (_isFrontView) {
      _frontViewMuscles.clear();
    } else {
      _backViewMuscles.clear();
    }
    notifyListeners();
  }

  void clearAllSelections() {
    _frontViewMuscles.clear();
    _backViewMuscles.clear();
    notifyListeners();
  }
}
