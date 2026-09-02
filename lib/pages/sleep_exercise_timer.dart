import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meditator/models/sleep_exercise_model.dart';
import 'package:meditator/utils/colors.dart';
import 'package:meditator/utils/text_styles.dart';

class SleepExerciseTimer extends StatefulWidget {
  final SleepExerciseModel sleepExercise;
  const SleepExerciseTimer({super.key, required this.sleepExercise});

  @override
  State<SleepExerciseTimer> createState() => _SleepExerciseTimerState();
}

class _SleepExerciseTimerState extends State<SleepExerciseTimer> {
  Timer? _timer;
  int _remainingTime = 0;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.sleepExercise.duration * 60;
  }

  //method to start the timer
  void _startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _isRunning = true;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer!.cancel();
        }
      });
    });
  }

  //method to pause timer

  void _pauseTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _isRunning = false;
    }
  }

  //method to stop timer
  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      _remainingTime = widget.sleepExercise.duration * 60;
      _isRunning = false;
    });
  }

  //format timer
  String _formatTimer(int seconds) {
    int minutes = seconds ~/ 60;
    int remaingSeconds = seconds % 60;

    return "$minutes:${remaingSeconds.toString().padLeft(2, "0")}";
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sleep Story Timer",
          style: TextStyle(
            fontSize: 22,
            color: AppColors.kPrimaryBlackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  widget.sleepExercise.category,
                  style: AppTextStyle.titleStyle.copyWith(
                    color: AppColors.kPrimaryPurple,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.sleepExercise.name,
                  style: AppTextStyle.titleStyle.copyWith(
                    color: AppColors.kPrimaryBlackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Duration: ${widget.sleepExercise.duration} min",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.kPrimaryBlackColor.withValues(alpha: 0.7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.sleepExercise.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.kPrimaryGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    _formatTimer(_remainingTime),
                    style: const TextStyle(
                      color: AppColors.kPrimaryBlackColor,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isRunning ? _pauseTimer() : _startTimer();
                        });
                      },
                      child: Text(
                        _isRunning
                            ? "Pause"
                            : (_remainingTime <
                                      widget.sleepExercise.duration * 60
                                  ? "Resume"
                                  : "Start"),
                      ),
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: _stopTimer,
                      child: const Text("Stop"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
