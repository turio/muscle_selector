import 'package:flutter/material.dart';

/// Configuration for custom muscle colors
/// Used for programmatically setting colors for specific muscles
class MuscleColorConfig {
  /// The muscle ID to apply the color to
  final String muscleId;

  /// The color to apply to this muscle
  final Color color;

  const MuscleColorConfig({
    required this.muscleId,
    required this.color,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MuscleColorConfig &&
          runtimeType == other.runtimeType &&
          muscleId == other.muscleId &&
          color == other.color;

  @override
  int get hashCode => muscleId.hashCode ^ color.hashCode;
}
