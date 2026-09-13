import 'dart:convert';

import 'package:go_router/go_router.dart';
import 'package:meditator/models/functions_model.dart';
import 'package:meditator/models/mindfulness_exercise_model.dart';
import 'package:meditator/models/sleep_exercise_model.dart';
import 'package:meditator/pages/main_screen.dart';
import 'package:meditator/pages/main_screens/create_custom_exercise_page.dart';
import 'package:meditator/pages/single_meditation_exercise_page.dart';
import 'package:meditator/pages/single_midfull_exercise_gridview.dart';
import 'package:meditator/pages/single_mindfull_exercise_page.dart';
import 'package:meditator/pages/sleep_exercise_timer.dart';
import 'package:meditator/router/route_names.dart';

class AppRoutes {
  final routes = GoRouter(
    routes: [
      GoRoute(
        path: RouteNames.mainPage,
        name: RouteNames.mainPage,
        builder: (context, state) {
          return const MainScreen();
        },
      ),
      GoRoute(
        path: RouteNames.mindFullExercisePage,
        name: RouteNames.mindFullExercisePage,
        builder: (context, state) {
          final mindfulnessExerciseJson =
              state.uri.queryParameters['mindfullExercise'];

          final mindfullExercise = MindfulnessExercise.fromJson(
            jsonDecode(mindfulnessExerciseJson!),
          );
          return SingleMindfullExercisePage(mindfullExercise: mindfullExercise);
        },
      ),
      GoRoute(
        path: RouteNames.meditationExercisePage,
        name: RouteNames.meditationExercisePage,
        builder: (context, state) {
          final FunctionsModel mindfullExercise = state.extra as FunctionsModel;
          return SingleMeditationExercisePage(
            meditationExercise: mindfullExercise,
          );
        },
      ),
      GoRoute(
        path: RouteNames.mindFullExerciseGridview,
        name: RouteNames.mindFullExerciseGridview,
        builder: (context, state) {
          final mindfullExerciseJson =
              state.uri.queryParameters['mindfullexercise'];
          final MindfulnessExercise mindfullexercise =
              MindfulnessExercise.fromJson(jsonDecode(mindfullExerciseJson!));
          return SingleMidfullExerciseGridview(
            mindfullexercise: mindfullexercise,
          );
        },
      ),

      GoRoute(
        path: RouteNames.sleepExerciseTimer,
        name: RouteNames.sleepExerciseTimer,
        builder: (context, state) {
          final sleepExerciseTimerJson =
              state.uri.queryParameters['sleep_exercise_timer'];
          final sleepExercise = SleepExerciseModel.fromJson(
            jsonDecode(sleepExerciseTimerJson!),
          );
          return SleepExerciseTimer(sleepExercise: sleepExercise);
        },
      ),

      GoRoute(
        path: RouteNames.crateCustomExercisePage,
        name: RouteNames.crateCustomExercisePage,
        builder: (context, state) => const CreateCustomExercisePage(),
      ),
    ],
  );
}
