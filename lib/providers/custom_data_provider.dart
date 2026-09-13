import 'package:flutter/material.dart';
import 'package:meditator/models/meditation_exercise_model.dart';
import 'package:meditator/models/mindfulness_exercise_model.dart';
import 'package:meditator/models/sleep_exercise_model.dart';
import 'package:meditator/services/meditation_service.dart';
import 'package:meditator/services/mindfulness_exercise_service.dart';
import 'package:meditator/services/sleep_exercise_service.dart';

class CustomDataProvider extends ChangeNotifier {
  final List<MeditationExercise> _allMeditations = [];
  final List<SleepExerciseModel> _allSleepExercise = [];
  final List<MindfulnessExercise> _allMindfulnessExercise = [];

  List<MeditationExercise> get meditations => _allMeditations;
  List<SleepExerciseModel> get sleepExercise => _allSleepExercise;
  List<MindfulnessExercise> get mindfulnessExercise => _allMindfulnessExercise;

  //method to add meditation
  void addMeditation(MeditationExercise meditation, BuildContext context) {
    try {
      _allMeditations.add(meditation);
      try {
        MeditationServices().addMeditation(meditation, context);
      } catch (error) {
        print('provider local storage error $error');
      }
      notifyListeners();
    } catch (error) {
      print('provider error $error');
    }
  }
  //method to add Sleep Exercise with converting to List of map

  void addSleepExercise(
    SleepExerciseModel sleepExercise,
    BuildContext context,
  ) {
    try {
      _allSleepExercise.add(sleepExercise);
      try {
        SleepExerciseService().addSleepExercise(sleepExercise, context);
      } catch (error) {
        print("provider local storage error: $error");
      }
      notifyListeners();
    } catch (error) {
      print("Provider error: $error");
    }
  }

  /*method to add Sleep Exercise with sleep exercise objects
  void addSleepExercise1(
    SleepExerciseModel sleepExercise,
    BuildContext context,
  ) {
    try {
      _allSleepExercise.add(sleepExercise);
      try {
        SleepExerciseService().addSleepExercise(sleepExercise, context);
      } catch (error) {
        print("Provider service error $error");
      }

      notifyListeners();
    } catch (error) {
      print("Provider error $error");
    }
  }*/

  //method to add mindfulnessExercise

  void addmidFulnessExercise(
    MindfulnessExercise mindfulnessExercise,
    BuildContext context,
  ) {
    try {
      _allMindfulnessExercise.add(mindfulnessExercise);

      try {
        MindfulnessExerciseService().addMindfulnessExercise(
          mindfulnessExercise,
          context,
        );
      } catch (error) {
        print('provider service error: $error');
      }
      notifyListeners();
    } catch (error) {
      print('Provider error: $error');
    }
  }

  // --GET--

  // get all meditation exercises

  List<MeditationExercise> getMeditationExercises() {
    try {
      final dynamic allMeditationExercise = MeditationServices()
          .getMeditationExercise();
      return allMeditationExercise;
    } catch (error) {
      print('provider error on meditation: $error');
      return [];
    }
  }
  // get all mindfulness exercises

  List<MindfulnessExercise> getMindfulnessExercise() {
    try {
      final dynamic allMindfulnessExercise = MindfulnessExerciseService()
          .getMidfulnessExecise();

      return allMindfulnessExercise;
    } catch (error) {
      print('provider error o getting mindfulness $error');
      return [];
    }
  }

  // get all sleep exercises
  List<SleepExerciseModel> getSleepExercise() {
    try {
      final dynamic allSleepExercise = SleepExerciseService()
          .getSleepExercise();
      return allSleepExercise;
    } catch (error) {
      print('provider error on getting sleep exercise: $error');
      return [];
    }
  }

  // --DELETE EXERCISE--

  //delete meditation exercise
  void deleteMeditationExercise(
    MeditationExercise meditationExercise,
    BuildContext context,
  ) {
    try {
      _allMeditations.remove(meditationExercise);
      try {
        MeditationServices().deleteMediatation(meditationExercise, context);
      } catch (error) {
        print('provider service error: $error');
      }
      notifyListeners();
    } catch (error) {
      print('provider error on deleting meditation: $error');
    }
  }

  //delete mindfulness exercise

  void deleteMindfulnessExecise(
    MindfulnessExercise mindfulnessExercise,
    BuildContext context,
  ) {
    try {
      _allMindfulnessExercise.remove(mindfulnessExercise);

      try {
        MindfulnessExerciseService().deleteMindfulnessExercise(
          mindfulnessExercise,
          context,
        );
      } catch (error) {
        print('provider local storage error: $error');
      }
      notifyListeners();
    } catch (error) {
      print('provider error on deleting mindfulness exercise: $error');
    }
  }

  //delete sleep exercise

  void deleteSleepExercise(
    SleepExerciseModel sleepExercise,
    BuildContext context,
  ) {
    try {
      _allSleepExercise.remove(sleepExercise);

      try {
        SleepExerciseService().deleteSleepExercise(sleepExercise, context);
      } catch (error) {
        print('provider local storage error: $error');
      }
      notifyListeners();
    } catch (error) {
      print('provider error on deleting sleep exercise: $error');
    }
  }
}
