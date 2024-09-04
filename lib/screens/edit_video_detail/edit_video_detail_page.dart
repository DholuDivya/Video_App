import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class EditVideoDetailPage extends StatefulWidget {
  const EditVideoDetailPage({super.key});

  @override
  State<EditVideoDetailPage> createState() => _EditVideoDetailPageState();
}

class _EditVideoDetailPageState extends State<EditVideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: [
                  Container(
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(15),
                    //     image: DecorationImage(
                    //         image: FileImage(File(finalThumbnail!.path))
                    //     )
                    // ),
                  ),
                  Positioned(
                    top: 10.h,
                    left: 10.h,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        // getThumbnail();
                        // context
                        //     .read<GetThumbnailBloc>()
                        //     .add(OpenFilesToGetThumbnail());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          HeroiconsOutline.folderPlus,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
