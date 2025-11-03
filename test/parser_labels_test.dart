import 'package:flutter_test/flutter_test.dart';
import 'package:muscle_selector/src/parser.dart';

void main() {
  group('Parser Label Tests', () {
    test('Front view muscles have correct labels', () {
      expect(Parser.getMuscleLabel('front_right_leg'), equals('Right Calf'));
      expect(Parser.getMuscleLabel('front_left_leg'), equals('Left Calf'));
      expect(Parser.getMuscleLabel('front_right_adductor_magnus'),
          equals('Right Quad'));
      expect(Parser.getMuscleLabel('front_left_adductor_magnus'),
          equals('Left Quad'));
      expect(
          Parser.getMuscleLabel('front_left_thigh'), equals('Left Adductor'));
      expect(
          Parser.getMuscleLabel('front_right_thigh'), equals('Right Adductor'));
      expect(
          Parser.getMuscleLabel('front_groin_area'), equals('Groin Adductors'));
      expect(Parser.getMuscleLabel('front_torso'), equals('Abs'));
      expect(Parser.getMuscleLabel('front_left_side_chest'),
          equals('Left Oblique'));
      expect(Parser.getMuscleLabel('front_right_side_chest'),
          equals('Right Oblique'));
      expect(Parser.getMuscleLabel('front_left_shoulder_upper_back'),
          equals('Left Trap'));
      expect(Parser.getMuscleLabel('front_right_shoulder_upper_back'),
          equals('Right Trap'));
      expect(
          Parser.getMuscleLabel('front_left_triceps'), equals('Left Forearm'));
      expect(Parser.getMuscleLabel('front_right_triceps'),
          equals('Right Forearm'));
    });

    test('Back view muscles have correct labels', () {
      expect(Parser.getMuscleLabel('back_right_adductor_magnus'),
          equals('Right Hamstring'));
      expect(Parser.getMuscleLabel('back_left_adductor_magnus'),
          equals('Left Hamstring'));
      expect(Parser.getMuscleLabel('back_left_buttocks'), equals('Left Glute'));
      expect(
          Parser.getMuscleLabel('back_right_buttocks'), equals('Right Glute'));
      expect(Parser.getMuscleLabel('back_left_thigh'), equals('Left Adductor'));
      expect(
          Parser.getMuscleLabel('back_right_thigh'), equals('Right Adductor'));
      expect(Parser.getMuscleLabel('upper_left_back'), equals('Left Lat'));
      expect(Parser.getMuscleLabel('upper_right_back'), equals('Right Lat'));
      expect(Parser.getMuscleLabel('mid_back'), equals('Mid Trap'));
      expect(Parser.getMuscleLabel('back_upper_back'), equals('Upper Trap'));
      expect(Parser.getMuscleLabel('back_upper_neck'), equals('Neck Trap'));
      expect(Parser.getMuscleLabel('back_right_upper_arm'),
          equals('Right Tricep'));
      expect(
          Parser.getMuscleLabel('back_left_upper_arm'), equals('Left Tricep'));
      expect(Parser.getMuscleLabel('back_right_triceps'),
          equals('Right Back Forearm'));
      expect(Parser.getMuscleLabel('back_left_triceps'),
          equals('Left Back Forearm'));
      expect(Parser.getMuscleLabel('back_right_forearm'), equals('Right Hand'));
      expect(Parser.getMuscleLabel('back_left_forearm'), equals('Left Hand'));
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
