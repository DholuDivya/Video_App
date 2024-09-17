// // import 'dart:io';
// // import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:heroicons_flutter/heroicons_flutter.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:video_trimmer/video_trimmer.dart';
// // import 'package:vimeo_clone/bloc/get_shorts_from_user/get_shorts_bloc.dart';
// // import 'package:vimeo_clone/bloc/get_shorts_from_user/get_shorts_state.dart';
// // import 'package:vimeo_clone/config/colors.dart';
// // import 'package:vimeo_clone/config/constants.dart';
// // import 'package:vimeo_clone/screens/upload_shorts/preview.dart';
// //
// // class CropShortsPage extends StatefulWidget {
// //   const CropShortsPage({super.key});
// //
// //   @override
// //   State<CropShortsPage> createState() => _CropShortsPageState();
// // }
// //
// // class _CropShortsPageState extends State<CropShortsPage> {
// //   late Trimmer _trimmer = Trimmer();
// //   double _startValue = 0.0;
// //   double _endValue = 0.0;
// //   bool _isPlaying = false;
// //   bool _progressVisibility = false;
// //   String? croppedVideoPath;
// //
// //   int _currentIndex = 0;
// //
// //   List<Widget> widgets = [];
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     widgets = [
// //       TrimVideo(trimmer: _trimmer),
// //       CropVideo(cropFunction: cropVideoToAspectRatio),
// //     ];
// //   }
// //
// //   void _onTap(int index) {
// //     setState(() {
// //       _currentIndex = index;
// //     });
// //   }
// //
// //   void _loadVideo(File video) {
// //     _trimmer.loadVideo(videoFile: video);
// //   }
// //
// //   Future<void> _saveVideo() async {
// //     setState(() {
// //       _progressVisibility = true;
// //     });
// //
// //     await _trimmer.saveTrimmedVideo(
// //       startValue: _startValue,
// //       endValue: _endValue,
// //       onSave: (outputPath) {
// //         setState(() {
// //           _progressVisibility = false;
// //         });
// //         print('((((((((((((      $outputPath');
// //         Navigator.of(context).pushReplacement(
// //           MaterialPageRoute(
// //             builder: (context) => Preview(outputPath),
// //           ),
// //         );
// //       },
// //     );
// //   }
// //
// //   Future<void> cropVideoToAspectRatio(String inputPath) async {
// //     setState(() {
// //       _progressVisibility = true;
// //     });
// //
// //     // Output path for the cropped video
// //     String outputPath = "${Directory.systemTemp.path}/cropped_video.mp4";
// //
// //     // Using FFmpeg to crop the video to 9:16 aspect ratio
// //     await FFmpegKit.execute(
// //         '-i $inputPath -vf "crop=in_h*9/16:in_h" $outputPath');
// //
// //     setState(() {
// //       _progressVisibility = false;
// //       croppedVideoPath = outputPath;
// //     });
// //
// //     // Preview the cropped video
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.black38,
// //       appBar: AppBar(
// //         backgroundColor: Colors.black38,
// //         centerTitle: true,
// //         leading: IconButton(
// //           onPressed: () {
// //             Navigator.pop(context);
// //           },
// //           icon: Icon(HeroiconsOutline.xMark, color: Colors.white),
// //         ),
// //         title: const Text(
// //           'Edit video',
// //           style: TextStyle(
// //             fontFamily: fontFamily,
// //             color: Colors.white,
// //           ),
// //         ),
// //         actions: [
// //           IconButton(
// //             onPressed: _saveVideo,
// //             icon: Icon(HeroiconsOutline.check, color: Colors.white),
// //           ),
// //           SizedBox(width: 5.w),
// //         ],
// //       ),
// //       body: BlocBuilder<GetShortsBloc, GetShortsState>(
// //         builder: (context, state) {
// //           if (state is GetShortsSuccess) {
// //             XFile xFile = state.userShorts;
// //             File file = File(xFile.path);
// //
// //             if (file.existsSync()) {
// //               _loadVideo(file);
// //             } else {
// //               return Center(child: Text('No video found', style: TextStyle(color: Colors.white)));
// //             }
// //
// //             return Column(
// //               children: [
// //                 SizedBox(height: 10.h,),
// //                 Expanded(
// //                   child: VideoViewer(trimmer: _trimmer),
// //                 ),
// //                 SizedBox(height: 10.h,),
// //                 widgets[_currentIndex],
// //                 BottomNavigationBar(
// //                   landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
// //                   unselectedItemColor: greyShade700,
// //                   selectedItemColor: primaryColor,
// //                   backgroundColor: greyShade900,
// //                   currentIndex: _currentIndex,
// //                   onTap: _onTap,
// //                   items: const [
// //                     BottomNavigationBarItem(
// //                       icon: Icon(Icons.content_cut),
// //                       label: 'Trim',
// //                     ),
// //                     BottomNavigationBarItem(
// //                       icon: Icon(Icons.crop),
// //                       label: 'Crop',
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             );
// //           } else if (state is GetShortsLoading) {
// //             return Center(child: CircularProgressIndicator());
// //           } else {
// //             return Center(child: Text('Error loading video', style: TextStyle(color: Colors.white)));
// //           }
// //         },
// //       ),
// //     );
// //   }
// // }
// //
// // class TrimVideo extends StatefulWidget {
// //   final Trimmer trimmer;
// //
// //   const TrimVideo({super.key, required this.trimmer});
// //
// //   @override
// //   State<TrimVideo> createState() => _TrimVideoState();
// // }
// //
// // class _TrimVideoState extends State<TrimVideo> {
// //   double _startValue = 0.0;
// //   double _endValue = 0.0;
// //   bool _isPlaying = false;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       width: double.infinity,
// //       height: 160.h,
// //       color: greyShade900,
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Padding(
// //             padding: EdgeInsets.only(
// //               top: 5.h,
// //               left: 8.w,
// //               right: 8.w,
// //             ),
// //             child: Text(
// //               'Trim',
// //               style: TextStyle(
// //                 fontSize: 16,
// //                 fontFamily: fontFamily,
// //                 color: greyShade200,
// //               ),
// //             ),
// //           ),
// //           Divider(thickness: 0.2, color: greyShade300),
// //           Center(
// //             child: Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: TrimViewer(
// //                 maxVideoLength: const Duration(seconds: 120),
// //                 type: ViewerType.auto,
// //                 trimmer: widget.trimmer,
// //                 viewerHeight: 40.0,
// //                 viewerWidth: MediaQuery.of(context).size.width,
// //                 durationStyle: DurationStyle.FORMAT_MM_SS,
// //                 onChangeStart: (value) => setState(() => _startValue = value),
// //                 onChangeEnd: (value) => setState(() => _endValue = value),
// //                 onChangePlaybackState: (isPlaying) => setState(() => _isPlaying = isPlaying),
// //               ),
// //             ),
// //           ),
// //           Center(
// //             child: TextButton(
// //               child: _isPlaying
// //                   ? const Icon(
// //                 Icons.pause,
// //                 size: 20.0,
// //                 color: Colors.white,
// //               )
// //                   : const Icon(
// //                 Icons.play_arrow,
// //                 size: 20.0,
// //                 color: Colors.white,
// //               ),
// //               onPressed: () async {
// //                 final playbackState = await widget.trimmer.videoPlaybackControl(
// //                   startValue: _startValue,
// //                   endValue: _endValue,
// //                 );
// //                 setState(() => _isPlaying = playbackState);
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// // class CropVideo extends StatelessWidget {
// //   final Future<void> Function(String inputPath) cropFunction;
// //
// //   const CropVideo({super.key, required this.cropFunction});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       width: double.infinity,
// //       height: 160.h,
// //       color: greyShade900,
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Padding(
// //             padding: EdgeInsets.only(
// //               top: 5.h,
// //               left: 8.w,
// //               right: 8.w,
// //             ),
// //             child: Text(
// //               'Crop',
// //               style: TextStyle(
// //                 fontSize: 16,
// //                 fontFamily: fontFamily,
// //                 color: greyShade200,
// //               ),
// //             ),
// //           ),
// //           Divider(thickness: 0.2, color: greyShade300),
// //           Expanded(
// //             child: Padding(
// //               padding: EdgeInsets.only(
// //                 left: 20.w,
// //                 right: 20.w
// //               ),
// //               child: Center(
// //                 child: Container(
// //                   height: 40.h,
// //                   width: double.infinity,
// //                   child: ElevatedButton(
// //                     onPressed: () async {
// //                       String trimmedVideoPath = "";
// //                       await cropFunction(trimmedVideoPath);
// //                     },
// //                     child: const Text(
// //                         'Crop to 9:16 Aspect Ratio',
// //                       style: TextStyle(
// //                         fontFamily: fontFamily,
// //                         fontSize: 16
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// import 'dart:io';
// import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:heroicons_flutter/heroicons_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:video_trimmer/video_trimmer.dart';
// import 'package:vimeo_clone/bloc/get_shorts_from_user/get_shorts_bloc.dart';
// import 'package:vimeo_clone/bloc/get_shorts_from_user/get_shorts_state.dart';
// import 'package:vimeo_clone/config/colors.dart';
// import 'package:vimeo_clone/config/constants.dart';
// import 'package:vimeo_clone/screens/upload_shorts/preview.dart';
//
// class CropShortsPage extends StatefulWidget {
//   const CropShortsPage({super.key});
//
//   @override
//   State<CropShortsPage> createState() => _CropShortsPageState();
// }
//
// class _CropShortsPageState extends State<CropShortsPage> {
//   late final Trimmer _trimmer = Trimmer();
//   final double _startValue = 0.0;
//   final double _endValue = 0.0;
//   bool _progressVisibility = false;
//   String? croppedVideoPath;
//
//   int _currentIndex = 0;
//
//   List<Widget> widgets = [];
//
//   @override
//   void initState() {
//     super.initState();
//     widgets = [
//       TrimVideo(trimmer: _trimmer),
//       CropVideo(cropFunction: cropVideoToAspectRatio),
//     ];
//   }
//
//   void _onTap(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//
//   void _loadVideo(File video) {
//     _trimmer.loadVideo(videoFile: video);
//   }
//
//   Future<void> _saveVideo() async {
//     setState(() {
//       _progressVisibility = true;
//     });
//
//     await _trimmer.saveTrimmedVideo(
//       startValue: _startValue,
//       endValue: _endValue,
//       onSave: (outputPath) {
//         setState(() {
//           _progressVisibility = false;
//         });
//         print('((((((((((((      $outputPath');
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(
//             builder: (context) => Preview(outputPath),
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> cropVideoToAspectRatio(String inputPath) async {
//     setState(() {
//       _progressVisibility = true;
//     });
//
//     // Output path for the cropped video
//     String outputPath = "${Directory.systemTemp.path}/cropped_video.mp4";
//
//     // Using FFmpeg to crop the video to 9:16 aspect ratio
//     await FFmpegKit.execute(
//         '-i $inputPath -vf "crop=in_h*9/16:in_h" $outputPath');
//
//     setState(() {
//       _progressVisibility = false;
//       croppedVideoPath = outputPath;
//     });
//
//     // Preview the cropped video
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black38,
//       appBar: AppBar(
//         backgroundColor: Colors.black38,
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(HeroiconsOutline.xMark, color: Colors.white),
//         ),
//         title: const Text(
//           'Edit video',
//           style: TextStyle(
//             fontFamily: fontFamily,
//             color: Colors.white,
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: _saveVideo,
//             icon: Icon(HeroiconsOutline.check, color: Colors.white),
//           ),
//           SizedBox(width: 5.w),
//         ],
//       ),
//       body: BlocBuilder<GetShortsBloc, GetShortsState>(
//         builder: (context, state) {
//           if (state is GetShortsSuccess) {
//             XFile xFile = state.userShorts;
//             File file = File(xFile.path);
//
//             if (file.existsSync()) {
//               _loadVideo(file);
//             } else {
//               return Center(child: Text('No video found', style: TextStyle(color: Colors.white)));
//             }
//
//             return Column(
//               children: [
//                 SizedBox(height: 10.h,),
//                 Expanded(
//                   child: Stack(
//                     children: [
//                       VideoViewer(trimmer: _trimmer),
//                       Positioned.fill(
//                         child: CustomPaint(
//                           painter: GridOverlayPainter(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 10.h,),
//                 widgets[_currentIndex],
//                 BottomNavigationBar(
//                   landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
//                   unselectedItemColor: greyShade700,
//                   selectedItemColor: primaryColor,
//                   backgroundColor: greyShade900,
//                   currentIndex: _currentIndex,
//                   onTap: _onTap,
//                   items: const [
//                     BottomNavigationBarItem(
//                       icon: Icon(Icons.content_cut),
//                       label: 'Trim',
//                     ),
//                     BottomNavigationBarItem(
//                       icon: Icon(Icons.crop),
//                       label: 'Crop',
//                     ),
//                   ],
//                 ),
//               ],
//             );
//           } else if (state is GetShortsLoading) {
//             return Center(child: CircularProgressIndicator());
//           } else {
//             return Center(child: Text('Error loading video', style: TextStyle(color: Colors.white)));
//           }
//         },
//       ),
//     );
//   }
// }
//
// // GridOverlayPainter: CustomPainter class to draw the grid lines
// class GridOverlayPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Colors.white.withOpacity(0.5)
//       ..strokeWidth = 1.0;
//
//     double thirdWidth = size.width / 3;
//     double thirdHeight = size.height / 3;
//
//     // Draw vertical grid lines
//     for (int i = 1; i < 3; i++) {
//       canvas.drawLine(
//         Offset(thirdWidth * i, 0),
//         Offset(thirdWidth * i, size.height),
//         paint,
//       );
//     }
//
//     // Draw horizontal grid lines
//     for (int i = 1; i < 3; i++) {
//       canvas.drawLine(
//         Offset(0, thirdHeight * i),
//         Offset(size.width, thirdHeight * i),
//         paint,
//       );
//     }
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
//
// class TrimVideo extends StatefulWidget {
//   final Trimmer trimmer;
//
//   const TrimVideo({super.key, required this.trimmer});
//
//   @override
//   State<TrimVideo> createState() => _TrimVideoState();
// }
//
// class _TrimVideoState extends State<TrimVideo> {
//   double _startValue = 0.0;
//   double _endValue = 0.0;
//   bool _isPlaying = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 160.h,
//       color: greyShade900,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(
//               top: 5.h,
//               left: 8.w,
//               right: 8.w,
//             ),
//             child: Text(
//               'Trim',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontFamily: fontFamily,
//                 color: greyShade200,
//               ),
//             ),
//           ),
//           Divider(thickness: 0.2, color: greyShade300),
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TrimViewer(
//                 maxVideoLength: const Duration(seconds: 120),
//                 type: ViewerType.auto,
//                 trimmer: widget.trimmer,
//                 viewerHeight: 40.0,
//                 viewerWidth: MediaQuery.of(context).size.width,
//                 durationStyle: DurationStyle.FORMAT_MM_SS,
//                 onChangeStart: (value) => setState(() => _startValue = value),
//                 onChangeEnd: (value) => setState(() => _endValue = value),
//                 onChangePlaybackState: (isPlaying) => setState(() => _isPlaying = isPlaying),
//               ),
//             ),
//           ),
//           Center(
//             child: TextButton(
//               child: _isPlaying
//                   ? const Icon(
//                 Icons.pause,
//                 size: 20.0,
//                 color: Colors.white,
//               )
//                   : const Icon(
//                 Icons.play_arrow,
//                 size: 20.0,
//                 color: Colors.white,
//               ),
//               onPressed: () async {
//                 final playbackState = await widget.trimmer.videoPlaybackControl(
//                   startValue: _startValue,
//                   endValue: _endValue,
//                 );
//                 setState(() => _isPlaying = playbackState);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class CropVideo extends StatelessWidget {
//   final Future<void> Function(String inputPath) cropFunction;
//
//   const CropVideo({super.key, required this.cropFunction});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 160.h,
//       color: greyShade900,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(
//               top: 5.h,
//               left: 8.w,
//               right: 8.w,
//             ),
//             child: Text(
//               'Crop',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontFamily: fontFamily,
//                 color: greyShade200,
//               ),
//             ),
//           ),
//           Divider(thickness: 0.2, color: greyShade300),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.only(
//                   left: 20.w,
//                   right: 20.w
//               ),
//               child: Center(
//                 child: Container(
//                   height: 40.h,
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       String trimmedVideoPath = "";
//                       await cropFunction(trimmedVideoPath);
//                     },
//                     child: const Text(
//                       'Crop to 9:16 Aspect Ratio',
//                       style: TextStyle(
//                           fontFamily: fontFamily,
//                           fontSize: 16
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
