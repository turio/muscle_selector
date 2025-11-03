import 'package:flutter/material.dart';
import 'package:muscle_selector/muscle_selector.dart';
import 'package:muscle_selector/src/parser.dart';

class SelectedMusclesChips extends StatelessWidget {
  final Set<Muscle> selectedMuscles;
  final Function(Muscle) onMuscleRemoved;

  const SelectedMusclesChips({
    Key? key,
    required this.selectedMuscles,
    required this.onMuscleRemoved,
  }) : super(key: key);

  Map<String, List<Muscle>> _groupSelectedMuscles() {
    Map<String, List<Muscle>> groupedMuscles = {};

    // Group muscles by their display label (title) to avoid duplicates
    for (var muscle in selectedMuscles) {
      final label = muscle.title;
      if (!groupedMuscles.containsKey(label)) {
        groupedMuscles[label] = [];
      }
      groupedMuscles[label]!.add(muscle);
    }

    return groupedMuscles;
  }

  @override
  Widget build(BuildContext context) {
    final groupedMuscles = _groupSelectedMuscles();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: groupedMuscles.entries.map((entry) {
          final muscles = entry.value;
          final firstMuscle = muscles.first;
          return Chip(
            label: Text(
              firstMuscle.title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            deleteIcon: const Icon(Icons.close, size: 18),
            onDeleted: () {
              // Remove all muscles in the group and their pairs
              for (var muscle in muscles) {
                onMuscleRemoved(muscle);
                // Also remove the paired muscle if it exists
                final pairedId = Parser.getPairedMuscleId(muscle.id);
                if (pairedId != null) {
                  // Find and remove the paired muscle
                  final pairedMuscle = selectedMuscles.firstWhere(
                    (m) => m.id == pairedId,
                    orElse: () => muscle,
                  );
                  if (pairedMuscle.id == pairedId) {
                    onMuscleRemoved(pairedMuscle);
                  }
                }
              }
            },
            backgroundColor:
                Theme.of(context).primaryColor.withValues(alpha: 0.1),
            labelPadding: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(horizontal: 4),
          );
        }).toList(),
      ),
    );
  }
}
