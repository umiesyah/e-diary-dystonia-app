import 'package:dystoniadiary/main.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Navthree extends StatefulWidget {
  const Navthree({Key? key}) : super(key: key);

  @override
  _NavthreeState createState() => _NavthreeState();
}

class _NavthreeState extends State<Navthree> {
  late VideoPlayerController _controller1;
  late VideoPlayerController _controller2;
  late VideoPlayerController _controller3;
  late Future<void> _initializeVideoPlayerFuture1;
  late Future<void> _initializeVideoPlayerFuture2;
  late Future<void> _initializeVideoPlayerFuture3;
  bool _isLoading1 = true;
  bool _isLoading2 = true;
  bool _isLoading3 = true;

  final List<String> videoPaths = [
    'assets/video/video1.mp4',
    'assets/video/video2.mp4',
    'assets/video/video3.mp4',
  ];
  int currentVideoIndex = 0;

  @override
  void initState() {
    super.initState();
    initializeVideoPlayers();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  Future<void> initializeVideoPlayers() async {
    _controller1 = VideoPlayerController.asset(videoPaths[0]);
    _controller2 = VideoPlayerController.asset(videoPaths[1]);
    _controller3 = VideoPlayerController.asset(videoPaths[2]);

    _initializeVideoPlayerFuture1 = _controller1.initialize().then((_) {
      setState(() {
        _isLoading1 = false;
      });
    });
    _initializeVideoPlayerFuture2 = _controller2.initialize().then((_) {
      setState(() {
        _isLoading2 = false;
      });
    });
    _initializeVideoPlayerFuture3 = _controller3.initialize().then((_) {
      setState(() {
        _isLoading3 = false;
      });
    });
  }

  void changeVideo() {
    setState(() {
      currentVideoIndex = (currentVideoIndex + 1) % videoPaths.length;
      _isLoading1 = true;
      _isLoading2 = true;
      _isLoading3 = true;
      _controller1.dispose();
      _controller2.dispose();
      _controller3.dispose();
      initializeVideoPlayers();
    });
  }

  Widget buildVideoWidget(VideoPlayerController controller, Future<void> initializeVideoPlayerFuture, bool isLoading, String imagePath) {
    return Stack(
      fit: StackFit.expand,
      children: [
        isLoading
            ? CircularProgressIndicator()
            : Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
        FutureBuilder(
          future: initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    controller.value.isPlaying ? controller.pause() : controller.play();
                  });
                },
                child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      VideoPlayer(controller),
                      if (!controller.value.isPlaying)
                        Center(
                          child: Icon(
                            Icons.play_arrow,
                            size: 80,
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: palletcolor.dark,

      
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: Text('Health Tips',style: TextStyle(fontSize: 20 ,  color: palletcolor.lighter),)),
          
          Expanded(
            child: buildVideoWidget(
              _controller1,
              _initializeVideoPlayerFuture1,
              _isLoading1,
              'assets/images/your_image1.jpg',
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: buildVideoWidget(
              _controller2,
              _initializeVideoPlayerFuture2,
              _isLoading2,
              'assets/images/your_image2.jpg',
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: buildVideoWidget(
              _controller3,
              _initializeVideoPlayerFuture3,
              _isLoading3,
              'assets/images/your_image3.jpg',
            ),
          ),
        ],
      ),
      
    );
  }
}
