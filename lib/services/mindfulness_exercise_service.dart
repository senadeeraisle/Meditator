import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meditator/models/mindfulness_exercise_model.dart';

class MindfulnessExerciseService {
  final midfulnessExerciseBox = Hive.box('mindfulness_data');

  //method to add mindFulnessExercise

  Future<void> addMindfulnessExercise(
    MindfulnessExercise mindfulnessExercise,
    BuildContext context,
  ) async {
    try {
      final dynamic allMindfulnessExercise =
          midfulnessExerciseBox.get('mindfulness_data') ?? [];

      allMindfulnessExercise.add(mindfulnessExercise);

      await midfulnessExerciseBox.put(
        'mindfulness_data',
        allMindfulnessExercise,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mindfulness Exercise added successfully'),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error adding Mindfulness Exercise')),
      );
      print('Service error $error');
    }
  }

  //method to get all mindfulnessExercise

  List<MindfulnessExercise> getMidfulnessExecise() {
    try {
      final dynamic allmindfulnessexercise = midfulnessExerciseBox.get(
        'mindfulness_data',
      );

      if (allmindfulnessexercise != null &&
          allmindfulnessexercise is List<dynamic>) {
        return allmindfulnessexercise.cast<MindfulnessExercise>().toList();
      } else {
        return [];
      }
    } catch (error) {
      print('get service error');
      return [];
    }
  }

  //method to delete a mindfulness exercise

  Future<void> deleteMindfulnessExercise(
    MindfulnessExercise mindfulnessExercise,
    BuildContext context,
  ) async {
    try {
      final dynamic allmindfulnessExercise = midfulnessExerciseBox.get(
        'mindfulness_data',
      );

      allmindfulnessExercise.remove(mindfulnessExercise);

      await midfulnessExerciseBox.put(
        'mindfulness_data',
        allmindfulnessExercise,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Exercise deleted successfully')),
      );
    } catch (error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Error deleting exercise')));
      print('delete provider error$error');
    }
  }
}
