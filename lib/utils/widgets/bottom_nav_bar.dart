import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/Config/constants.dart';

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
      color: Colors.grey[200],
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomBarIconButton(
            icon: currentIndex == 0 ? Remix.home_4_fill : Remix.home_4_line,
            color: currentIndex == 0 ? Colors.black : Colors.grey,
            onPressed: () { onTabTapped(0); },
          ),
          BottomBarIconButton(
            icon: currentIndex == 1 ? Remix.video_fill : Remix.video_line,
            color: currentIndex == 1 ? Colors.black : Colors.grey,
            onPressed: () { onTabTapped(1); }
          ),


          InkWell(
            onTap: onAddButtonPressed,
            child:  Container(
              height: ScreenSize.screenHeight(context) * 0.05,
              width: ScreenSize.screenWidth(context) * 0.11,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                  border: Border.all(
                    width: 0,
                    color: Colors.grey.shade500,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50)
              ),
              child: Icon(Icons.add, color: Colors.grey, size: 30,),
            ),
          ),


          BottomBarIconButton(
            icon: currentIndex == 2 ? Remix.play_list_2_fill : Remix.play_list_2_line,
            color: currentIndex == 2 ? Colors.black : Colors.grey,
            onPressed: () { onTabTapped(2); }
          ),
          BottomBarIconButton(
            icon: currentIndex == 3 ? Remix.user_3_fill : Remix.user_3_line,
            color: currentIndex == 3 ? Colors.black : Colors.grey,
            onPressed: () { onTabTapped(3); }
          ),
        ],
      ),
    );
  }
}

class BottomBarIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const BottomBarIconButton({
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: color),
      onPressed: onPressed,
    );
  }
}

