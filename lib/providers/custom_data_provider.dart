import 'package:flutter/material.dart';
import 'package:meditator/models/meditation_exercise_model.dart';
import 'package:meditator/services/meditation_service.dart';

class CustomDataProvider extends ChangeNotifier {
  final List<MeditationExercise> _allMeditations = [];
  List<MeditationExercise> get meditations => _allMeditations;

  //method to add meditation
  void addMeditation(
    MeditationExercise meditation,
    BuildContext context,
  ) async {
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
}
