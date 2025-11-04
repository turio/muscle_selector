import 'package:flutter/material.dart';
import 'package:muscle_selector/muscle_selector.dart';

/// Demo screen showing how to programmatically select muscles with custom colors
/// This creates a muscle heatmap effect
class MuscleHeatmapScreen extends StatefulWidget {
  const MuscleHeatmapScreen({super.key});

  @override
  State<MuscleHeatmapScreen> createState() => _MuscleHeatmapScreenState();
}

class _MuscleHeatmapScreenState extends State<MuscleHeatmapScreen> {
  bool _isFrontView = true;
  String _selectedPreset = 'workout_intensity';

  // Predefined heatmap presets
  final Map<String, Map<String, List<MuscleColorConfig>>> _heatmapPresets = {
    'workout_intensity': {
      'front': [
        MuscleColorConfig(
            muscleId: 'front_right_chest_muscle', color: Colors.red.shade700),
        MuscleColorConfig(
            muscleId: 'front_left_chest_muscle', color: Colors.red.shade700),
        MuscleColorConfig(
            muscleId: 'front_middle_chest', color: Colors.red.shade700),
        MuscleColorConfig(
            muscleId: 'front_right_upper_arm', color: Colors.orange.shade600),
        MuscleColorConfig(
            muscleId: 'front_left_upper_arm', color: Colors.orange.shade600),
        MuscleColorConfig(
            muscleId: 'front_right_shoulder', color: Colors.yellow.shade700),
        MuscleColorConfig(
            muscleId: 'front_left_shoulder', color: Colors.yellow.shade700),
        MuscleColorConfig(
            muscleId: 'front_torso', color: Colors.orange.shade400),
      ],
      'back': [
        MuscleColorConfig(
            muscleId: 'upper_left_back', color: Colors.red.shade700),
        MuscleColorConfig(
            muscleId: 'upper_right_back', color: Colors.red.shade700),
        MuscleColorConfig(
            muscleId: 'back_upper_back', color: Colors.orange.shade600),
        MuscleColorConfig(
            muscleId: 'back_left_triceps', color: Colors.yellow.shade700),
        MuscleColorConfig(
            muscleId: 'back_right_triceps', color: Colors.yellow.shade700),
        MuscleColorConfig(
            muscleId: 'back_left_buttocks', color: Colors.orange.shade400),
        MuscleColorConfig(
            muscleId: 'back_right_buttocks', color: Colors.orange.shade400),
      ],
    },
    'soreness_map': {
      'front': [
        MuscleColorConfig(
            muscleId: 'front_right_adductor_magnus',
            color: Colors.red.shade900),
        MuscleColorConfig(
            muscleId: 'front_left_adductor_magnus', color: Colors.red.shade900),
        MuscleColorConfig(
            muscleId: 'front_left_thigh', color: Colors.orange.shade700),
        MuscleColorConfig(
            muscleId: 'front_right_thigh', color: Colors.orange.shade700),
        MuscleColorConfig(
            muscleId: 'front_right_leg', color: Colors.yellow.shade600),
        MuscleColorConfig(
            muscleId: 'front_left_leg', color: Colors.yellow.shade600),
      ],
      'back': [
        MuscleColorConfig(
            muscleId: 'back_right_adductor_magnus', color: Colors.red.shade900),
        MuscleColorConfig(
            muscleId: 'back_left_adductor_magnus', color: Colors.red.shade900),
        MuscleColorConfig(
            muscleId: 'back_left_calf', color: Colors.orange.shade700),
        MuscleColorConfig(
            muscleId: 'back_right_calf', color: Colors.orange.shade700),
        MuscleColorConfig(muscleId: 'mid_back', color: Colors.yellow.shade600),
      ],
    },
    'recovery_status': {
      'front': [
        MuscleColorConfig(
            muscleId: 'front_right_chest_muscle', color: Colors.green.shade700),
        MuscleColorConfig(
            muscleId: 'front_left_chest_muscle', color: Colors.green.shade700),
        MuscleColorConfig(
            muscleId: 'front_right_upper_arm', color: Colors.green.shade500),
        MuscleColorConfig(
            muscleId: 'front_left_upper_arm', color: Colors.green.shade500),
        MuscleColorConfig(
            muscleId: 'front_torso', color: Colors.lightGreen.shade600),
        MuscleColorConfig(
            muscleId: 'front_right_adductor_magnus',
            color: Colors.yellow.shade700),
        MuscleColorConfig(
            muscleId: 'front_left_adductor_magnus',
            color: Colors.yellow.shade700),
      ],
      'back': [
        MuscleColorConfig(
            muscleId: 'upper_left_back', color: Colors.green.shade700),
        MuscleColorConfig(
            muscleId: 'upper_right_back', color: Colors.green.shade700),
        MuscleColorConfig(
            muscleId: 'back_upper_back', color: Colors.green.shade500),
        MuscleColorConfig(
            muscleId: 'back_left_buttocks', color: Colors.lightGreen.shade600),
        MuscleColorConfig(
            muscleId: 'back_right_buttocks', color: Colors.lightGreen.shade600),
      ],
    },
  };

