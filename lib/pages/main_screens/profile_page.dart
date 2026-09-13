import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meditator/models/meditation_exercise_model.dart';
import 'package:meditator/models/mindfulness_exercise_model.dart';
import 'package:meditator/models/sleep_exercise_model.dart';
import 'package:meditator/providers/custom_data_provider.dart';
import 'package:meditator/utils/colors.dart';
import 'package:meditator/utils/text_styles.dart';

class ProfilePage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile Page",
          style: TextStyle(
            color: AppColors.kPrimaryBlue,
            fontSize: 29,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Here are your custom exercises",
              style: TextStyle(
                color: AppColors.kPrimaryGreen,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              flex: 1,
              child: ListView(
                children: [
                  _buildSectionTitle("Meditation Exercise"),
                  _buildMeditationExerciseList(),
                  const SizedBox(height: 15),
                  _buildSectionTitle("Mindfulness Exercise"),
                  _buildMisndfulnessExerciseList(),
                  const SizedBox(height: 15),
                  _buildSectionTitle("Sleep Exercise"),
                  _buildSleepExercise(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: (AppTextStyle.titleStyle));
  }

  Widget _buildMeditationExerciseList() {
    final List<MeditationExercise> meditationExerciseList = CustomDataProvider()
        .getMeditationExercises();

    return Column(
      children: meditationExerciseList.map((meditation) {
        return _buildContentTile(
          name: meditation.name,
          description: meditation.description,
          duration: meditation.duration,
        );
      }).toList(),
    );
  }

  Widget _buildMisndfulnessExerciseList() {
    final List<MindfulnessExercise> mindfullExerciseList = CustomDataProvider()
        .getMindfulnessExercise();
    return Column(
      children: mindfullExerciseList.map((item) {
        return _buildContentTile(
          name: item.name,
          description: item.description,
          duration: item.duration,
        );
      }).toList(),
    );
  }

  Widget _buildSleepExercise() {
    final List<SleepExerciseModel> sleepExerciseList = CustomDataProvider()
        .getSleepExercise();

    return Column(
      children: sleepExerciseList.map((item) {
        return _buildContentTile(
          name: item.name,
          description: item.description,
          duration: item.duration,
        );
      }).toList(),
    );
  }

  Widget _buildContentTile({
    required String name,
    required String description,
    required int duration,
  }) {
    return Card(
      child: ListTile(
        title: Text(
          name,
          style: TextStyle(
            color: AppColors.kPrimaryDarkBlue.withValues(alpha: 0.8),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            color: AppColors.kPrimaryBlackColor.withValues(alpha: 0.4),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          "$duration min",
          style: const TextStyle(
            color: AppColors.kPrimaryDarkBlue,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
