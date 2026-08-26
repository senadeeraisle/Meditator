import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meditator/providers/filter_provider.dart';
import 'package:meditator/providers/meditation_provider.dart';
import 'package:meditator/providers/midfulness_exercise_provider.dart';
import 'package:meditator/providers/sleep_exercise_provider.dart';
import 'package:meditator/router/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MeditationProvider()),
        ChangeNotifierProvider(
          create: (context) => MidfulnessExerciseProvider(),
        ),
        ChangeNotifierProvider(create: (context) => SleepExerciseProvider()),
        ChangeNotifierProvider(create: (context) => FilterProvider()),
      ],
      child: MyApp(),
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
