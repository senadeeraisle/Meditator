import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meditator/models/sleep_exercise_model.dart';

class SleepExerciseService {
  var sleepExerciseBox = Hive.box('sleep_exercise_data');

  // method to add data
  Future<void> addSleepExercise(
    SleepExerciseModel sleepExercise,
    BuildContext context,
  ) async {
    try {
      final dynamic allSleepExercise = sleepExerciseBox.get(
        'sleep_exercise_data',
      );
      List<Map<String, dynamic>> sleepExerciseList = [];
      if (allSleepExercise != null && allSleepExercise is List) {
        sleepExerciseList = List<Map<String, dynamic>>.from(
          allSleepExercise.map(
            (sleepExercise) => Map<String, dynamic>.from(sleepExercise),
          ),
        );
      }

      sleepExerciseList.add(sleepExercise.tojson());
      await sleepExerciseBox.put("sleep_exercise_data", sleepExerciseList);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Sleep Exercise added succussfully")),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error on adding Sleep Exercise")),
        );
      }
      print("service error $error");
    }
  }

  /*Future<void> addSleepExercise1(
    SleepExerciseModel sleepExercise,
    BuildContext context,
  ) async {
    try {
      final dynamic allExercise =
          sleepExerciseBox.get('sleep_exercise_data') ?? [];
      allExercise.add(sleepExercise);
      await sleepExerciseBox.put('sleep_exercise_data', allExercise);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sleep Exercise added succussfully")),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error on adding Sleep Exercise")),
      );
      print('Service error $error');
    }
  }*/

  //method to get all sleep exercise

  List<SleepExerciseModel> getSleepExercise() {
    try {
      final dynamic allSleepExercise = sleepExerciseBox.get(
        'sleep_exercise_data',
      );
      if (allSleepExercise != null && allSleepExercise is List) {
        return allSleepExercise.map((item) {
          if (item is Map<String, dynamic>) {
            return SleepExerciseModel.fromJson(item);
          } else {
            return SleepExerciseModel.fromJson(Map<String, dynamic>.from(item));
          }
        }).toList();
      } else {
        return [];
      }
    } catch (error) {
      print('get sleep exercise service error $error');
      return [];
    }
  }

  // method to delete a sleep exercise

  Future<void> deleteSleepExercise(
    SleepExerciseModel sleepExercise,
    BuildContext context,
  ) async {
    try {
      final dynamic allSleepExercise = sleepExerciseBox.get(
        'sleep_exercise_data',
      );
      if (allSleepExercise != null && allSleepExercise is List) {
        List<Map<String, dynamic>> sleepExerciseList =
            List<Map<String, dynamic>>.from(
              allSleepExercise.map((item) => Map<String, dynamic>.from(item)),
            );

        sleepExerciseList.removeWhere((item) {
          SleepExerciseModel currentSleepExercise = SleepExerciseModel.fromJson(
            Map<String, dynamic>.from(item),
          );
          return currentSleepExercise.name == sleepExercise.name &&
              currentSleepExercise.category == sleepExercise.category;
        });
        await sleepExerciseBox.put('sleep_exercise_data', sleepExerciseList);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Exercise deleted successfully")),
      );
    } catch (error) {
      print('service error deleting sleep exercise: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error on deleting exercise")),
      );
    }
  }
}
