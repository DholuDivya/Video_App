import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/Config/colors.dart';
import 'package:vimeo_clone/Config/constants.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabTapped;
  final VoidCallback onAddButtonPressed;
  final double screenHeight;
  final double screenWidth;



  const CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTabTapped,
    required this.onAddButtonPressed,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(width: 0.2,),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomBarIconButton(

            icon: currentIndex == 0 ? HeroiconsSolid.home : HeroiconsOutline.home,
            color: currentIndex == 0 ? primaryColor : null,
            onPressed: () { onTabTapped(0); },
          ),
          BottomBarIconButton(
            icon: currentIndex == 1 ? HeroiconsSolid.fire : HeroiconsOutline.fire,
              color: currentIndex == 1 ? primaryColor : null,
            onPressed: () { onTabTapped(1); }
          ),


          InkWell(
            onTap: onAddButtonPressed,
            child:  Container(
              height: ScreenSize.screenHeight(context) * 0.05,
              width: ScreenSize.screenWidth(context) * 0.11,
              decoration: BoxDecoration(
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black26,
                  //     blurRadius: 6.0,
                  //     offset: Offset(0, 2),
                  //   ),
                  // ],
                  // border: Border.all(
                  //   width: 0,
                  //   color: Colors.grey.shade500,
                  // ),
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(50)
              ),
              child: Icon(Icons.add, size: 30,),
            ),
          ),


          BottomBarIconButton(
            icon: currentIndex == 2 ? HeroiconsSolid.playCircle : HeroiconsOutline.playCircle,
            color: currentIndex == 2 ? primaryColor : null,
            onPressed: () { onTabTapped(2); }
          ),
          BottomBarIconButton(
            icon: currentIndex == 3 ? HeroiconsSolid.user : HeroiconsOutline.user,
            color: currentIndex == 3 ? primaryColor : null,
            onPressed: () { onTabTapped(3); }
          ),
        ],
      ),
    );
  }
}

class BottomBarIconButton extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final VoidCallback onPressed;

  const BottomBarIconButton({
    required this.icon,
    required this.onPressed,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: color,),
      onPressed: onPressed,
    );
  }
}

