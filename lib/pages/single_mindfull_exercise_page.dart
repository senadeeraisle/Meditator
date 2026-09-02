import 'package:flutter/material.dart';
import 'package:meditator/models/mindfulness_exercise_model.dart';
import 'package:meditator/utils/colors.dart';
import 'package:meditator/utils/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleMindfullExercisePage extends StatelessWidget {
  final MindfulnessExercise mindfullExercise;
  const SingleMindfullExercisePage({super.key, required this.mindfullExercise});
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw "error on loading $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mindfull Exercise Page",
          style: TextStyle(
            fontSize: 29,
            color: AppColors.kPrimaryBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),

              Text(
                mindfullExercise.name,
                style: AppTextStyle.titleStyle.copyWith(
                  color: AppColors.kPrimaryDarkBlue,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                mindfullExercise.category,
                style: AppTextStyle.titleStyle.copyWith(
                  color: AppColors.kPrimaryBlackColor.withValues(alpha: 0.6),
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                mindfullExercise.description,
                style: AppTextStyle.titleStyle.copyWith(
                  color: AppColors.kPrimaryBlackColor.withValues(alpha: 0.8),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Instructions",
                style: AppTextStyle.titleStyle.copyWith(
                  color: AppColors.kPrimaryDeepDarkBlue.withValues(alpha: 0.5),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 15),
              ...mindfullExercise.instructions.map(
                (mindfullExercixe) => Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.circle, size: 10),
                      const SizedBox(width: 8),
                      Expanded(child: Text(mindfullExercixe)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.timer, color: AppColors.kPrimaryGrey),
                  const SizedBox(width: 4),
                  Text(
                    "${mindfullExercise.duration.toString()} minutes",
                    style: AppTextStyle.bodyStyle,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: const ButtonStyle(
                  elevation: WidgetStatePropertyAll<double>(0),
                  shadowColor: WidgetStatePropertyAll<Color>(
                    Colors.transparent,
                  ),
                  backgroundColor: WidgetStatePropertyAll<Color>(
                    AppColors.kPrimaryBlue,
                  ),
                ),
                onPressed: () async {
                  await _launchUrl(mindfullExercise.instructionsUrl);
                },
                child: Text(
                  "View detailed instructions",
                  style: AppTextStyle.subTitleStyle.copyWith(
                    color: AppColors.kPrimaryWhiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
