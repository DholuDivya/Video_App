import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/config/constants.dart';

class SaveButton extends StatelessWidget {
  const SaveButton ({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceDim,
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
              Icon(Remix.bookmark_line, size: 15,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Text(
                'Save',
                style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 12
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
