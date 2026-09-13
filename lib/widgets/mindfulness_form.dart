import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meditator/models/mindfulness_exercise_model.dart';
import 'package:meditator/providers/custom_data_provider.dart';
import 'package:meditator/utils/colors.dart';
import 'package:meditator/utils/text_styles.dart';
import 'package:meditator/widgets/reusable/text_form_fields.dart';
import 'package:provider/provider.dart';

class MindfulnessForm extends StatefulWidget {
  const new({super.key});

  @override
  State<MindfulnessForm> createState() => _MindfulnessFormState();
}

class _MindfulnessFormState extends State<MindfulnessForm> {
  final _fromKey = GlobalKey<FormState>();
  String _category = '';
  String _name = '';
  String _description = '';
  List<String> _instruction = [];
  int _duration = 0;
  String _instructionUrl = '';
  File? _imagePath;
  final ImagePicker _imagePicker = ImagePicker();
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imagePath = File(pickedFile.path);
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("No Image Selected")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            'Create new mindfull exercise',
            style: AppTextStyle.titleStyle.copyWith(
              color: AppColors.kPrimaryGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Form(
            key: _fromKey,
            child: Column(
              children: [
                if (_imagePath != null) Image.file(_imagePath!, height: 150),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => _pickImage(ImageSource.camera),
                      child: const Text('Pick from Camera'),
                    ),
                    ElevatedButton(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      child: const Text('Pick from Gallery'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  lableText: 'Category',
                  hintText: 'Category',
                  keyBoardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid category';
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
                  lableText: 'Name',
                  hintText: 'Name',
                  keyBoardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid name';
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
                  lableText: 'Description',
                  hintText: 'Description',
                  keyBoardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid description';
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
                  lableText: 'Instructions',
                  hintText: 'Instructions',
                  keyBoardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid instructions';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    _instruction = newValue!.split(',');
                  },
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  lableText: 'Duration',
                  hintText: 'Duration',
                  keyBoardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid duration';
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
                  lableText: 'Instruction URL',
                  hintText: 'InstructionUrl',
                  keyBoardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid Instruction URL';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    _instructionUrl = newValue!;
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
                        if (_fromKey.currentState!.validate()) {
                          _fromKey.currentState!.save();

                          final imagePathString = _imagePath?.path ?? '';

                          final mindfulnessExercise = MindfulnessExercise(
                            category: _category,
                            name: _name,
                            description: _description,
                            instructions: _instruction,
                            duration: _duration,
                            instructionsUrl: _instructionUrl,
                            imagePath: imagePathString,
                          );

                          Provider.of<CustomDataProvider>(
                            context,
                            listen: false,
                          ).addmidFulnessExercise(mindfulnessExercise, context);
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
