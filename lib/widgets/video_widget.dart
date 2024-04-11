import 'package:flutter/material.dart';
import 'package:giftcart/util/theme.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerItem({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController videoPlayerController;
  bool isVideoLoading = true;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          isVideoLoading = false;
        });
        videoPlayerController.play();
        videoPlayerController.setVolume(1);
        videoPlayerController.addListener(() {
          if (videoPlayerController.value.isPlaying &&
              isVideoLoading) {
            setState(() {
              isVideoLoading = false;
            });
          } else if (!videoPlayerController.value.isPlaying &&
              !isVideoLoading) {
            setState(() {
              isVideoLoading = true;
            });
          }
        });
      }).catchError((error) {
        setState(() {
          isVideoLoading = false;
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: isVideoLoading
              ? Center(child: CircularProgressIndicator(
            color: AppColor.primaryColor,
          )) // Show loader
              : GestureDetector(
            onTap: () {
              setState(() {
                if (videoPlayerController.value.isPlaying) {
                  videoPlayerController.pause();
                } else {
                  videoPlayerController.play();
                }
              });
            },
            child: VideoPlayer(videoPlayerController),
          ),
        ),

        if (!videoPlayerController.value.isPlaying)
          isVideoLoading?SizedBox.shrink():
          Center(
            child: Icon(
              Icons.play_arrow,
              size: 80,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
      ],
    );
  }
}
