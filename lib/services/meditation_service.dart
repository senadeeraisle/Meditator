import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meditator/models/meditation_exercise_model.dart';

class MeditationServices {
  var meditationBox = Hive.box('meditation_data');

  Future<void> addMeditation(
    MeditationExercise meditation,
    BuildContext context,
  ) async {
    try {
      final dynamic allMeditation = meditationBox.get('meditation_data');
      List<Map<String, dynamic>> meditationList = [];
      if (allMeditation != null && allMeditation is List) {
        meditationList = List<Map<String, dynamic>>.from(
          allMeditation.map(
            (meditation) => Map<String, dynamic>.from(meditation),
          ),
        );
      }
      meditationList.add(meditation.toJson());
      await meditationBox.put('meditation_data', meditationList);

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Meditation Added')));
    } catch (error) {
      print('service error $error');
    }
  }
}
