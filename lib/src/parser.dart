import 'package:flutter/services.dart' show rootBundle;
import 'package:muscle_selector/muscle_selector.dart';
import 'package:svg_path_parser/svg_path_parser.dart';
import 'package:collection/collection.dart';
import 'size_controller.dart';
import 'constant.dart';

class Parser {
  static Parser? _instance;

  static Parser get instance {
    _instance ??= Parser._init();
    return _instance!;
  }

  final sizeController = SizeController.instance;

  Parser._init();

  // Muscle titles mapping - using gym-friendly terminology
  static const muscleTitles = {
    // Front view - gym-friendly names
    'front_right_adductor_magnus': 'Right Serratus',
    'front_left_adductor_magnus': 'Left Serratus',
    'front_right_leg': 'Right Quads',
    'front_left_leg': 'Left Quads',
    'front_right_chest_muscle': 'Right Chest',
    'front_left_chest_muscle': 'Left Chest',
    'front_left_thigh': 'Left Inner Thigh',
    'front_right_thigh': 'Right Inner Thigh',
    'front_left_side_chest': 'Left Obliques',
    'front_right_side_chest': 'Right Obliques',
    'front_left_upper_arm': 'Left Biceps',
    'front_right_upper_arm': 'Right Biceps',
    'front_left_shoulder': 'Left Shoulders',
    'front_right_shoulder': 'Right Shoulders',
    'front_left_knee': 'Left Knee',
    'front_right_knee': 'Right Knee',
    'front_middle_chest': 'Upper Chest',
    'front_right_upper_chest_muscle': 'Right Upper Chest',
    'front_left_upper_chest_muscle': 'Left Upper Chest',
    'front_left_triceps': 'Left Triceps',
    'front_right_triceps': 'Right Triceps',
    'front_left_forearm': 'Left Forearms',
    'front_right_forearm': 'Right Forearms',

    // Back view - gym-friendly names
    'upper_left_back': 'Left Lats',
    'upper_right_back': 'Right Lats',
    'back_left_buttocks': 'Left Glutes',
    'back_right_buttocks': 'Right Glutes',
    'mid_back': 'Lower Back',
    'back_right_leg': 'Right Hamstrings',
    'back_left_leg': 'Left Hamstrings',
    'back_mid_back': 'Mid Back',
    'back_right_calf': 'Right Calves',
    'back_left_calf': 'Left Calves',
    'back_right_upper_arm': 'Right Rear Delts',
    'back_left_upper_arm': 'Left Rear Delts',
    'back_upper_back': 'Upper Traps',
    'back_right_shoulder': 'Right Shoulders',
    'back_left_shoulder': 'Left Shoulders',
    'back_left_knee': 'Left Knee',
    'back_right_knee': 'Right Knee',
    'back_left_thigh': 'Left Upper Hamstrings',
    'back_right_thigh': 'Right Upper Hamstrings',
    'back_right_triceps': 'Right Triceps',
    'back_left_triceps': 'Left Triceps',
    'back_right_forearm': 'Right Forearms',
    'back_left_forearm': 'Left Forearms',
  };

