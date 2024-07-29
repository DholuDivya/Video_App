import 'package:flutter/material.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';

class UserPageButton extends StatelessWidget {
  final String buttonName;
  final IconData buttonIcon;
  final VoidCallback? onTap;

  const UserPageButton({
    super.key,
    required this.buttonName,
    required this.buttonIcon,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.grey,
      onTap: onTap,
      child: Container(
        height: ScreenSize.screenHeight(context) * 0.07,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(15),
        //   color: Theme.of(context).colorScheme.tertiaryFixedDim
        // ),
        child: Center(
          child: ListTile(
            leading: Icon(buttonIcon),
            title: Text(
              buttonName,
              style: TextStyle(
                fontFamily: fontFamily,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
