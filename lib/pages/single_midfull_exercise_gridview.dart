import 'package:flutter/material.dart';
import 'package:meditator/models/mindfulness_exercise_model.dart';
import 'package:meditator/utils/colors.dart';
import 'package:meditator/utils/text_styles.dart';

class SingleMidfullExerciseGridview extends StatelessWidget {
  final MindfulnessExercise mindfullexercise;
  const SingleMidfullExerciseGridview({
    super.key,
    required this.mindfullexercise,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          mindfullexercise.name,
          style: const TextStyle(
            fontSize: 24,
            color: AppColors.kPrimaryBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mindfullexercise.category,
                  style: AppTextStyle.subTitleStyle.copyWith(
                    color: AppColors.kPrimaryGreen,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  mindfullexercise.name,
                  style: const TextStyle(
                    fontSize: 20,
                    color: AppColors.kPrimaryBlackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Duration: ${mindfullexercise.duration} min",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.kPrimaryBlackColor.withValues(alpha: 0.7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  mindfullexercise.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.kPrimaryGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Instructions: ",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.kPrimaryBlackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                ...mindfullexercise.instructions.map(
                  (toElement) => Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            shape: BoxShape.rectangle,
                            color: AppColors.kPrimaryGreen.withValues(
                              alpha: 0.4,
                            ),
                            border: Border.all(
                              width: 2,
                              color: AppColors.kPrimaryGreen,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              toElement,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
