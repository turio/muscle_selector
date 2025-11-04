import 'package:flutter/material.dart';
import 'package:muscle_selector/muscle_selector.dart';
import 'package:provider/provider.dart';
import 'muscle_selector_provider.dart';
import 'muscle_heatmap_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MuscleSelectorProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Muscle Selector',
        home: const MuscleSelectionScreen(),
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
          ),
        ),
      ),
    );
  }
}

class MuscleSelectionScreen extends StatelessWidget {
  const MuscleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Muscle View'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MuscleView(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Muscle Selector',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MuscleHeatmapScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Muscle Heatmap Demo',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MuscleView extends StatelessWidget {
  const MuscleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Muscle Selector'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              context.read<MuscleSelectorProvider>().clearAllSelections();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Toggle button for front/back view
          Consumer<MuscleSelectorProvider>(
            builder: (context, provider, child) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    provider.toggleView();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        provider.isFrontView ? Colors.blue : Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    provider.isFrontView ? 'Front View' : 'Back View',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
          Consumer<MuscleSelectorProvider>(
            builder: (context, provider, child) {
              return MusclePickerMap(
                key: ValueKey(
                    provider.isFrontView), // Use ValueKey to force rebuild
                map: provider.isFrontView ? Maps.BODY_FRONT : Maps.BODY_BACK,
                isEditing: true,
                initialSelectedMuscles: provider.selectedMuscles,
                onChanged: (muscles) {
                  provider.setSelectedMuscles(muscles);
                },
                actAsToggle: true,
                dotColor: Colors.white,
                selectedColor: Colors.red,
                strokeColor: Colors.white,
              );
            },
          ),
          // Display selected muscles grouped by label
          Consumer<MuscleSelectorProvider>(
            builder: (context, provider, child) {
              final muscles = provider.selectedMuscles;
              if (muscles.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'No muscles selected',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              }

              // Group muscles by their display label to avoid duplicates
              final Map<String, List<Muscle>> groupedMuscles = {};
              for (var muscle in muscles) {
                final label = muscle.title;
                if (!groupedMuscles.containsKey(label)) {
                  groupedMuscles[label] = [];
                }
                groupedMuscles[label]!.add(muscle);
              }

              return Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Selected Muscles:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: groupedMuscles.entries.map((entry) {
                        final label = entry.key;
                        final musclesInGroup = entry.value;
                        return Chip(
                          label: Text(label),
                          backgroundColor: Colors.red.withValues(alpha: 0.1),
                          deleteIcon: const Icon(Icons.close, size: 18),
                          onDeleted: () {
                            // Remove all muscles with this label and their pairs
                            var updatedMuscles = muscles.toSet();
                            for (var muscle in musclesInGroup) {
                              updatedMuscles.remove(muscle);
                              // Also remove the paired muscle if it exists
                              final pairedId =
                                  Parser.getPairedMuscleId(muscle.id);
                              if (pairedId != null) {
                                updatedMuscles
                                    .removeWhere((m) => m.id == pairedId);
                              }
                            }
                            provider.setSelectedMuscles(updatedMuscles);
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