  static const muscleGroups = {
    // Front view muscles - gym-friendly names
    'front_body_outline': ['front_body_outline'],
    'front_internal_structure': ['front_internal_structure'],
    'front_torso': ['front_torso'],

    // Serratus (side ribs)
    'front_right_serratus': ['front_right_adductor_magnus'],
    'front_left_serratus': ['front_left_adductor_magnus'],

    // Quads (front thighs)
    'front_right_quads': ['front_right_leg'],
    'front_left_quads': ['front_left_leg'],

    // Chest
    'front_right_chest': ['front_right_chest_muscle'],
    'front_left_chest': ['front_left_chest_muscle'],

    // Inner thighs
    'front_left_inner_thigh': ['front_left_thigh'],
    'front_right_inner_thigh': ['front_right_thigh'],

    // Obliques (side abs)
    'front_left_obliques': ['front_left_side_chest'],
    'front_right_obliques': ['front_right_side_chest'],

    // Biceps
    'front_left_biceps': ['front_left_upper_arm'],
    'front_right_biceps': ['front_right_upper_arm'],
    'front_groin_area': ['front_groin_area'],
    'front_neck': ['front_neck'],
    'front_left_knee': ['front_left_knee'],
    'front_right_knee': ['front_right_knee'],
    'front_upper_chest': ['front_middle_chest'],
    'front_right_upper_chest': ['front_right_upper_chest_muscle'],
    'front_left_upper_chest': ['front_left_upper_chest_muscle'],
    'front_face': ['front_face'],
    'front_left_triceps': ['front_left_triceps'],
    'front_right_triceps': ['front_right_triceps'],
    'front_left_shoulders': ['front_left_shoulder'],
    'front_right_shoulders': ['front_right_shoulder'],
    'front_head_top': ['front_head_top'],
    'front_left_forearms': ['front_left_forearm'],
    'front_right_forearms': ['front_right_forearm'],
    'front_left_shoulder_upper_back': ['front_left_shoulder_upper_back'],
    'front_right_shoulder_upper_back': ['front_right_shoulder_upper_back'],
    'front_left_hand_fingers': ['front_left_hand_fingers'],
    'front_right_hand_finger': ['front_right_hand_finger'],
    'front_accent_detail': ['front_accent_detail'],

    // Back view muscles - gym-friendly names
    'back_body_outline': ['back_body_outline'],

    // Lats (back wings)
    'upper_left_lats': ['upper_left_back'],
    'upper_right_lats': ['upper_right_back'],
    'back_head': ['back_head'],

    // Glutes (butt)
    'back_left_glutes': ['back_left_buttocks'],
    'back_right_glutes': ['back_right_buttocks'],

    // Lower back
    'back_lower_back': ['mid_back'],

    // Hamstrings (back thighs)
    'back_right_hamstrings': ['back_right_leg'],
    'back_left_hamstrings': ['back_left_leg'],
    'back_right_triceps': ['back_right_triceps'],
    'back_left_triceps': ['back_left_triceps'],
    'back_mid_back': ['back_mid_back'],

    // Calves
    'back_right_calves': ['back_right_calf'],
    'back_left_calves': ['back_left_calf'],

    // Rear delts (back shoulders)
    'back_right_rear_delts': ['back_right_upper_arm'],
    'back_left_rear_delts': ['back_left_upper_arm'],

    // Traps (upper back/neck)
    'back_upper_traps': ['back_upper_back'],
    'back_right_shoulders': ['back_right_shoulder'],
    'back_left_shoulders': ['back_left_shoulder'],
    'back_left_knee': ['back_left_knee'],
    'back_right_knee': ['back_right_knee'],
    'back_right_forearms': ['back_right_forearm'],
    'back_left_forearms': ['back_left_forearm'],
    'back_upper_neck': ['back_upper_neck'],
    'back_left_upper_hamstrings': ['back_left_thigh'],
    'back_right_upper_hamstrings': ['back_right_thigh'],
    'back_right_fingers': ['back_right_fingers'],
    'back_left_fingers': ['back_left_fingers'],
    'back_right_ear': ['back_right_ear'],
    'back_left_ear': ['back_left_ear'],
    'back_left_detail': ['back_left_detail'],
    'back_right_detail': ['back_right_detail'],
  };

  Set<Muscle> getMusclesByGroups(
      List<String> groupKeys, List<Muscle> muscleList) {
    final groupIds =
        groupKeys.expand((groupKey) => muscleGroups[groupKey] ?? []).toSet();
    return muscleList.where((muscle) => groupIds.contains(muscle.id)).toSet();
  }

  Future<List<Muscle>> svgToMuscleList(String body) async {
    final svgMuscle =
        await rootBundle.loadString('${Constants.ASSETS_PATH}/$body');
    List<Muscle> muscleList = [];

    final regExp = RegExp(Constants.MAP_REGEXP,
        multiLine: true, caseSensitive: false, dotAll: false);

    regExp.allMatches(svgMuscle).forEach((muscleData) {
      final id = muscleData.group(1)!;
      final originalTitle = muscleData.group(2)!;
      final path = parseSvgPath(muscleData.group(3)!);

      sizeController.addBounds(path.getBounds());

      // Use corrected title if available, otherwise use original
      final correctedTitle = muscleTitles[id] ?? originalTitle;

      // Skip incorrectly labeled back adductors (adductors are not visible from back)
      if (id == 'back_right_adductor_magnus' ||
          id == 'back_left_adductor_magnus') {
        return; // Skip these incorrect labels
      }

      final muscle = Muscle(id: id, title: correctedTitle, path: path);

      muscleList.add(muscle);

      final group = muscleGroups.entries
          .firstWhereOrNull((entry) => entry.value.contains(id));
      if (group != null) {
        for (var groupId in group.value) {
          if (groupId != id) {
            final groupMuscle =
                Muscle(id: groupId, title: correctedTitle, path: path);
            muscleList.add(groupMuscle);
          }
        }
      }
    });

    return muscleList;
  }
}
