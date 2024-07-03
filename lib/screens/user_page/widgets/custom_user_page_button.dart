import 'package:flutter/material.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/config/constants.dart';

class UserPageButton extends StatelessWidget {
  final String buttonName;
  final IconData buttonIcon;

  const UserPageButton({
    super.key,
    required this.buttonName,
    required this.buttonIcon
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
        height: ScreenSize.screenHeight(context) * 0.07,
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
