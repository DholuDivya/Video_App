import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vimeo_clone/config/constants.dart';


class CustomToggleButton extends StatelessWidget {
  final bool toggleValue;
  final String toggleState;
  final VoidCallback onTap;
  final String toggleName;
  final onChanged;
  final double? borderRadius;
  final Color? splashColor;

  const CustomToggleButton({
    super.key,
    required this.onTap,
    required this.toggleName,
    required this.toggleValue,
    required this.onChanged,
    required this.toggleState,
    this.borderRadius,
    this.splashColor
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: splashColor,
      borderRadius: BorderRadius.circular(borderRadius!),
      onTap: onTap,
      child: Container(
        height: ScreenSize.screenHeight(context) * 0.09,
        width: double.infinity,
        padding: EdgeInsets.only(
          left: ScreenSize.screenWidth(context) * 0.03,
          right: ScreenSize.screenWidth(context) * 0.03,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(toggleName,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: fontFamily
                  ),
                ),
                Text(toggleState, style: TextStyle(fontFamily: fontFamily, fontSize: 12, color: Colors.grey.shade600),)
              ],
            ),
            Container(
              height: ScreenSize.screenHeight(context) * 0.05,
              width: ScreenSize.screenWidth(context) * 0.12,
              child: FittedBox(
                fit: BoxFit.contain,
                child: CupertinoSwitch(
                    value: toggleValue,
                    onChanged: onChanged,
                    activeColor: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
