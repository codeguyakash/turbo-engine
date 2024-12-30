import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final List<Map<String, dynamic>> sam_campaigns = [
    {
      "id": "1",
      "campaign_name": "Prowtech Video 1",
      "start_date": "2024-12-24",
      "end_date": "2025-01-10",
      "is_full_screen": true,
      "is_active": true,
      "start_time": "10:59:00",
      "end_time": "22:23:00",
      "video_url":
          "https://prowtechapi.zenoheal.com/uploads/Network/1732627668_ea79e3f5477c2af0bd99.mp4",
      "duration": "15",
      "thumbnail_url":
          "https://prowtechapi.zenoheal.com/uploads/thumbnails/thumb_1732627668_ea79e3f5477c2af0bd99.jpg",
      "order": "1",
      "created_at": "2024-11-29",
      "is_internet_source": true,
    },
    {
      "id": "2",
      "campaign_name": "Prowtech Video 2",
      "start_date": "2024-12-24",
      "end_date": "2025-01-10",
      "is_full_screen": true,
      "is_active": true,
      "start_time": "10:59:00",
      "end_time": "22:23:00",
      "video_url":
          "https://prowtechapi.zenoheal.com/uploads/Network/1733117767_b6bab8bd861b5378e946.mp4",
      "duration": "15",
      "thumbnail_url":
          "https://prowtechapi.zenoheal.com/uploads/thumbnails/thumb_1733117767_b6bab8bd861b5378e946.jpg",
      "order": "1",
      "created_at": "2024-11-29",
      "is_internet_source": true,
    },
    {
      "id": "3",
      "campaign_name": "Pexel Video 1",
      "start_date": "2024-12-24",
      "end_date": "2025-01-10",
      "is_full_screen": true,
      "is_active": true,
      "start_time": "10:59:00",
      "end_time": "22:23:00",
      "video_url":
          "https://videos.pexels.com/video-files/3173312/3173312-uhd_2560_1440_30fps.mp4",
      "thumbnail_url":
          "https://images.pexels.com/videos/3173312/free-video-3173312.jpg?auto=compress&cs=tinysrgb&w=600",
      "duration": "15",
      "order": "1",
      "created_at": "2024-11-29",
      "is_internet_source": true,
    },
    {
      "id": "4",
      "campaign_name": "Pexel Video 2",
      "start_date": "2024-12-24",
      "end_date": "2025-01-10",
      "is_full_screen": true,
      "is_active": true,
      "start_time": "10:59:00",
      "end_time": "22:23:00",
      "video_url":
          "https://videos.pexels.com/video-files/3239847/3239847-hd_1920_1080_25fps.mp4",
      "thumbnail_url":
          "https://images.pexels.com/videos/3239847/free-video-3239847.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "duration": "15",
      "order": "1",
      "created_at": "2024-11-29",
      "is_internet_source": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Grid')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: sam_campaigns.length,
        itemBuilder: (context, index) {
          final campaign = sam_campaigns[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    videoUrl: campaign['video_url'],
                    campaignName: campaign['campaign_name'],
                    isLocalSource: !campaign['is_internet_source'],
                  ),
                ),
              );
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          child: campaign['is_internet_source']
                              ? Image.network(
                                  campaign['thumbnail_url'],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                )
                              : Image.asset(
                                  campaign['thumbnail_url'],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                        ),
                        Center(
                          child: Icon(
                            Icons.play_circle_outline,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      campaign['campaign_name'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatefulWidget {
  final String videoUrl;
  final String campaignName;
  final bool isLocalSource;

  const DetailScreen(
      {super.key,
      required this.videoUrl,
      required this.campaignName,
      required this.isLocalSource});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late VideoPlayerController _controller;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() async {
    try {
      _controller = VideoPlayerController.network(widget.videoUrl)
        ..addListener(() {
          if (mounted) setState(() {});
        })
        ..setLooping(true)
        ..initialize().then((_) {
          setState(() {
            _isLoading = false;
            _controller.play();
          });
        }).catchError((e) {
          print('Error initializing video: $e');
          setState(() {
            _hasError = true;
          });
        });
    } catch (e) {
      print('Exception during initialization: $e');
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Screen'),
      ),
      body: _hasError
          ? Center(
              child: Text(
                'Error loading video',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            )
          : _isLoading
              ? const Center(child: CircularProgressIndicator())
              : AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
    );
  }
}
