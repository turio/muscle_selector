import 'package:flutter/material.dart';
import 'package:muscle_selector/muscle_selector.dart';
import 'package:muscle_selector/src/widgets/muscle_painter.dart';
import '../parser.dart';
import '../size_controller.dart';

class MusclePickerMap extends StatefulWidget {
  final double? width;
  final double? height;
  final String map;
  final Function(Set<Muscle> muscles) onChanged;
  final Color? strokeColor;
  final Color? selectedColor;
  final Color? dotColor;
  final bool? actAsToggle;
  final bool? isEditing;
  final Set<Muscle>? initialSelectedMuscles;
  final List<String>? initialSelectedGroups;
  final List<MuscleColorConfig>? muscleColorConfigs;

  const MusclePickerMap({
    Key? key,
    required this.map,
    required this.onChanged,
    this.width,
    this.height,
    this.strokeColor,
    this.selectedColor,
    this.dotColor,
    this.actAsToggle,
    this.isEditing = true,
    this.initialSelectedMuscles,
    this.initialSelectedGroups,
    this.muscleColorConfigs,
  }) : super(key: key);

  @override
  MusclePickerMapState createState() => MusclePickerMapState();
}

class MusclePickerMapState extends State<MusclePickerMap> {
  final List<Muscle> _muscleList = [];
  Set<Muscle> _selectedMuscles = {};
  Map<String, Color> _customMuscleColors = {};

  final _sizeController = SizeController.instance;
  Size? mapSize;

  @override
  void initState() {
    super.initState();
    // Don't copy initialSelectedMuscles here - will be filtered in _initializeSelectedMuscles
    _initializeCustomColors();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadMuscleList();
    });
  }

  void _initializeCustomColors() {
    if (widget.muscleColorConfigs != null) {
      _customMuscleColors = {
        for (var config in widget.muscleColorConfigs!)
          config.muscleId: config.color
      };
    }
  }

  Future<void> _loadMuscleList() async {
    try {
      final list = await Parser.instance.svgToMuscleList(widget.map);
      _muscleList.clear();
      setState(() {
        _muscleList.addAll(list);
        mapSize = _sizeController.mapSize;
        _initializeSelectedMuscles();
      });
    } catch (e) {
      debugPrint('Error loading muscles: $e');
    }
  }

  void _initializeSelectedMuscles() {
    if (widget.isEditing == true) {
      // Filter initialSelectedMuscles to only include muscles that exist in current view
      if (widget.initialSelectedMuscles != null) {
        final muscleIdsInCurrentView = _muscleList.map((m) => m.id).toSet();
        final filteredMuscles = widget.initialSelectedMuscles!
            .where((m) => muscleIdsInCurrentView.contains(m.id))
            .toSet();
        _selectedMuscles = filteredMuscles;
      } else if (widget.initialSelectedGroups != null &&
          widget.initialSelectedGroups!.isNotEmpty) {
        final groupMuscles = Parser.instance
            .getMusclesByGroups(widget.initialSelectedGroups!, _muscleList);
        _selectedMuscles.addAll(groupMuscles);
      }
      // Don't call onChanged during initialization to preserve parent's full selection
      // The parent already has the complete selection across both views
    }
  }

  void clearSelect() {
    setState(() {
      _selectedMuscles.clear();
    });
    widget.onChanged(_selectedMuscles);
  }

  void _handleMuscleTap(Muscle muscle) {
    if (widget.isEditing == false) return;

    final isSelected = _selectedMuscles.any((m) => m.id == muscle.id);
    Set<Muscle> newSelectedMuscles;

    if (isSelected) {
      // Deselect the muscle and its pair
      newSelectedMuscles =
          _selectedMuscles.where((m) => m.id != muscle.id).toSet();

      // Also deselect the paired muscle if it exists
      final pairedId = Parser.getPairedMuscleId(muscle.id);
      if (pairedId != null) {
        newSelectedMuscles =
            newSelectedMuscles.where((m) => m.id != pairedId).toSet();
      }
    } else {
      // Select the muscle
      newSelectedMuscles = {..._selectedMuscles, muscle};

      // Also select the paired muscle if it exists
      final pairedId = Parser.getPairedMuscleId(muscle.id);
      if (pairedId != null) {
        final pairedMuscle = _muscleList.firstWhere(
          (m) => m.id == pairedId,
          orElse: () => muscle, // Fallback to original if not found
        );
        if (pairedMuscle.id == pairedId) {
          newSelectedMuscles = {...newSelectedMuscles, pairedMuscle};
        }
      }
    }

    setState(() {
      _selectedMuscles = newSelectedMuscles;
    });

    widget.onChanged(newSelectedMuscles);
  }

  @override
  Widget build(BuildContext context) {
    if (_muscleList.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Handle infinite constraints by using a reasonable default size
        final width = widget.width ?? constraints.maxWidth;
        final height = widget.height ??
            (constraints.maxHeight.isInfinite ? 550.0 : constraints.maxHeight);

        return SizedBox(
          width: width,
          height: height,
          child: Center(
            child: Stack(
              children: [
                for (var muscle in _muscleList) _buildMuscleWidget(muscle),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMuscleWidget(Muscle muscle) {
    final isSelectable = !muscle.id.contains('outline') &&
        !muscle.id.contains('internal_structure') &&
        !muscle.id.contains('detail') &&
        !muscle.id.contains('accent') &&
        muscle.id != 'human_body' &&
        widget.isEditing == true;

    return Container(
      alignment: Alignment.center,
      child: GestureDetector(
        behavior: HitTestBehavior.deferToChild,
        onTap: isSelectable ? () => _handleMuscleTap(muscle) : null,
        child: CustomPaint(
          isComplex: true,
          foregroundPainter: MusclePainter(
            muscle: muscle,
            selectedMuscles:
                widget.isEditing == true ? _selectedMuscles : <Muscle>{},
            dotColor: widget.dotColor,
            selectedColor: widget.selectedColor,
            strokeColor: widget.strokeColor,
            customMuscleColors: _customMuscleColors,
          ),
          child: const SizedBox(
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}
