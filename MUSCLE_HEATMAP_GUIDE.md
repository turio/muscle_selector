# Muscle Heatmap & Custom Colors Guide

This guide explains how to programmatically select muscles and apply custom colors to create muscle heatmaps and other visual effects in your Flutter app using the Muscle Selector package.

## Overview

The custom color feature allows you to:
- Programmatically select and color specific muscles
- Create muscle heatmaps (e.g., workout intensity, soreness levels, recovery status)
- Visualize data on the human body model
- Display read-only muscle visualizations with custom styling

## Basic Usage

### 1. Import Required Classes

```dart
import 'package:muscle_selector/muscle_selector.dart';
```

### 2. Create Muscle Color Configurations

Use the `MuscleColorConfig` class to define which muscles should have custom colors:

```dart
final colorConfigs = [
  MuscleColorConfig(
    muscleId: 'front_right_chest_muscle',
    color: Colors.red.shade700,
  ),
  MuscleColorConfig(
    muscleId: 'front_left_chest_muscle',
    color: Colors.red.shade700,
  ),
  MuscleColorConfig(
    muscleId: 'front_right_upper_arm',
    color: Colors.orange.shade600,
  ),
];
```

### 3. Apply to MusclePickerMap

Pass the color configurations to the `MusclePickerMap` widget:

```dart
MusclePickerMap(
  map: Maps.BODY_FRONT,
  muscleColorConfigs: colorConfigs,
  isEditing: false, // Disable user interaction for heatmap view
  onChanged: (_) {}, // No-op callback
  strokeColor: Colors.white,
)
```

## Complete Example

Here's a complete example showing a workout intensity heatmap:

```dart
import 'package:flutter/material.dart';
import 'package:muscle_selector/muscle_selector.dart';

class WorkoutHeatmapScreen extends StatelessWidget {
  const WorkoutHeatmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define muscle colors based on workout intensity
    final workoutIntensity = [
      // High intensity (red)
      MuscleColorConfig(
        muscleId: 'front_right_chest_muscle',
        color: Colors.red.shade700,
      ),
      MuscleColorConfig(
        muscleId: 'front_left_chest_muscle',
        color: Colors.red.shade700,
      ),
      
      // Medium intensity (orange)
      MuscleColorConfig(
        muscleId: 'front_right_upper_arm',
        color: Colors.orange.shade600,
      ),
      MuscleColorConfig(
        muscleId: 'front_left_upper_arm',
        color: Colors.orange.shade600,
      ),
      
      // Low intensity (yellow)
      MuscleColorConfig(
        muscleId: 'front_right_shoulder',
        color: Colors.yellow.shade700,
      ),
      MuscleColorConfig(
        muscleId: 'front_left_shoulder',
        color: Colors.yellow.shade700,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Intensity'),
      ),
      body: Column(
        children: [
          Expanded(
            child: MusclePickerMap(
              map: Maps.BODY_FRONT,
              muscleColorConfigs: workoutIntensity,
              isEditing: false,
              onChanged: (_) {},
              strokeColor: Colors.white,
            ),
          ),
          _buildLegend(),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _legendItem('High', Colors.red.shade700),
          _legendItem('Medium', Colors.orange.shade600),
          _legendItem('Low', Colors.yellow.shade700),
        ],
      ),
    );
  }

  Widget _legendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}
```

## Available Muscle IDs

### Front View Muscles

```dart
// Chest
'front_right_chest_muscle'
'front_left_chest_muscle'
'front_middle_chest'
'front_right_upper_chest_muscle'
'front_left_upper_chest_muscle'

// Arms
'front_right_upper_arm'      // Biceps
'front_left_upper_arm'       // Biceps
'front_right_forearm'
'front_left_forearm'
'front_right_triceps'
'front_left_triceps'

// Shoulders
'front_right_shoulder'
'front_left_shoulder'
'front_right_shoulder_upper_back'  // Traps
'front_left_shoulder_upper_back'   // Traps

// Core
'front_torso'                // Abs
'front_right_side_chest'     // Obliques
'front_left_side_chest'      // Obliques

// Legs
'front_right_adductor_magnus'  // Quads
'front_left_adductor_magnus'   // Quads
'front_right_thigh'            // Adductors
'front_left_thigh'             // Adductors
'front_right_leg'              // Calves
'front_left_leg'               // Calves
'front_right_knee'
'front_left_knee'

// Other
'front_groin_area'
'front_neck'
'front_face'
'front_head_top'
'front_right_hand_finger'
'front_left_hand_fingers'
```

