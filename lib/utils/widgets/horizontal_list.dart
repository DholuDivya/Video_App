import 'package:flutter/material.dart';
import 'package:vimeo_clone/config/colors.dart';

import '../../Config/constants.dart';
import '../../model/video_categories_model.dart';

class CustomHorizontalList extends StatelessWidget {
  final List<Map<String, dynamic>> categoryList;
  final int selectedIndex;
  final ValueChanged<int> onCategorySelected;

  const CustomHorizontalList({
    super.key,
    required this.categoryList,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {

      return Container(
        // color: Colors.red,
        height: ScreenSize.screenHeight(context) * 0.04,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                    left: ScreenSize.screenWidth(context) * 0.02,
                    // right: ScreenSize.screenWidth(context) * 0.001
                ),
                child: GestureDetector(
                  onTap: (){
                    onCategorySelected(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: index == selectedIndex ? blue : Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(20),
                      // border: Border.all(
                      //     color: index == selectedIndex ?  selectedTabOutline : unSelectedTabOutline,
                      //     width: 0.5
                      // )
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenSize.screenWidth(context) * 0.05,
                      // vertical: screenHeight*0.0001
                    ),
                    child: Center(
                      child: Text(
                        categoryList[index]['type'],
                        style: TextStyle(
                          // color: index == selectedIndex ? tabButton1 : tabButton2,
                            color: index == selectedIndex ? Colors.white : Colors.black87,
                            fontSize: 11,
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
        ),
      );
  }
}






class CustomHomePageCategoriesList extends StatelessWidget {
  final List<VideoCategoriesModel> categoryList;
  final int selectedIndex;
  final ValueChanged<int> onCategorySelected;
  final categoryName;

  const CustomHomePageCategoriesList({
    super.key,
    required this.categoryList,
    required this.selectedIndex,
    required this.onCategorySelected,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      // color: Colors.red,
      height: ScreenSize.screenHeight(context) * 0.04,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                left: ScreenSize.screenWidth(context) * 0.02,
                // right: ScreenSize.screenWidth(context) * 0.001
              ),
              child: GestureDetector(
                onTap: (){
                  onCategorySelected(index);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: index == selectedIndex ? blue : Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(20),
                    // border: Border.all(
                    //     color: index == selectedIndex ?  selectedTabOutline : unSelectedTabOutline,
                    //     width: 0.5
                    // )
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenSize.screenWidth(context) * 0.05,
                    // vertical: screenHeight*0.0001
                  ),
                  child: Center(
                    child: Text(
                      categoryName,
                      style: TextStyle(
                        // color: index == selectedIndex ? tabButton1 : tabButton2,
                          color: index == selectedIndex ? Colors.white : Colors.black87,
                          fontSize: 11,
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}

















// import 'package:flutter/material.dart';
//
// class CategoryListView extends StatelessWidget {
//   final List<Map<String, String>> categoryList;
//   final int selectedIndex;
//   final ValueChanged<int> onCategorySelected;
//
//   const CategoryListView({
//     super.key,
//     required this.categoryList,
//     required this.selectedIndex,
//     required this.onCategorySelected,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final double screenHeight = MediaQuery.of(context).size.height;
//     final double screenWidth = MediaQuery.of(context).size.width;
//
//     return Container(
//       height: screenHeight * 0.05,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: categoryList.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: EdgeInsets.only(
//               left: screenWidth * 0.02,
//               right: screenWidth * 0.01,
//             ),
//             child: GestureDetector(
//               onTap: () {
//                 onCategorySelected(index);
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: index == selectedIndex ? Colors.purple[200] : Colors.grey[200],
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 padding: EdgeInsets.symmetric(
//                   horizontal: screenWidth * 0.04,
//                 ),
//                 child: Center(
//                   child: Text(
//                     categoryList[index]['type']!,
//                     style: TextStyle(
//                       color: index == selectedIndex ? Colors.white : Colors.black,
//                       fontSize: 11,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
