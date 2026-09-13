import 'package:flutter/material.dart';
import 'package:meditator/models/mindfulness_exercise_model.dart';
import 'package:meditator/providers/custom_data_provider.dart';
import 'package:meditator/utils/colors.dart';
import 'package:meditator/utils/text_styles.dart';
import 'package:provider/provider.dart';

class MindfulnessTab extends StatelessWidget {
  const MindfulnessTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Consumer<CustomDataProvider>(
              builder:
                  (
                    BuildContext contsxt,
                    CustomDataProvider mindfullData,
                    Widget? child,
                  ) {
                    final List<MindfulnessExercise> midfulnessExercises = mindfullData
                        .getMindfulnessExercise();
                    return ListView.builder(
                      itemCount: midfulnessExercises.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        MindfulnessExercise mindfullExercise =
                            midfulnessExercises[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.kPrimaryGrey.withValues(
                              alpha: 0.2,
                            ),
                          ),
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  mindfullExercise.name,
                                  style: AppTextStyle.titleStyle,
                                ),
                                IconButton(
                                  onPressed: () {
                                    mindfullData.deleteMindfulnessExecise(
                                      mindfullExercise,
                                      context,
                                    );
                                  },
                                  icon: const Icon(Icons.delete, size: 30),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              mindfullExercise.description,
                              style: AppTextStyle.subTitleStyle,
                            ),
                          ),
                        );
                      },
                    );
                  },
            ),
          ],
        ),
      ),
    );
  }
}
