import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main2() {
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
      "id": "23",
      "campaign_name": "Sample Campaign 1",
      "start_date": "2024-12-24",
      "end_date": "2025-01-10",
      "is_full_screen": true,
      "is_active": true,
      "start_time": "10:59:00",
      "end_time": "22:23:00",
      "video_url":
          "https://prowtechapi.zenoheal.com/uploads/Network/1732865592_f3298baa95075d3e2531.mp4",
      "duration": "15",
      "order": "1",
      "created_at": "2024-11-29"
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
                  ),
                ),
              );
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.network(
                      'https://images.pexels.com/photos/2575775/pexels-photo-2575775.jpeg?cs=srgb&dl=pexels-bongvideos-production-1310991-2575775.jpg&fm=jpg',
                      fit: BoxFit.cover,
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

  const DetailScreen(
      {super.key, required this.videoUrl, required campaignName});

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
        title: const Text('Detail Screen'),
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
