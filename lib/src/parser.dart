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

  // Mapping from SVG IDs to user-friendly display labels
  static const Map<String, String> muscleLabels = {
    // Front view - corrected labels
    'front_right_leg': 'Right Calf',
    'front_left_leg': 'Left Calf',
    'front_right_adductor_magnus': 'Right Quad',
    'front_left_adductor_magnus': 'Left Quad',
    'front_left_thigh': 'Left Adductor',
    'front_right_thigh': 'Right Adductor',
    'front_groin_area': 'Groin Adductors',
    'front_torso': 'Abs',
    'front_left_side_chest': 'Left Oblique',
    'front_right_side_chest': 'Right Oblique',
    'front_left_shoulder_upper_back': 'Left Trap',
    'front_right_shoulder_upper_back': 'Right Trap',
    'front_left_triceps': 'Left Forearm',
    'front_right_triceps': 'Right Forearm',
    'front_right_chest_muscle': 'Right Chest',
    'front_left_chest_muscle': 'Left Chest',
    'front_middle_chest': 'Middle Chest',
    'front_right_upper_chest_muscle': 'Right Upper Chest',
    'front_left_upper_chest_muscle': 'Left Upper Chest',
    'front_left_upper_arm': 'Left Bicep',
    'front_right_upper_arm': 'Right Bicep',
    'front_left_shoulder': 'Left Shoulder',
    'front_right_shoulder': 'Right Shoulder',
    'front_neck': 'Neck',
    'front_left_knee': 'Left Knee',
    'front_right_knee': 'Right Knee',
    'front_face': 'Face',
    'front_head_top': 'Head',
    'front_left_forearm': 'Left Forearm',
    'front_right_forearm': 'Right Forearm',
    'front_left_hand_fingers': 'Left Hand',
    'front_right_hand_finger': 'Right Hand',

    // Back view - corrected labels
    'back_right_adductor_magnus': 'Right Hamstring',
    'back_left_adductor_magnus': 'Left Hamstring',
    'back_left_buttocks': 'Left Glute',
    'back_right_buttocks': 'Right Glute',
    'back_left_thigh': 'Left Adductor',
    'back_right_thigh': 'Right Adductor',
    'upper_left_back': 'Left Lat',
    'upper_right_back': 'Right Lat',
    'mid_back': 'Mid Trap',
    'back_mid_back': 'Mid Trap',
    'back_upper_back': 'Upper Trap',
    'back_upper_neck': 'Neck Trap',
    'back_right_upper_arm': 'Right Tricep',
    'back_left_upper_arm': 'Left Tricep',
    'back_right_triceps': 'Right Back Forearm',
    'back_left_triceps': 'Left Back Forearm',
    'back_right_forearm': 'Right Hand',
    'back_left_forearm': 'Left Hand',
    'back_right_leg': 'Right Calf',
    'back_left_leg': 'Left Calf',
    'back_right_calf': 'Right Lower Calf',
    'back_left_calf': 'Left Lower Calf',
    'back_right_shoulder': 'Right Shoulder',
    'back_left_shoulder': 'Left Shoulder',
    'back_left_knee': 'Left Knee',
    'back_right_knee': 'Right Knee',
    'back_right_fingers': 'Right Fingers',
    'back_left_fingers': 'Left Fingers',
    'back_head': 'Head',
    'back_right_ear': 'Right Ear',
    'back_left_ear': 'Left Ear',
  };

  /// Converts a muscle ID to a user-friendly display label
  static String getMuscleLabel(String id) {
    return muscleLabels[id] ?? _formatDefaultLabel(id);
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
