import 'package:flutter/material.dart';
import 'package:meditator/models/sleep_exercise_model.dart';
import 'package:meditator/providers/custom_data_provider.dart';
import 'package:meditator/utils/colors.dart';
import 'package:meditator/utils/text_styles.dart';
import 'package:provider/provider.dart';

class SleepExerciseTab extends StatelessWidget {
  const SleepExerciseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Consumer<CustomDataProvider>(
              builder:
                  (
                    BuildContext context,
                    CustomDataProvider sleepData,
                    Widget? child,
                  ) {
                    final List<SleepExerciseModel> sleepExerciseList = sleepData
                        .getSleepExercise();
                    return ListView.builder(
                      itemCount: sleepExerciseList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        SleepExerciseModel sleepExercise =
                            sleepExerciseList[index];
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
                                  sleepExercise.name,
                                  style: AppTextStyle.titleStyle,
                                ),
                                IconButton(
                                  onPressed: () {
                                    sleepData.deleteSleepExercise(
                                      sleepExercise,
                                      context,
                                    );
                                  },
                                  icon: const Icon(Icons.delete, size: 30),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              sleepExercise.description,
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
