import 'package:flutter/material.dart';
import 'package:vimeo_clone/Config/constants.dart';

import '../../config/colors.dart';

class VideoSortCategory extends StatelessWidget {
  final List<Map<String, dynamic>> sortCategoryList;
  final int selectedIndex;
  final ValueChanged<int> onCategorySelected;

  const VideoSortCategory({
    super.key,
    required this.sortCategoryList,
    required this.selectedIndex,
    required this.onCategorySelected
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize.screenHeight(context) * 0.04,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: ScreenSize.screenHeight(context) * 0.04,
            child: Padding(
              padding: EdgeInsets.only(
                  left: ScreenSize.screenWidth(context) * 0.02,
                  // right: ScreenSize.screenWidth(context) * 0.001
              ),
              child: GestureDetector(
                onTap: () {
                  onCategorySelected(index);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: index == selectedIndex ? blue : null,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: index == selectedIndex
                              ? unSelectedTabOutline
                              : selectedTabOutline,
                          width: 0.5)),
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenSize.screenWidth(context) * 0.05,
                    // vertical: screenHeight*0.0001
                  ),
                  child: Center(
                    child: Text(
                      sortCategoryList[index]['type'],
                      style: TextStyle(
                          // color: index == selectedIndex ? tabButton1 : tabButton2,
                          color: index == selectedIndex ? Colors.white : null,
                          fontSize: 11,
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