### Back View Muscles

```dart
// Back
'upper_right_back'           // Lats
'upper_left_back'            // Lats
'back_upper_back'            // Traps
'back_mid_back'              // Traps
'back_upper_neck'            // Traps
'mid_back'                   // Lower back

// Arms
'back_right_upper_arm'       // Triceps
'back_left_upper_arm'        // Triceps
'back_right_triceps'         // Forearms
'back_left_triceps'          // Forearms
'back_right_forearm'
'back_left_forearm'

// Shoulders
'back_right_shoulder'
'back_left_shoulder'

// Glutes & Legs
'back_right_buttocks'        // Glutes
'back_left_buttocks'         // Glutes
'back_right_adductor_magnus' // Hamstrings
'back_left_adductor_magnus'  // Hamstrings
'back_right_thigh'           // Adductors
'back_left_thigh'            // Adductors
'back_right_leg'             // Calves
'back_left_leg'              // Calves
'back_right_calf'
'back_left_calf'
'back_right_knee'
'back_left_knee'

// Other
'back_head'
'back_right_ear'
'back_left_ear'
'back_right_fingers'
'back_left_fingers'
```

## Use Cases

### 1. Workout Intensity Heatmap

Show which muscles were worked during a training session:

```dart
final workoutData = [
  MuscleColorConfig(muscleId: 'front_right_chest_muscle', color: Colors.red),
  MuscleColorConfig(muscleId: 'front_left_chest_muscle', color: Colors.red),
  // ... more muscles
];
```

### 2. Muscle Soreness Tracker

Visualize post-workout soreness levels:

```dart
final sorenessLevels = [
  MuscleColorConfig(muscleId: 'front_right_adductor_magnus', color: Colors.red.shade900),  // Very sore
  MuscleColorConfig(muscleId: 'front_left_adductor_magnus', color: Colors.red.shade900),
  MuscleColorConfig(muscleId: 'front_right_leg', color: Colors.orange.shade700),  // Moderately sore
  // ... more muscles
];
```

### 3. Recovery Status

Display muscle recovery progress:

```dart
final recoveryStatus = [
  MuscleColorConfig(muscleId: 'front_right_chest_muscle', color: Colors.green.shade700),  // Fully recovered
  MuscleColorConfig(muscleId: 'front_left_chest_muscle', color: Colors.green.shade700),
  MuscleColorConfig(muscleId: 'front_right_upper_arm', color: Colors.yellow.shade700),  // Still recovering
  // ... more muscles
];
```

### 4. Injury Tracking

Mark injured or problematic areas:

```dart
final injuries = [
  MuscleColorConfig(muscleId: 'front_right_knee', color: Colors.red.shade900),
  MuscleColorConfig(muscleId: 'back_mid_back', color: Colors.orange.shade700),
];
```

### 5. Training Focus Areas

Highlight target muscles for a workout plan:

```dart
final targetMuscles = [
  MuscleColorConfig(muscleId: 'front_right_chest_muscle', color: Colors.blue.shade700),
  MuscleColorConfig(muscleId: 'front_left_chest_muscle', color: Colors.blue.shade700),
  MuscleColorConfig(muscleId: 'front_right_upper_arm', color: Colors.blue.shade700),
  MuscleColorConfig(muscleId: 'front_left_upper_arm', color: Colors.blue.shade700),
];
```

## Dynamic Color Updates

You can dynamically update colors based on user data:

