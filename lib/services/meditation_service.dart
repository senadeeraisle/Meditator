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
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Meditation Added')));
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error on adding Meditation')),
        );
      }
      print('add meditation service error $error');
    }
  }

  List<MeditationExercise> getMeditationExercise() {
    try {
      final dynamic allMeditationExercise = meditationBox.get(
        'meditation_data',
      );

      if (allMeditationExercise != null && allMeditationExercise is List) {
        return allMeditationExercise.map((meditation) {
          if (meditation is Map<String, dynamic>) {
            return MeditationExercise.fromJson(meditation);
          } else {
            return MeditationExercise.fromJson(
              Map<String, dynamic>.from(meditation),
            );
          }
        }).toList();
      } else {
        return [];
      }
    } catch (error, stackTrace) {
      print("get meditation Service error: $error");
      print(stackTrace);
      return [];
    }
  }

  //method to delete an meditation exercise

  Future<void> deleteMediatation(
    MeditationExercise meditationExercise,
    BuildContext context,
  ) async {
    try {
      final dynamic allMeditation = meditationBox.get('meditation_data');
      if (allMeditation != null || allMeditation is List) {
        List<Map<String, dynamic>> meditationList =
            List<Map<String, dynamic>>.from(
              allMeditation.map(
                (aMeditation) => Map<String, dynamic>.from(aMeditation),
              ),
            );

        meditationList.removeWhere((aMeditation) {
          MeditationExercise currentMeditation = MeditationExercise.fromJson(
            Map<String, dynamic>.from(aMeditation),
          );
          return currentMeditation.name == meditationExercise.name &&
              currentMeditation.category == meditationExercise.category;
        });

        await meditationBox.put('meditation_data', meditationList);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Meditation deleted successfully")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error deleting the meditation")),
      );
      print("Service error $error");
    }
  }
}
