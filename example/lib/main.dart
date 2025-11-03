import 'package:flutter/material.dart';
import 'package:muscle_selector/muscle_selector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Muscle Selector Demo',
      home: const HomeView(),
      theme: ThemeData.light(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Set<Muscle>? selectedMuscles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Muscle Selector'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              setState(() {
                selectedMuscles = null;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Muscle Picker Map
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: SizedBox(
                height: 400,
                child: MusclePickerMap(
                  map: Maps.BODY,
                  isEditing: true,
                  width: 300,
                  height: 400,
                  onChanged: (muscles) {
                    setState(() {
                      selectedMuscles = muscles;
                    });
                  },
                  actAsToggle: true,
                  dotColor: Colors.black,
                  selectedColor: Colors.lightBlueAccent,
                  strokeColor: Colors.black,
                ),
              ),
            ),
          ),
          // Selected Muscles Display
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border(top: BorderSide(color: Colors.grey[300]!)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.fitness_center, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        'Selected Muscles',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                      ),
                      const Spacer(),
                      if (selectedMuscles != null &&
                          selectedMuscles!.isNotEmpty)
                        Chip(
                          label: Text('${selectedMuscles!.length}'),
                          backgroundColor: Colors.blue[100],
                          labelStyle: TextStyle(
                            color: Colors.blue[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: selectedMuscles == null || selectedMuscles!.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.touch_app,
                                  size: 48,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Tap on the body to select muscles',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SingleChildScrollView(
                            child: Wrap(
                              spacing: 8.0,
                              runSpacing: 8.0,
                              children: selectedMuscles!.map((muscle) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent.withValues(
                                      alpha: 0.2,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.lightBlueAccent,
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.radio_button_checked,
                                        size: 16,
                                        color: Colors.lightBlueAccent[700],
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        muscle.title,
                                        style: TextStyle(
                                          color: Colors.lightBlueAccent[700],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