```dart
class DynamicHeatmapScreen extends StatefulWidget {
  const DynamicHeatmapScreen({super.key});

  @override
  State<DynamicHeatmapScreen> createState() => _DynamicHeatmapScreenState();
}

class _DynamicHeatmapScreenState extends State<DynamicHeatmapScreen> {
  List<MuscleColorConfig> _colorConfigs = [];

  @override
  void initState() {
    super.initState();
    _loadWorkoutData();
  }

  Future<void> _loadWorkoutData() async {
    // Fetch workout data from API or database
    final workoutData = await fetchWorkoutData();
    
    setState(() {
      _colorConfigs = workoutData.map((data) {
        return MuscleColorConfig(
          muscleId: data.muscleId,
          color: _getColorForIntensity(data.intensity),
        );
      }).toList();
    });
  }

  Color _getColorForIntensity(double intensity) {
    if (intensity > 0.8) return Colors.red.shade700;
    if (intensity > 0.5) return Colors.orange.shade600;
    if (intensity > 0.3) return Colors.yellow.shade700;
    return Colors.green.shade500;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MusclePickerMap(
        map: Maps.BODY_FRONT,
        muscleColorConfigs: _colorConfigs,
        isEditing: false,
        onChanged: (_) {},
      ),
    );
  }
}
```

## Best Practices

1. **Use Consistent Color Schemes**: Stick to a consistent color palette for similar data types (e.g., red for high intensity, green for low).

2. **Provide a Legend**: Always include a legend to help users understand what the colors represent.

3. **Disable Editing for Heatmaps**: Set `isEditing: false` when displaying heatmaps to prevent user interaction.

4. **Handle Both Views**: Remember to provide color configurations for both front and back views if your data spans both.

5. **Use Appropriate Color Intensity**: Use darker shades for higher values and lighter shades for lower values to create intuitive visualizations.

6. **Consider Accessibility**: Ensure your color choices are distinguishable for users with color vision deficiencies.

7. **Optimize Performance**: If you have many muscles to color, consider using a Map for O(1) lookups:

```dart
final colorMap = {
  'front_right_chest_muscle': Colors.red.shade700,
  'front_left_chest_muscle': Colors.red.shade700,
  // ... more muscles
};

final colorConfigs = colorMap.entries
    .map((e) => MuscleColorConfig(muscleId: e.key, color: e.value))
    .toList();
```

## API Reference

### MuscleColorConfig

```dart
class MuscleColorConfig {
  final String muscleId;  // The ID of the muscle to color
  final Color color;      // The color to apply
  
  const MuscleColorConfig({
    required this.muscleId,
    required this.color,
  });
}
```

### MusclePickerMap Parameters

```dart
MusclePickerMap({
  required String map,                              // Maps.BODY_FRONT or Maps.BODY_BACK
  required Function(Set<Muscle>) onChanged,         // Callback for muscle selection changes
  List<MuscleColorConfig>? muscleColorConfigs,      // Custom color configurations
  bool? isEditing = true,                           // Enable/disable user interaction
  Color? strokeColor,                               // Outline color
  Color? selectedColor,                             // Default selection color (overridden by custom colors)
  double? width,                                    // Widget width
  double? height,                                   // Widget height
  // ... other parameters
})
```

## Troubleshooting

### Colors Not Showing

- Verify the muscle IDs are correct (see the muscle ID lists above)
- Ensure `muscleColorConfigs` is not null or empty
- Check that the muscle IDs match the current view (front vs back)

### Performance Issues

- Limit the number of colored muscles if possible
- Use `const` constructors where applicable
- Consider using `ValueKey` to prevent unnecessary rebuilds

### Colors Overriding Selection

- Custom colors take precedence over the default `selectedColor`
- If you want user selection to work alongside custom colors, manage both states separately

## Demo App

Check out the example app included in the package for a complete working demonstration:

```bash
cd example
flutter run
```

The demo includes three preset heatmaps:
- Workout Intensity
- Soreness Map
- Recovery Status

## Support

For issues, questions, or feature requests, please visit the package repository.
