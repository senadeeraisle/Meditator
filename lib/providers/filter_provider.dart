import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meditator/models/mindfulness_exercise_model.dart';
import 'package:meditator/models/sleep_exercise_model.dart';
import 'package:meditator/providers/midfulness_exercise_provider.dart';
import 'package:meditator/providers/sleep_exercise_provider.dart';
import 'package:meditator/models/meditation_exercise_model.dart';
import 'package:meditator/providers/meditation_provider.dart';

class FilterProvider extends ChangeNotifier {
  List<dynamic> _allData = [];
  List<dynamic> _filteredData = [];

  //get all data from other providers
  Future<void> getData(BuildContext context) async {
    //ensure this runs after build
    await Future.delayed(Duration.zero);

    //meditation exercises
    final List<MeditationExercise> meditationExercise =
        Provider.of<MeditationProvider>(context).meditationExercises;

    //mindfulness exercises
    final List<MindfulnessExercise> mindFulnessexercise =
        Provider.of<MidfulnessExerciseProvider>(context).midfulnessExercises;
    //sleep exercises
    final List<SleepExerciseModel> sleepExercise =
        Provider.of<SleepExerciseProvider>(context).allSleepExercises;

    _allData = [
      ...meditationExercise,
      ...mindFulnessexercise,
      ...sleepExercise,
    ];

    _filteredData = _allData;

    notifyListeners();
  }

  List<dynamic> get filteredData => _filteredData;
}
