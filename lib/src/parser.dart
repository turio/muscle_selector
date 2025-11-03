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

  static const muscleGroups = {
    // Front view muscles - from human_body_front1.svg
    'front_body_outline': ['front_body_outline'],
    'front_internal_structure': ['front_internal_structure'],
    'front_torso': ['front_torso'],
    'front_right_adductor_magnus': ['front_right_adductor_magnus'],
    'front_left_adductor_magnus': ['front_left_adductor_magnus'],
    'front_right_leg': ['front_right_leg'],
    'front_left_leg': ['front_left_leg'],
    'front_right_chest_muscle': ['front_right_chest_muscle'],
    'front_left_chest_muscle': ['front_left_chest_muscle'],
    'front_left_thigh': ['front_left_thigh'],
    'front_right_thigh': ['front_right_thigh'],
    'front_left_side_chest': ['front_left_side_chest'],
    'front_right_side_chest': ['front_right_side_chest'],
    'front_left_upper_arm': ['front_left_upper_arm'],
    'front_right_upper_arm': ['front_right_upper_arm'],
    'front_groin_area': ['front_groin_area'],
    'front_neck': ['front_neck'],
    'front_left_knee': ['front_left_knee'],
    'front_right_knee': ['front_right_knee'],
    'front_middle_chest': ['front_middle_chest'],
    'front_right_upper_chest_muscle': ['front_right_upper_chest_muscle'],
    'front_left_upper_chest_muscle': ['front_left_upper_chest_muscle'],
    'front_face': ['front_face'],
    'front_left_triceps': ['front_left_triceps'],
    'front_right_triceps': ['front_right_triceps'],
    'front_left_shoulder': ['front_left_shoulder'],
    'front_right_shoulder': ['front_right_shoulder'],
    'front_head_top': ['front_head_top'],
    'front_left_forearm': ['front_left_forearm'],
    'front_right_forearm': ['front_right_forearm'],
    'front_left_shoulder_upper_back': ['front_left_shoulder_upper_back'],
    'front_right_shoulder_upper_back': ['front_right_shoulder_upper_back'],
    'front_left_hand_fingers': ['front_left_hand_fingers'],
    'front_right_hand_finger': ['front_right_hand_finger'],
    'front_accent_detail': ['front_accent_detail'],

    // Back view muscles - from human_body_back1.svg
    'back_body_outline': ['back_body_outline'],
    'back_right_adductor_magnus': ['back_right_adductor_magnus'],
    'back_left_adductor_magnus': ['back_left_adductor_magnus'],
    'upper_left_back': ['upper_left_back'],
    'upper_right_back': ['upper_right_back'],
    'back_head': ['back_head'],
    'back_left_buttocks': ['back_left_buttocks'],
    'back_right_buttocks': ['back_right_buttocks'],
    'mid_back': ['mid_back'],
    'back_right_leg': ['back_right_leg'],
    'back_left_leg': ['back_left_leg'],
    'back_right_triceps': ['back_right_triceps'],
    'back_left_triceps': ['back_left_triceps'],
    'back_mid_back': ['back_mid_back'],
    'back_right_calf': ['back_right_calf'],
    'back_left_calf': ['back_left_calf'],
    'back_right_upper_arm': ['back_right_upper_arm'],
    'back_left_upper_arm': ['back_left_upper_arm'],
    'back_upper_back': ['back_upper_back'],
    'back_right_shoulder': ['back_right_shoulder'],
    'back_left_shoulder': ['back_left_shoulder'],
    'back_left_knee': ['back_left_knee'],
    'back_right_knee': ['back_right_knee'],
    'back_right_forearm': ['back_right_forearm'],
    'back_left_forearm': ['back_left_forearm'],
    'back_upper_neck': ['back_upper_neck'],
    'back_left_thigh': ['back_left_thigh'],
    'back_right_thigh': ['back_right_thigh'],
    'back_right_fingers': ['back_right_fingers'],
    'back_left_fingers': ['back_left_fingers'],
    'back_right_ear': ['back_right_ear'],
    'back_left_ear': ['back_left_ear'],
    'back_left_detail': ['back_left_detail'],
    'back_right_detail': ['back_right_detail'],
  };

  // Mapping from SVG IDs to user-friendly display labels (plural terms since both sides are selected)
  static const Map<String, String> muscleLabels = {
    // Front view - simplified plural labels
    'front_right_leg': 'Calves',
    'front_left_leg': 'Calves',
    'front_right_adductor_magnus': 'Quads',
    'front_left_adductor_magnus': 'Quads',
    'front_left_thigh': 'Adductors',
    'front_right_thigh': 'Adductors',
    'front_groin_area': 'Groin',
    'front_torso': 'Abs',
    'front_left_side_chest': 'Obliques',
    'front_right_side_chest': 'Obliques',
    'front_left_shoulder_upper_back': 'Traps',
    'front_right_shoulder_upper_back': 'Traps',
    'front_left_triceps': 'Forearms',
    'front_right_triceps': 'Forearms',
    'front_right_chest_muscle': 'Chest',
    'front_left_chest_muscle': 'Chest',
    'front_middle_chest': 'Chest',
    'front_right_upper_chest_muscle': 'Chest',
    'front_left_upper_chest_muscle': 'Chest',
    'front_left_upper_arm': 'Biceps',
    'front_right_upper_arm': 'Biceps',
    'front_left_shoulder': 'Shoulders',
    'front_right_shoulder': 'Shoulders',
    'front_neck': 'Neck',
    'front_left_knee': 'Knees',
    'front_right_knee': 'Knees',
    'front_face': 'Face',
    'front_head_top': 'Head',
    'front_left_forearm': 'Forearms',
    'front_right_forearm': 'Forearms',
    'front_left_hand_fingers': 'Hands',
    'front_right_hand_finger': 'Hands',

    // Back view - simplified plural labels
    'back_right_adductor_magnus': 'Hamstrings',
    'back_left_adductor_magnus': 'Hamstrings',
    'back_left_buttocks': 'Glutes',
    'back_right_buttocks': 'Glutes',
    'back_left_thigh': 'Adductors',
    'back_right_thigh': 'Adductors',
    'upper_left_back': 'Lats',
    'upper_right_back': 'Lats',
    'mid_back': 'Lower Back',
    'back_mid_back': 'Traps',
    'back_upper_back': 'Traps',
    'back_upper_neck': 'Traps',
    'back_right_upper_arm': 'Triceps',
    'back_left_upper_arm': 'Triceps',
    'back_right_triceps': 'Forearms',
    'back_left_triceps': 'Forearms',
    'back_right_forearm': 'Hands',
    'back_left_forearm': 'Hands',
    'back_right_leg': 'Calves',
    'back_left_leg': 'Calves',
    'back_right_calf': 'Calves',
    'back_left_calf': 'Calves',
    'back_right_shoulder': 'Shoulders',
    'back_left_shoulder': 'Shoulders',
    'back_left_knee': 'Knees',
    'back_right_knee': 'Knees',
    'back_right_fingers': 'Fingers',
    'back_left_fingers': 'Fingers',
    'back_head': 'Head',
    'back_right_ear': 'Ears',
    'back_left_ear': 'Ears',
  };

  // Mapping of left/right muscle pairs for auto-selection
  static const Map<String, String> musclePairs = {
    // Front view pairs
    'front_right_leg': 'front_left_leg',
    'front_left_leg': 'front_right_leg',
    'front_right_adductor_magnus': 'front_left_adductor_magnus',
    'front_left_adductor_magnus': 'front_right_adductor_magnus',
    'front_left_thigh': 'front_right_thigh',
    'front_right_thigh': 'front_left_thigh',
    'front_left_side_chest': 'front_right_side_chest',
    'front_right_side_chest': 'front_left_side_chest',
    'front_left_shoulder_upper_back': 'front_right_shoulder_upper_back',
    'front_right_shoulder_upper_back': 'front_left_shoulder_upper_back',
    'front_left_triceps': 'front_right_triceps',
    'front_right_triceps': 'front_left_triceps',
    'front_right_chest_muscle': 'front_left_chest_muscle',
    'front_left_chest_muscle': 'front_right_chest_muscle',
    'front_right_upper_chest_muscle': 'front_left_upper_chest_muscle',
    'front_left_upper_chest_muscle': 'front_right_upper_chest_muscle',
    'front_left_upper_arm': 'front_right_upper_arm',
    'front_right_upper_arm': 'front_left_upper_arm',
    'front_left_shoulder': 'front_right_shoulder',
    'front_right_shoulder': 'front_left_shoulder',
    'front_left_knee': 'front_right_knee',
    'front_right_knee': 'front_left_knee',
    'front_left_forearm': 'front_right_forearm',
    'front_right_forearm': 'front_left_forearm',
    'front_left_hand_fingers': 'front_right_hand_finger',
    'front_right_hand_finger': 'front_left_hand_fingers',

    // Back view pairs
    'back_right_adductor_magnus': 'back_left_adductor_magnus',
    'back_left_adductor_magnus': 'back_right_adductor_magnus',
    'back_left_buttocks': 'back_right_buttocks',
    'back_right_buttocks': 'back_left_buttocks',
    'back_left_thigh': 'back_right_thigh',
    'back_right_thigh': 'back_left_thigh',
    'upper_left_back': 'upper_right_back',
    'upper_right_back': 'upper_left_back',
    'back_right_upper_arm': 'back_left_upper_arm',
    'back_left_upper_arm': 'back_right_upper_arm',
    'back_right_triceps': 'back_left_triceps',
    'back_left_triceps': 'back_right_triceps',
    'back_right_forearm': 'back_left_forearm',
    'back_left_forearm': 'back_right_forearm',
    'back_right_leg': 'back_left_leg',
    'back_left_leg': 'back_right_leg',
    'back_right_calf': 'back_left_calf',
    'back_left_calf': 'back_right_calf',
    'back_right_shoulder': 'back_left_shoulder',
    'back_left_shoulder': 'back_right_shoulder',
    'back_left_knee': 'back_right_knee',
    'back_right_knee': 'back_left_knee',
    'back_right_fingers': 'back_left_fingers',
    'back_left_fingers': 'back_right_fingers',
    'back_right_ear': 'back_left_ear',
    'back_left_ear': 'back_right_ear',
  };

  /// Converts a muscle ID to a user-friendly display label
  static String getMuscleLabel(String id) {
    return muscleLabels[id] ?? _formatDefaultLabel(id);
  }

  /// Gets the paired muscle ID (left/right counterpart) if it exists
  static String? getPairedMuscleId(String id) {
    return musclePairs[id];
  }

  /// Formats the ID as a fallback label by removing prefixes and converting to title case
  static String _formatDefaultLabel(String id) {
    // Remove front_ or back_ prefix
    String label = id.replaceFirst(RegExp(r'^(front_|back_)'), '');

    // Replace underscores with spaces
    label = label.replaceAll('_', ' ');

    // Convert to title case
    return label.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

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
      // SVG title from group(2) is ignored, using mapped labels instead
      final path = parseSvgPath(muscleData.group(3)!);

      sizeController.addBounds(path.getBounds());

      // Use the mapped label instead of the SVG title
      final displayLabel = getMuscleLabel(id);
      final muscle = Muscle(id: id, title: displayLabel, path: path);

      muscleList.add(muscle);

      final group = muscleGroups.entries
          .firstWhereOrNull((entry) => entry.value.contains(id));
      if (group != null) {
        for (var groupId in group.value) {
          if (groupId != id) {
            final groupMuscle =
                Muscle(id: groupId, title: displayLabel, path: path);
            muscleList.add(groupMuscle);
          }
        }
      }
    });

    return muscleList;
  }
}
