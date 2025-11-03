// Quick verification script to show corrected muscle labels
import 'lib/src/parser.dart';

void main() {
  print('=== FRONT VIEW CORRECTED LABELS ===');
  print('front_right_leg → ${Parser.getMuscleLabel('front_right_leg')}');
  print('front_left_leg → ${Parser.getMuscleLabel('front_left_leg')}');
  print(
      'front_right_adductor_magnus → ${Parser.getMuscleLabel('front_right_adductor_magnus')}');
  print(
      'front_left_adductor_magnus → ${Parser.getMuscleLabel('front_left_adductor_magnus')}');
  print('front_left_thigh → ${Parser.getMuscleLabel('front_left_thigh')}');
  print('front_right_thigh → ${Parser.getMuscleLabel('front_right_thigh')}');
  print('front_groin_area → ${Parser.getMuscleLabel('front_groin_area')}');
  print('front_torso → ${Parser.getMuscleLabel('front_torso')}');
  print(
      'front_left_side_chest → ${Parser.getMuscleLabel('front_left_side_chest')}');
  print(
      'front_right_side_chest → ${Parser.getMuscleLabel('front_right_side_chest')}');
  print(
      'front_left_shoulder_upper_back → ${Parser.getMuscleLabel('front_left_shoulder_upper_back')}');
  print(
      'front_right_shoulder_upper_back → ${Parser.getMuscleLabel('front_right_shoulder_upper_back')}');
  print('front_left_triceps → ${Parser.getMuscleLabel('front_left_triceps')}');
  print(
      'front_right_triceps → ${Parser.getMuscleLabel('front_right_triceps')}');

  print('\n=== BACK VIEW CORRECTED LABELS ===');
  print(
      'back_right_adductor_magnus → ${Parser.getMuscleLabel('back_right_adductor_magnus')}');
  print(
      'back_left_adductor_magnus → ${Parser.getMuscleLabel('back_left_adductor_magnus')}');
  print('back_left_buttocks → ${Parser.getMuscleLabel('back_left_buttocks')}');
  print(
      'back_right_buttocks → ${Parser.getMuscleLabel('back_right_buttocks')}');
  print('back_left_thigh → ${Parser.getMuscleLabel('back_left_thigh')}');
  print('back_right_thigh → ${Parser.getMuscleLabel('back_right_thigh')}');
  print('upper_left_back → ${Parser.getMuscleLabel('upper_left_back')}');
  print('upper_right_back → ${Parser.getMuscleLabel('upper_right_back')}');
  print('mid_back → ${Parser.getMuscleLabel('mid_back')}');
  print('back_upper_back → ${Parser.getMuscleLabel('back_upper_back')}');
  print('back_upper_neck → ${Parser.getMuscleLabel('back_upper_neck')}');
  print(
      'back_right_upper_arm → ${Parser.getMuscleLabel('back_right_upper_arm')}');
  print(
      'back_left_upper_arm → ${Parser.getMuscleLabel('back_left_upper_arm')}');
  print('back_right_triceps → ${Parser.getMuscleLabel('back_right_triceps')}');
  print('back_left_triceps → ${Parser.getMuscleLabel('back_left_triceps')}');
  print('back_right_forearm → ${Parser.getMuscleLabel('back_right_forearm')}');
  print('back_left_forearm → ${Parser.getMuscleLabel('back_left_forearm')}');
}
