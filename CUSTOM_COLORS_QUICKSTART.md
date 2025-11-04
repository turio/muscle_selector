# Custom Muscle Colors - Quick Start

Create muscle heatmaps and custom visualizations in 3 easy steps!

## Quick Example

```dart
import 'package:muscle_selector/muscle_selector.dart';

// 1. Define your color configurations
final heatmapColors = [
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

// 2. Use in your widget
MusclePickerMap(
  map: Maps.BODY_FRONT,
  muscleColorConfigs: heatmapColors,  // ← Add this
  isEditing: false,                    // ← Disable editing for heatmap
  onChanged: (_) {},
  strokeColor: Colors.white,
)
```

## Common Use Cases

### Workout Intensity
```dart
MuscleColorConfig(muscleId: 'front_right_chest_muscle', color: Colors.red.shade700)
```

### Soreness Levels
```dart
MuscleColorConfig(muscleId: 'back_left_calf', color: Colors.orange.shade700)
```

### Recovery Status
```dart
MuscleColorConfig(muscleId: 'front_torso', color: Colors.green.shade500)
```

## Key Parameters

- `muscleColorConfigs`: List of `MuscleColorConfig` objects
- `isEditing: false`: Disables user interaction (recommended for heatmaps)
- Custom colors override the default `selectedColor`

## Find Muscle IDs

Common muscle IDs:
- Chest: `front_right_chest_muscle`, `front_left_chest_muscle`
- Biceps: `front_right_upper_arm`, `front_left_upper_arm`
- Abs: `front_torso`
- Quads: `front_right_adductor_magnus`, `front_left_adductor_magnus`
- Lats: `upper_right_back`, `upper_left_back`
- Glutes: `back_right_buttocks`, `back_left_buttocks`

📖 **Full muscle ID list and detailed guide**: See [MUSCLE_HEATMAP_GUIDE.md](MUSCLE_HEATMAP_GUIDE.md)

## Demo

Run the example app to see it in action:
```bash
cd example
flutter run
```

Select "Muscle Heatmap Demo" to see three preset heatmaps!
