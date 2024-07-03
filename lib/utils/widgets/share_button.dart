import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

import 'package:vimeo_clone/config/constants.dart';

class ShareButton extends StatefulWidget {
  const ShareButton({super.key});

  @override
  State<ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: InkWell(
          onTap: (){
            // final RenderBox box = context.findRenderObject() as RenderBox;
            // Share.share(
            //   'Check out this video!',
            //   subject: 'Awesome Video',
            //   sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
            // );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(25),
            ),
            padding: EdgeInsets.only(
              left: ScreenSize.screenWidth(context) * 0.03,
              right: ScreenSize.screenWidth(context) * 0.03,
              top: ScreenSize.screenHeight(context) * 0.009,
              bottom: ScreenSize.screenHeight(context) * 0.009,
            ),
            child: Row(
              children: [
                Icon(Remix.share_forward_line, size: 15,),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Text(
                  'Share',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 12
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
