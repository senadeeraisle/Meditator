import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:meditator/models/functions_model.dart';
import 'package:meditator/models/meditation_exercise_model.dart';
import 'package:meditator/models/mindfulness_exercise_model.dart';
import 'package:meditator/models/sleep_exercise_model.dart';
import 'package:meditator/providers/filter_provider.dart';
import 'package:meditator/router/route_names.dart';
import 'package:meditator/utils/colors.dart';
import 'package:meditator/utils/text_styles.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void handleMindfullExercisePressed(
    BuildContext context,
    MindfulnessExercise data,
  ) {
    GoRouter.of(context).pushNamed(
      RouteNames.mindFullExerciseGridview,
      queryParameters: {'mindfullexercise': jsonEncode(data.toJson())},
    );
  }

  void handleMeditationExercisePressed({
    required BuildContext context,
    required String name,
    required String category,
    required String description,
    required int duration,
    required String videoUrl,
  }) {
    showModalBottomSheet(
      backgroundColor: AppColors.kPrimaryWhiteColor,
      context: context,
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyle.titleStyle.copyWith(
                    fontSize: 24,
                    color: AppColors.kPrimaryDarkBlue,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  category,
                  style: AppTextStyle.titleStyle.copyWith(
                    color: AppColors.kPrimaryGrey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: AppTextStyle.titleStyle.copyWith(
                    color: AppColors.kPrimaryBlackColor.withValues(alpha: 0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "${duration.toString()} min",
                  style: AppTextStyle.titleStyle.copyWith(
                    color: AppColors.kPrimaryBlue,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        elevation: const WidgetStatePropertyAll<double>(0),
                        backgroundColor: WidgetStatePropertyAll<Color>(
                          AppColors.kPrimaryBlue.withValues(alpha: 0.8),
                        ),
                      ),
                      onPressed: () {
                        GoRouter.of(context).pushNamed(
                          RouteNames.meditationExercisePage,
                          extra: FunctionsModel(
                            name: name,
                            category: category,
                            description: description,
                            duration: duration,
                            videoUrl: videoUrl,
                          ),
                        );
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Start",
                        style: AppTextStyle.subTitleStyle.copyWith(
                          color: AppColors.kPrimaryBlackColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: const ButtonStyle(
                        elevation: WidgetStatePropertyAll<double>(0),
                        backgroundColor: WidgetStatePropertyAll<Color>(
                          AppColors.kPrimaryGrey,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Close",
                        style: AppTextStyle.subTitleStyle.copyWith(
                          color: AppColors.kPrimaryBlackColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void handleSleepExercisePressed(
    BuildContext context,
    SleepExerciseModel data,
  ) {
    GoRouter.of(context).pushNamed(
      RouteNames.sleepExerciseTimer,
      queryParameters: {'sleep_exercise_timer': jsonEncode(data.tojson())},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: Provider.of<FilterProvider>(
            context,
            listen: false,
          ).getData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text("Error loading data"));
            }
            return Consumer<FilterProvider>(
              builder: (BuildContext context, FilterProvider filetrdata, Widget? child) {
                final completedData = filetrdata.filteredData;
                completedData.shuffle();
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Image.asset(
                              'assets/images/meditation_app_logo.png',
                              width: MediaQuery.of(context).size.width * 0.1,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Meditator',
                              style: TextStyle(
                                fontSize: 29,
                                fontWeight: FontWeight.bold,
                                color: AppColors.kPrimaryBlue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "Select a category to start exploring!",
                          style: AppTextStyle.subTitleStyle.copyWith(
                            color: AppColors.kPrimaryDeepDarkBlue,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.kPrimaryBlue.withValues(
                              alpha: 0.6,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  FilterChip(
                                    label: Text(
                                      "All",
                                      style: TextStyle(
                                        color:
                                            filetrdata.getSelectedCategory() ==
                                                "All"
                                            ? AppColors.kPrimaryWhiteColor
                                            : AppColors.kPrimaryBlackColor,
                                      ),
                                    ),
                                    onSelected: (bool value) {
                                      filetrdata.filterData(category: "All");
                                    },
                                    selected:
                                        filetrdata.getSelectedCategory() ==
                                        "All",
                                    selectedColor: AppColors.kPrimaryBlue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(8),
                                      side: const BorderSide(
                                        color: AppColors.kPrimaryDarkBlue,
                                        width: 2,
                                      ),
                                    ),
                                    showCheckmark: false,
                                  ),
                                  const SizedBox(width: 10),
                                  FilterChip(
                                    label: Text(
                                      "Meditation",
                                      style: TextStyle(
                                        color:
                                            filetrdata.getSelectedCategory() ==
                                                "Meditation"
                                            ? AppColors.kPrimaryWhiteColor
                                            : AppColors.kPrimaryBlackColor,
                                      ),
                                    ),
                                    onSelected: (bool value) {
                                      filetrdata.filterData(
                                        category: "Meditation",
                                      );
                                    },
                                    selected:
                                        filetrdata.getSelectedCategory() ==
                                        "Meditation",
                                    selectedColor: AppColors.kPrimaryBlue,
                                    showCheckmark: false,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(8),
                                      side: const BorderSide(
                                        color: AppColors.kPrimaryDarkBlue,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  FilterChip(
                                    label: Text(
                                      "Mindfulness",
                                      style: TextStyle(
                                        color:
                                            filetrdata.getSelectedCategory() ==
                                                "Mindfulness"
                                            ? AppColors.kPrimaryWhiteColor
                                            : AppColors.kPrimaryBlackColor,
                                      ),
                                    ),
                                    onSelected: (bool value) {
                                      filetrdata.filterData(
                                        category: "Mindfulness",
                                      );
                                    },
                                    selected:
                                        filetrdata.getSelectedCategory() ==
                                        "Mindfulness",
                                    selectedColor: AppColors.kPrimaryBlue,
                                    showCheckmark: false,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(8),
                                      side: const BorderSide(
                                        color: AppColors.kPrimaryDarkBlue,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  FilterChip(
                                    label: Text(
                                      "Sleep Stories",
                                      style: TextStyle(
                                        color:
                                            filetrdata.getSelectedCategory() ==
                                                "Sleep_Exercise"
                                            ? AppColors.kPrimaryWhiteColor
                                            : AppColors.kPrimaryBlackColor,
                                      ),
                                    ),
                                    onSelected: (bool value) {
                                      filetrdata.filterData(
                                        category: "Sleep_Exercise",
                                      );
                                    },
                                    selected:
                                        filetrdata.getSelectedCategory() ==
                                        "Sleep_Exercise",
                                    selectedColor: AppColors.kPrimaryBlue,
                                    showCheckmark: false,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(8),
                                      side: const BorderSide(
                                        color: AppColors.kPrimaryDarkBlue,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (completedData.isNotEmpty)
                          StaggeredGrid.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            children: completedData.map((data) {
                              return GestureDetector(
                                onTap: () {
                                  if (data is MindfulnessExercise) {
                                    handleMindfullExercisePressed(
                                      context,
                                      data,
                                    );
                                  } else if (data is MeditationExercise) {
                                    handleMeditationExercisePressed(
                                      context: context,
                                      name: data.name,
                                      category: data.category,
                                      description: data.description,
                                      duration: data.duration,
                                      videoUrl: data.videoUrl,
                                    );
                                  } else {
                                    handleSleepExercisePressed(context, data);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: data is MeditationExercise
                                        ? AppColors.kPrimaryBlue
                                        : data is MindfulnessExercise
                                        ? AppColors.kPrimaryBlue.withValues(
                                            alpha: 0.7,
                                          )
                                        : AppColors.kPrimaryDarkBlue.withValues(
                                            alpha: 0.8,
                                          ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.name,
                                          style: AppTextStyle.titleStyle
                                              .copyWith(
                                                color: AppColors
                                                    .kPrimaryWhiteColor,
                                              ),
                                        ),
                                        Text(
                                          data.category,
                                          style: AppTextStyle.subTitleStyle
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors
                                                    .kPrimaryBlackColor
                                                    .withValues(alpha: 0.6),
                                              ),
                                        ),
                                        Text(
                                          "${data.duration.toString()} minutes",
                                          style: AppTextStyle.subTitleStyle
                                              .copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors
                                                    .kPrimaryDeepDarkBlue
                                                    .withValues(alpha: 0.5),
                                              ),
                                        ),
                                        Text(
                                          data.description,
                                          style: AppTextStyle.bodyStyle
                                              .copyWith(
                                                color: AppColors.kCardColor,
                                              ),
                                          maxLines:
                                              (data.description.length / 2)
                                                  .toInt(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
