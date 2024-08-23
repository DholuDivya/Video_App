import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';

class UpdateChannelPage extends StatefulWidget {
  const UpdateChannelPage({super.key});

  @override
  State<UpdateChannelPage> createState() => _UpdateChannelPageState();
}

class _UpdateChannelPageState extends State<UpdateChannelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Update channel',
          style: TextStyle(
            fontFamily: fontFamily,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 20.h
          ),
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 70.r,
                      backgroundColor: blue,
                    ),
                    Positioned(
                      bottom: 5.h,
                        right: 12.w,
                        child: const Icon(
                            HeroiconsOutline.pencilSquare
                        )
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
