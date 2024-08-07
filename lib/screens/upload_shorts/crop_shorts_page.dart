import 'package:flutter/material.dart';
import 'package:video_editor/video_editor.dart';

class CropShortsPage extends StatefulWidget {
  const CropShortsPage({super.key});

  @override
  State<CropShortsPage> createState() => _CropShortsPageState();
}

class _CropShortsPageState extends State<CropShortsPage> {
  final _exportingProgress = ValueNotifier<double>(0.0);
  final _isExporting = ValueNotifier<bool>(false);
  final double height = 60;

  // late final VideoEditorController _controller = VideoEditorController.file(
  //   minDuration: const Duration(seconds: 1),
  //   maxDuration: const Duration(seconds: 10),
  // );

  // void initState() {
  //   super.initState();
  //   _controller
  //       .initialize(aspectRatio: 9 / 16)
  //       .then((_) => setState(() {}))
  //       .catchError((error) {
  //     // handle minumum duration bigger than video duration error
  //     Navigator.pop(context);
  //   }, test: (e) => e is VideoMinDurationError);
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
        child: Scaffold(
          // appBar: AppBar(
          //   title: Text('Edit video'),
          // ),
          body: SafeArea(
              child: Stack(
                children: [
                  _topNavBar(),

                  Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // CropGridViewer.preview(
                          //     controller: controller
                          // ),
                          // AnimatedBuilder(
                          //     animation: animation,
                          //     builder: builder
                          // )
                        ],
                      )
                  )
                ],
              )
          ),
        ),
    );
  }
  Widget _topNavBar() {
    return SafeArea(
      child: SizedBox(
        height: height,
        child: Row(
          children: [
            Expanded(
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.exit_to_app),
                tooltip: 'Leave editor',
              ),
            ),
            const VerticalDivider(endIndent: 22, indent: 22),
            Expanded(
              child: IconButton(
                onPressed: (){},
                icon: Icon(Icons.rotate_left),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: (){},
                icon: Icon(Icons.rotate_right),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: (){},
                icon: const Icon(Icons.crop),
                tooltip: 'Open crop screen',
              ),
            ),
            const VerticalDivider(endIndent: 22, indent: 22),
            Expanded(
              child: PopupMenuButton(
                tooltip: 'Open export menu',
                icon: const Icon(Icons.save),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: (){},
                    child: const Text('Export cover'),
                  ),
                  PopupMenuItem(
                    onTap: (){},
                    child: const Text('Export video'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
