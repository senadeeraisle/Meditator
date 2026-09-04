import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meditator/models/mindfulness_exercise_model.dart';
import 'package:meditator/providers/midfulness_exercise_provider.dart';
import 'package:meditator/router/route_names.dart';
import 'package:meditator/utils/colors.dart';
import 'package:meditator/utils/text_styles.dart';
import 'package:provider/provider.dart';

class MindFullExercisePage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mindfull Exercise",
          style: TextStyle(
            color: AppColors.kPrimaryBlue,
            fontSize: 29,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: const BorderSide(
                        color: AppColors.kPrimaryBlue,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: const BorderSide(
                        color: AppColors.kPrimaryDarkBlue,
                        width: 2,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    Provider.of<MidfulnessExerciseProvider>(
                      context,
                      listen: false,
                    ).searchmindfullExercise(value);
                  },
                ),
                const SizedBox(height: 15),
                Consumer<MidfulnessExerciseProvider>(
                  builder: (context, mindfulnessExercise, child) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: mindfulnessExercise.midfulnessExercises.length,
                      itemBuilder: (context, index) {
                        MindfulnessExercise singleMindfulexercise =
                            mindfulnessExercise.midfulnessExercises[index];
                        return GestureDetector(
                          onTap: () {
                            GoRouter.of(context).pushNamed(
                              RouteNames.mindFullExercisePage,
                              queryParameters: {
                                'mindfullExercise': jsonEncode(
                                  singleMindfulexercise.toJson(),
                                ),
                              },
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.kCardColor,
                            ),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  "assets/images/undraw_mindfulness_d853.png",
                                  width:
                                      MediaQuery.of(context).size.width * 0.13,
                                  height:
                                      MediaQuery.of(context).size.height * 0.13,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                singleMindfulexercise.name,
                                style: AppTextStyle.titleStyle.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                singleMindfulexercise.description,
                                style: AppTextStyle.bodyStyle.copyWith(
                                  color: AppColors.kPrimaryDeepDarkBlue
                                      .withValues(alpha: 0.6),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                textHeightBehavior: const TextHeightBehavior(
                                  applyHeightToFirstAscent: false,
                                  applyHeightToLastDescent: false,
                                ),
                              ),
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
        ),
      ),
    );
  }
}
