import 'package:flutter/material.dart';
import 'package:meditator/models/meditation_exercise_model.dart';
import 'package:meditator/providers/custom_data_provider.dart';
import 'package:meditator/utils/colors.dart';
import 'package:meditator/utils/text_styles.dart';
import 'package:provider/provider.dart';

class MeditationTab extends StatelessWidget {
  const MeditationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Consumer<CustomDataProvider>(
              builder: (contsxt, meditationData, child) {
                final List<MeditationExercise> meditations = meditationData
                    .getMeditationExercises();
                return ListView.builder(
                  itemCount: meditations.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    MeditationExercise meditation = meditations[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: AppColors.kPrimaryGrey.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              meditation.name,
                              style: AppTextStyle.titleStyle,
                            ),
                            IconButton(
                              onPressed: () {
                                meditationData.deleteMeditationExercise(
                                  meditation,
                                  context,
                                );
                              },
                              icon: const Icon(Icons.delete, size: 30),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          meditation.description,
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
