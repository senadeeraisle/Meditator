import 'package:flutter/material.dart';
import 'package:meditator/models/functions_model.dart';
import 'package:meditator/utils/colors.dart';
import 'package:meditator/utils/text_styles.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SingleMeditationExercisePage extends StatefulWidget {
  final FunctionsModel meditationExercise;
  const SingleMeditationExercisePage({
    super.key,
    required this.meditationExercise,
  });

  @override
  State<SingleMeditationExercisePage> createState() =>
      _SingleMeditationExercisePageState();
}

class _SingleMeditationExercisePageState
    extends State<SingleMeditationExercisePage> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    final videoId =
        YoutubePlayerController.convertUrlToId(
          widget.meditationExercise.videoUrl,
        ) ??
        "";
    _controller = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(mute: false),
    );
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.meditationExercise.name,
          style: const TextStyle(
            color: AppColors.kPrimaryBlue,
            fontSize: 24,
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
                const SizedBox(height: 15),
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: YoutubePlayer(controller: _controller),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Category: ${widget.meditationExercise.category}",
                  style: AppTextStyle.titleStyle.copyWith(
                    color: const Color.fromRGBO(131, 111, 255, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Duration: ${widget.meditationExercise.duration} min",
                  style: AppTextStyle.subTitleStyle.copyWith(
                    color: AppColors.kPrimaryGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.meditationExercise.description,
                  style: AppTextStyle.subTitleStyle.copyWith(
                    color: AppColors.kPrimaryBlackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