  List<MuscleColorConfig> get _currentColorConfigs {
    final view = _isFrontView ? 'front' : 'back';
    return _heatmapPresets[_selectedPreset]?[view] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Muscle Heatmap Demo'),
        actions: [
          IconButton(
            icon: Icon(_isFrontView ? Icons.person : Icons.person_outline),
            onPressed: () {
              setState(() {
                _isFrontView = !_isFrontView;
              });
            },
            tooltip:
                _isFrontView ? 'Switch to Back View' : 'Switch to Front View',
          ),
        ],
      ),
      body: Column(
        children: [
          // Preset selector
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Heatmap Preset:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(
                      value: 'workout_intensity',
                      label: Text('Workout'),
                      icon: Icon(Icons.fitness_center, size: 16),
                    ),
                    ButtonSegment(
                      value: 'soreness_map',
                      label: Text('Soreness'),
                      icon: Icon(Icons.healing, size: 16),
                    ),
                    ButtonSegment(
                      value: 'recovery_status',
                      label: Text('Recovery'),
                      icon: Icon(Icons.spa, size: 16),
                    ),
                  ],
                  selected: {_selectedPreset},
                  onSelectionChanged: (Set<String> newSelection) {
                    setState(() {
                      _selectedPreset = newSelection.first;
                    });
                  },
                ),
              ],
            ),
          ),

          // View toggle
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _isFrontView = !_isFrontView;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _isFrontView ? Colors.blue : Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                _isFrontView ? 'Front View' : 'Back View',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Muscle map with custom colors
          Expanded(
            child: MusclePickerMap(
              key: ValueKey('${_isFrontView}_$_selectedPreset'),
              map: _isFrontView ? Maps.BODY_FRONT : Maps.BODY_BACK,
              isEditing: false, // Disable editing for heatmap view
              muscleColorConfigs: _currentColorConfigs,
              onChanged: (_) {}, // No-op since editing is disabled
              strokeColor: Colors.white,
            ),
          ),

          // Legend
          Container(
            padding: const EdgeInsets.all(16.0),
            child: _buildLegend(),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    Map<String, Color> legendItems;

    switch (_selectedPreset) {
      case 'workout_intensity':
        legendItems = {
          'High Intensity': Colors.red.shade700,
          'Medium Intensity': Colors.orange.shade600,
          'Low Intensity': Colors.yellow.shade700,
        };
        break;
      case 'soreness_map':
        legendItems = {
          'Very Sore': Colors.red.shade900,
          'Moderately Sore': Colors.orange.shade700,
          'Slightly Sore': Colors.yellow.shade600,
        };
        break;
      case 'recovery_status':
        legendItems = {
          'Fully Recovered': Colors.green.shade700,
          'Mostly Recovered': Colors.green.shade500,
          'Recovering': Colors.lightGreen.shade600,
          'Needs Rest': Colors.yellow.shade700,
        };
        break;
      default:
        legendItems = {};
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Legend:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: legendItems.entries.map((entry) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: entry.value,
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 6),
                Text(entry.key),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
