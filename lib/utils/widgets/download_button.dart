import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/config/constants.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: InkWell(
          borderRadius: BorderRadius.circular(20),

          onTap: (){},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Theme.of(context).colorScheme.primary
            ),
            padding: EdgeInsets.only(
              left: ScreenSize.screenWidth(context) * 0.03,
              right: ScreenSize.screenWidth(context) * 0.03,
              top: ScreenSize.screenHeight(context) * 0.009,
              bottom: ScreenSize.screenHeight(context) * 0.009,
            ),
            child: Row(
              children: [
                Icon(Remix.download_line, size: 15,),
                SizedBox(width: ScreenSize.screenWidth(context) * 0.02,),
                Text('Download',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 12,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
