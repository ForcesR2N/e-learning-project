import 'package:e_learning/component/my_color.dart';
import 'package:e_learning/model/data.json.dart';
import 'package:e_learning/widget/like_dislike.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  final String videoUrl;
  final String title;
  final String description;
  final String image;

  VideoPage(
      {required this.videoUrl,
      required this.title,
      required this.description,
      required this.image});

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    String videoId = YoutubePlayer.convertUrlToId(widget.videoUrl) ?? "";

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = Data(
      title: widget.title,
      description: widget.description,
      image: widget.image,
      videoUrl: widget.videoUrl,
    );
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColor.primaryBlue,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: true,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.blueAccent,
              ),
              SizedBox(height: 20),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColor.textColor,
                ),
              ),
              SizedBox(height: 10),
              LikeDislikeWidget(data: data),
              SizedBox(height: 10),
              Text(
                "Description",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColor.textColor,
                ),
              ),
              SizedBox(height: 10),
              Text(
                widget.description,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: AppColor.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
