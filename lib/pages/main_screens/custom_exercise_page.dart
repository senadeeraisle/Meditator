import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meditator/router/app_routes.dart';
import 'package:meditator/router/route_names.dart';
import 'package:meditator/utils/colors.dart';
import 'package:meditator/widgets/tabs/meditation_tab.dart';
import 'package:meditator/widgets/tabs/mindfulness_tab.dart';
import 'package:meditator/widgets/tabs/sleep_exercise_tab.dart';

class CustomExercisePage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Custom Exercises",
            style: TextStyle(
              color: AppColors.kPrimaryBlue,
              fontSize: 29,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: const TabBar(
            dividerHeight: 4,
            indicatorColor: AppColors.kPrimaryBlue,
            tabs: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Tab(text: 'Meditation'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Tab(text: 'Mindfulness Exercise'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Tab(text: 'Sleep Exercise'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            GoRouter.of(context).pushNamed(RouteNames.crateCustomExercisePage);
          },
          child: const Center(
            child: Icon(Icons.add, size: 30, color: AppColors.kPrimaryGreen),
          ),
        ),
        body: const TabBarView(
          children: [MeditationTab(), MindfulnessTab(), SleepExerciseTab()],
        ),
      ),
    );
  }
}
