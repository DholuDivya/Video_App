import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

import '../../config/constants.dart';

class ReportButton extends StatelessWidget {
  const ReportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: InkWell(
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
                Icon(Remix.flag_2_line, size: 15,),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Text(
                  'Report',
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
