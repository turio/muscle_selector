// Copy-paste example for creating a muscle heatmap
// This is a standalone example you can use in your Flutter app

import 'package:flutter/material.dart';
import 'package:muscle_selector/muscle_selector.dart';

class SimpleHeatmapExample extends StatelessWidget {
  const SimpleHeatmapExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Define which muscles to color and what colors to use
    final workoutHeatmap = [
      // Chest - High intensity (red)
      MuscleColorConfig(
        muscleId: 'front_right_chest_muscle',
        color: Colors.red.shade700,
      ),
      MuscleColorConfig(
        muscleId: 'front_left_chest_muscle',
        color: Colors.red.shade700,
      ),

      // Arms - Medium intensity (orange)
      MuscleColorConfig(
        muscleId: 'front_right_upper_arm',
        color: Colors.orange.shade600,
      ),
      MuscleColorConfig(
        muscleId: 'front_left_upper_arm',
        color: Colors.orange.shade600,
      ),

      // Shoulders - Low intensity (yellow)
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
        title: const Text('Workout Heatmap'),
      ),
      body: Column(
        children: [
          // The muscle map with custom colors
          Expanded(
            child: MusclePickerMap(
              map: Maps.BODY_FRONT,
              muscleColorConfigs: workoutHeatmap,
              isEditing: false, // Disable user interaction
              onChanged: (_) {}, // Required but not used
              strokeColor: Colors.white,
            ),
          ),

          // Legend
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLegendItem('High', Colors.red.shade700),
                _buildLegendItem('Medium', Colors.orange.shade600),
                _buildLegendItem('Low', Colors.yellow.shade700),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
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

// Usage in your app:
// Navigator.push(
//   context,
//   MaterialPageRoute(builder: (context) => const SimpleHeatmapExample()),
// );
