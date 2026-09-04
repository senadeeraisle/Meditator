import 'package:flutter/material.dart';
import 'package:meditator/utils/colors.dart';
import 'package:meditator/utils/text_styles.dart';
import 'package:meditator/widgets/meditation_form.dart';
import 'package:meditator/widgets/mindfulness_form.dart';
import 'package:meditator/widgets/sleep_exercise_form.dart';

class CreateCustomExercisePage extends StatefulWidget {
  const CreateCustomExercisePage({super.key});

  @override
  State<CreateCustomExercisePage> createState() =>
      _CreateCustomExercisePageState();
}

class _CreateCustomExercisePageState extends State<CreateCustomExercisePage> {
  String typeOfContent = "Meditation";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Custom Exercise",
          style: TextStyle(
            color: AppColors.kPrimaryBlue,
            fontSize: 29,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColors.kPrimaryBlue.withValues(alpha: 0.3),
                      border: Border.all(
                        color: AppColors.kPrimaryBlue,
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: typeOfContent,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.kPrimaryBlue,
                          ),
                          isExpanded: true,
                          items: ["Meditation", "Mindfulness", "Sleep Exercise"]
                              .map(
                                (String item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: AppTextStyle.subTitleStyle,
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              typeOfContent = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (typeOfContent == "Meditation")
                  const MeditationForm()
                else if (typeOfContent == "Mindfulness")
                  const MindfulnessForm()
                else if (typeOfContent == "Sleep Exercise")
                  const SleepExerciseForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
