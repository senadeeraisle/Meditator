import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meditator/providers/custom_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:meditator/models/meditation_exercise_model.dart';
import 'package:meditator/models/mindfulness_exercise_model.dart';
import 'package:meditator/models/sleep_exercise_model.dart';
import 'package:meditator/providers/filter_provider.dart';
import 'package:meditator/providers/meditation_provider.dart';
import 'package:meditator/providers/midfulness_exercise_provider.dart';
import 'package:meditator/providers/sleep_exercise_provider.dart';
import 'package:meditator/router/app_routes.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(MeditationExerciseAdapter());
  Hive.registerAdapter(MindfulnessExerciseAdapter());
  Hive.registerAdapter(SleepExerciseModelAdapter());

  await Hive.openBox('meditation_data');
  await Hive.openBox('mindfulness_data');
  await Hive.openBox('sleep_exercise_data');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MeditationProvider()),
        ChangeNotifierProvider(
          create: (context) => MidfulnessExerciseProvider(),
        ),
        ChangeNotifierProvider(create: (context) => SleepExerciseProvider()),
        ChangeNotifierProvider(create: (context) => FilterProvider()),
        ChangeNotifierProvider(create: (context) => CustomDataProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "meditator",
      theme: ThemeData(fontFamily: GoogleFonts.lato().fontFamily),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoutes().routes,
    );
  }
}
