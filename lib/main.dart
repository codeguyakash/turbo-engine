import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  final List<Map<String, dynamic>> campaigns = [
    {
      "id": "1",
      "campaign_name": "Sample Video 1",
      "video_url":
          "https://prowtechapi.zenoheal.com/uploads/Network/2nd%20December%202024%20/1733131279_0f822f5eb56f904a2d91.mp4",
      "duration": "15",
      "thumbnail_url": "https://picsum.photos/250?image=10",
    },
    {
      "id": "2",
      "campaign_name": "Sample Video 2",
      "video_url":
          "https://prowtechapi.zenoheal.com/uploads/Network/2nd%20December%202024%20/1733131300_172fff1b049b90f86414.mp4",
      "duration": "15",
      "thumbnail_url": "https://picsum.photos/250?image=10",
    },
    {
      "id": "3",
      "campaign_name": "Sample Video 3",
      "video_url":
          "https://prowtechapi.zenoheal.com/uploads/Network/2nd%20December%202024%20/1733128258_d747a60c2d7fc3eafe63.mp4",
      "duration": "15",
      "thumbnail_url": "https://picsum.photos/250?image=10",
    },
  ];

  Future<void> playVideo(String url) async {
    const platform = MethodChannel('com.example.videoplayer/channel');
    try {
      await platform.invokeMethod('playVideo', {'url': url});
    } on PlatformException catch (e) {
      print("Failed to play video: ${e.message}");
    }
  }

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
        itemCount: campaigns.length,
        itemBuilder: (context, index) {
          final campaign = campaigns[index];
          return InkWell(
            onTap: () => playVideo(campaign['video_url']),
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
                          child: Image.network(
                            campaign['thumbnail_url'],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        const Center(
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

// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   MyHomePage({super.key});

//   final List<Map<String, dynamic>> campaigns = [
//     {
//       "id": "1",
//       "campaign_name": "Sample Video 1",
//       "video_url":
//           "https://prowtechapi.zenoheal.com/uploads/AKASH/1735816062_43b1470e9010024ba549.mp4",
//       "duration": "15",
//       "thumbnail_url": "https://picsum.photos/250?image=10",
//     },
//     {
//       "id": "2",
//       "campaign_name": "Sample Video 2",
//       "video_url":
//           "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
//       "duration": "15",
//       "thumbnail_url": "https://picsum.photos/250?image=10",
//     },
//     {
//       "id": "3",
//       "campaign_name": "Sample Video 3",
//       "video_url":
//           "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
//       "duration": "15",
//       "thumbnail_url": "https://picsum.photos/250?image=10",
//     },
//     {
//       "id": "4",
//       "campaign_name": "Sample Video 4",
//       "video_url":
//           "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
//       "duration": "15",
//       "thumbnail_url": "https://picsum.photos/250?image=10",
//     },
//     {
//       "id": "5",
//       "campaign_name": "Sample Video 5",
//       "video_url": "https://codeguyakash.github.io/sturdy-barnacle/sample1.mp4",
//       "duration": "15",
//       "thumbnail_url": "https://picsum.photos/250?image=10",
//     },
//     {
//       "id": "5",
//       "campaign_name": "Sample Video 6",
//       "video_url": "https://codeguyakash.github.io/sturdy-barnacle/sample2.mp4",
//       "duration": "15",
//       "thumbnail_url": "https://picsum.photos/250?image=10",
//     }
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Video Grid')),
//       body: GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//         ),
//         itemCount: campaigns.length,
//         itemBuilder: (context, index) {
//           final campaign = campaigns[index];
//           return InkWell(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => DetailScreen(
//                     videoUrl: campaign['video_url'],
//                     campaignName: campaign['campaign_name'],
//                   ),
//                 ),
//               );
//             },
//             child: Card(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: Stack(
//                       children: [
//                         ClipRRect(
//                           borderRadius: const BorderRadius.only(
//                             topLeft: Radius.circular(8),
//                             topRight: Radius.circular(8),
//                           ),
//                           child: Image.network(
//                             campaign['thumbnail_url'],
//                             fit: BoxFit.cover,
//                             width: double.infinity,
//                             height: double.infinity,
//                           ),
//                         ),
//                         const Center(
//                           child: Icon(
//                             Icons.play_circle_outline,
//                             color: Colors.white,
//                             size: 50,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       campaign['campaign_name'],
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class DetailScreen extends StatefulWidget {
//   final String videoUrl;
//   final String campaignName;

//   const DetailScreen({
//     super.key,
//     required this.videoUrl,
//     required this.campaignName,
//   });

//   @override
//   _DetailScreenState createState() => _DetailScreenState();
// }

// class _DetailScreenState extends State<DetailScreen> {
//   late VideoPlayerController _controller;
//   bool _isLoading = true;
//   bool _hasError = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeVideoPlayer();
//   }

//   void _initializeVideoPlayer() async {
//     try {
//       _controller = VideoPlayerController.network(widget.videoUrl)
//         ..addListener(() {
//           if (mounted) setState(() {});
//         })
//         ..setLooping(false)
//         ..initialize().then((_) {
//           setState(() {
//             _isLoading = false;
//             _controller.play();
//           });
//         }).catchError((e) {
//           print('Error initializing video: $e');
//           setState(() {
//             _hasError = true;
//           });
//         });
//     } catch (e) {
//       print('Exception during initialization: $e');
//       setState(() {
//         _hasError = true;
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.campaignName),
//       ),
//       body: _hasError
//           ? const Center(
//               child: Text(
//                 'Error loading video',
//                 style: TextStyle(color: Colors.red, fontSize: 18),
//               ),
//             )
//           : _isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : AspectRatio(
//                   aspectRatio: _controller.value.aspectRatio,
//                   child: VideoPlayer(_controller),
//                 ),
//     );
//   }
// }
