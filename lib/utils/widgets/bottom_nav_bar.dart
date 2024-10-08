import 'package:flutter/material.dart';
import 'package:vimeo_clone/Config/colors.dart';
import 'package:vimeo_clone/Config/constants.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class CustomBottomNavigationBar extends StatelessWidget {

  final int currentIndex;
  final ValueChanged<int> onTabTapped;
  final VoidCallback onAddButtonPressed;
  final double screenHeight;
  final double screenWidth;
  final Color backgroundColor;



  const CustomBottomNavigationBar({
    super.key,
    required this.backgroundColor,
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
        color: backgroundColor,
        // color: Theme.of(context).colorScheme.surface,
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
            label: currentIndex == 0 ? 'Home' : '',
            color: currentIndex == 0 ? primaryColor : greyShade600,
            onPressed: () { onTabTapped(0); },
          ),
          BottomBarIconButton(
            icon: currentIndex == 1 ? HeroiconsSolid.fire : HeroiconsOutline.fire,
              label: currentIndex == 1 ? 'Shorts' : '',
              color: currentIndex == 1 ? primaryColor : greyShade600,
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
              label: currentIndex == 2 ? 'Subscriptions' : '',
            color: currentIndex == 2 ? primaryColor : greyShade600,
            onPressed: () { onTabTapped(2); }
          ),
          BottomBarIconButton(
            icon: currentIndex == 3 ? HeroiconsSolid.user : HeroiconsOutline.user,
              label: currentIndex == 3 ? 'User' : '',
            color: currentIndex == 3 ? primaryColor : greyShade600,
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
  final String? label;
  final VoidCallback onPressed;

  const BottomBarIconButton({
    required this.icon,
    required this.onPressed,
    this.color,
    this.label
  });

  @override
  Widget build(BuildContext context) {

    return IconButton(
      icon: Icon(icon, color: color,),
      onPressed: onPressed,
    );


    // return IconButton(
    //   icon: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       Icon(icon, color: color,),
    //       Text(
    //         label!,
    //         style: TextStyle(
    //             fontFamily: fontFamily,
    //             fontSize: 8.sp
    //         ),
    //       )
    //     ],
    //   ),
    //   onPressed: onPressed,
    // );
  }
}