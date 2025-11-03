import 'package:flutter_test/flutter_test.dart';
import 'package:muscle_selector/src/parser.dart';

void main() {
  group('Parser Label Tests', () {
    test('Front view muscles have correct simplified labels', () {
      expect(Parser.getMuscleLabel('front_right_leg'), equals('Calf'));
      expect(Parser.getMuscleLabel('front_left_leg'), equals('Calf'));
      expect(
          Parser.getMuscleLabel('front_right_adductor_magnus'), equals('Quad'));
      expect(
          Parser.getMuscleLabel('front_left_adductor_magnus'), equals('Quad'));
      expect(Parser.getMuscleLabel('front_left_thigh'), equals('Adductor'));
      expect(Parser.getMuscleLabel('front_right_thigh'), equals('Adductor'));
      expect(Parser.getMuscleLabel('front_groin_area'), equals('Groin'));
      expect(Parser.getMuscleLabel('front_torso'), equals('Abs'));
      expect(Parser.getMuscleLabel('front_left_side_chest'), equals('Oblique'));
      expect(
          Parser.getMuscleLabel('front_right_side_chest'), equals('Oblique'));
      expect(Parser.getMuscleLabel('front_left_shoulder_upper_back'),
          equals('Trap'));
      expect(Parser.getMuscleLabel('front_right_shoulder_upper_back'),
          equals('Trap'));
      expect(Parser.getMuscleLabel('front_left_triceps'), equals('Forearm'));
      expect(Parser.getMuscleLabel('front_right_triceps'), equals('Forearm'));
      expect(Parser.getMuscleLabel('front_left_chest_muscle'), equals('Chest'));
      expect(
          Parser.getMuscleLabel('front_right_chest_muscle'), equals('Chest'));
      expect(Parser.getMuscleLabel('front_middle_chest'), equals('Chest'));
    });

    test('Back view muscles have correct simplified labels', () {
      expect(Parser.getMuscleLabel('back_right_adductor_magnus'),
          equals('Hamstring'));
      expect(Parser.getMuscleLabel('back_left_adductor_magnus'),
          equals('Hamstring'));
      expect(Parser.getMuscleLabel('back_left_buttocks'), equals('Glute'));
      expect(Parser.getMuscleLabel('back_right_buttocks'), equals('Glute'));
      expect(Parser.getMuscleLabel('back_left_thigh'), equals('Adductor'));
      expect(Parser.getMuscleLabel('back_right_thigh'), equals('Adductor'));
      expect(Parser.getMuscleLabel('upper_left_back'), equals('Lat'));
      expect(Parser.getMuscleLabel('upper_right_back'), equals('Lat'));
      expect(Parser.getMuscleLabel('mid_back'), equals('Trap'));
      expect(Parser.getMuscleLabel('back_upper_back'), equals('Trap'));
      expect(Parser.getMuscleLabel('back_upper_neck'), equals('Trap'));
      expect(Parser.getMuscleLabel('back_mid_back'), equals('Trap'));
      expect(Parser.getMuscleLabel('back_right_upper_arm'), equals('Tricep'));
      expect(Parser.getMuscleLabel('back_left_upper_arm'), equals('Tricep'));
      expect(Parser.getMuscleLabel('back_right_triceps'), equals('Forearm'));
      expect(Parser.getMuscleLabel('back_left_triceps'), equals('Forearm'));
      expect(Parser.getMuscleLabel('back_right_forearm'), equals('Hand'));
      expect(Parser.getMuscleLabel('back_left_forearm'), equals('Hand'));
      expect(Parser.getMuscleLabel('back_right_calf'), equals('Calf'));
      expect(Parser.getMuscleLabel('back_left_calf'), equals('Calf'));
    });

    test('Muscle pairs are correctly mapped', () {
      expect(Parser.getPairedMuscleId('front_right_leg'),
          equals('front_left_leg'));
      expect(Parser.getPairedMuscleId('front_left_leg'),
          equals('front_right_leg'));
      expect(Parser.getPairedMuscleId('back_right_adductor_magnus'),
          equals('back_left_adductor_magnus'));
      expect(Parser.getPairedMuscleId('back_left_adductor_magnus'),
          equals('back_right_adductor_magnus'));
      expect(Parser.getPairedMuscleId('front_left_shoulder'),
          equals('front_right_shoulder'));
      expect(Parser.getPairedMuscleId('front_right_shoulder'),
          equals('front_left_shoulder'));
      // Non-paired muscles should return null
      expect(Parser.getPairedMuscleId('front_torso'), isNull);
      expect(Parser.getPairedMuscleId('front_neck'), isNull);
    });

    test('Unmapped labels use default formatting', () {
      expect(Parser.getMuscleLabel('front_some_new_muscle'),
          equals('Some New Muscle'));
      expect(Parser.getMuscleLabel('back_test_muscle'), equals('Test Muscle'));
    });

    test('Labels do not contain underscores', () {
      final allLabels = Parser.muscleLabels.values;
      for (var label in allLabels) {
        expect(label.contains('_'), isFalse,
            reason: 'Label "$label" contains underscore');
      }
    });
  });
}
