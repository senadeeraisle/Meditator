import 'package:flutter/material.dart';
import 'package:meditator/models/meditation_exercise_model.dart';
import 'package:meditator/providers/custom_data_provider.dart';
import 'package:meditator/utils/colors.dart';
import 'package:meditator/utils/text_styles.dart';
import 'package:meditator/widgets/reusable/text_form_fields.dart';
import 'package:provider/provider.dart';

class MeditationForm extends StatefulWidget {
  const MeditationForm({super.key});

  @override
  State<MeditationForm> createState() => _MeditationFormState();
}

class _MeditationFormState extends State<MeditationForm> {
  final _formKey = GlobalKey<FormState>();
  String _category = '';
  String _name = '';
  String _description = '';
  int _duration = 0;
  String _audioUrl = '';
  String _videoUrl = '';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Text(
            "Create a New Meditation",
            style: AppTextStyle.titleStyle.copyWith(
              color: AppColors.kPrimaryGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  lableText: "Category",
                  hintText: "category",
                  keyBoardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a category";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    _category = newValue!;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  lableText: "Name",
                  hintText: "Name",
                  keyBoardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter valid name";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    _name = newValue!;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  lableText: "Description",
                  hintText: "Description",
                  keyBoardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter valid description";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    _description = newValue!;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  lableText: "Duration",
                  hintText: "Duration",
                  keyBoardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter valid duration";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    _duration = int.parse(newValue!);
                  },
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  lableText: "Audio URL",
                  hintText: "AudioUrl",
                  keyBoardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter valid audio Url";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    _audioUrl = newValue!;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  lableText: "Video URl",
                  hintText: "VideoUrl",
                  keyBoardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter valid Video URl";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    _videoUrl = newValue!;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(
                          AppColors.kPrimaryGreen.withValues(alpha: 0.7),
                        ),
                      ),
                      //todo: Save data
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          //create a new meditation from user data
                          final meditation = MeditationExercise(
                            category: _category,
                            name: _name,
                            description: _description,
                            duration: _duration,
                            audioUrl: _audioUrl,
                            videoUrl: _videoUrl,
                          );

                          _formKey.currentState!.reset();
                          _category = '';
                          _name = '';
                          _description = '';
                          _duration = 0;
                          _audioUrl = '';
                          _videoUrl = '';

                          Provider.of<CustomDataProvider>(
                            context,
                            listen: false,
                          ).addMeditation(meditation, context);
                        }
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.kPrimaryBlackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
