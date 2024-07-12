import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/Utils/Widgets/shimmer.dart';
import 'package:vimeo_clone/bloc/video_category/video_category_bloc.dart';
import 'package:vimeo_clone/bloc/video_category/video_category_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/screens/HomePage/Widgets/all_category.dart';
import 'package:vimeo_clone/screens/SubscriptionScreen/subscription_page.dart';
import 'package:vimeo_clone/screens/ShortsScreen/shorts_page.dart';
import '../../Utils/Widgets/bottom_nav_bar.dart';
import '../../bloc/video_category/video_category_event.dart';
import '../../config/colors.dart';
import '../user_page/user_page.dart';
import '../user_page/widgets/custom_user_page_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysHide;

  bool _isIndex1 = false;
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Toggle dark based on index
    if (index == 1) {
      setState(() {
        _isIndex1 = !_isIndex1;
      });
    }
  }

  List screens = [
    const HomePageContent(),
    ShortsPage(),
    const SubscriptionsPage(),
    const UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
        onAddButtonPressed: addButton,
        screenHeight: ScreenSize.screenHeight(context) * 0,
        screenWidth: ScreenSize.screenWidth(context) * 0,
      ),

    );
  }


  addButton(){
    return showModalBottomSheet(
        backgroundColor: Theme.of(context).colorScheme.surface,
        context: context,
        builder: (context) {
      return SizedBox(
          height: ScreenSize.screenHeight(context) * 0.35,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  UserPageButton(
                      buttonName: 'Create short',
                      buttonIcon: HeroiconsOutline.camera
                  ),
                  UserPageButton(
                      buttonName: 'Upload a Video',
                      buttonIcon: HeroiconsOutline.arrowUpOnSquare
                  ),
                  UserPageButton(
                      buttonName: 'Go Live',
                      buttonIcon: HeroiconsOutline.share
                  ),



                  // ElevatedButton(
                  //   onPressed: () {},
                  //   // color: Theme.of(context).colorScheme.primary,
                  //   // height: ScreenSize.screenHeight(context) * 0.08,
                  //   child: Row(
                  //     children: [
                  //       Icon(Icons.edit, size: 20,),
                  //       SizedBox(
                  //         width: ScreenSize.screenWidth(context) * 0.1,
                  //       ),
                  //       Text(
                  //         'Video maker',
                  //         style: TextStyle(fontSize: 18,
                  //           fontFamily: fontFamily
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () {},
                  //   // color: Theme.of(context).colorScheme.primary,
                  //   // height: ScreenSize.screenHeight(context) * 0.08,
                  //   child: Row(
                  //     children: [
                  //       Icon(Remix.record_circle_line, size: 20,),
                  //       SizedBox(
                  //         width: ScreenSize.screenWidth(context) * 0.1,
                  //       ),
                  //       Text(
                  //         'Record a video',
                  //         style: TextStyle(fontSize: 18,
                  //           fontFamily: fontFamily
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () {},
                  //   // color: Theme.of(context).colorScheme.primary,
                  //   // height: ScreenSize.screenHeight(context) * 0.08,
                  //   child: Row(
                  //     children: [
                  //       Icon(Remix.live_line, size: 20,),
                  //       SizedBox(
                  //         width: ScreenSize.screenWidth(context) * 0.1,
                  //       ),
                  //       Text(
                  //         'Go live',
                  //         style: TextStyle(fontSize: 18,
                  //           fontFamily: fontFamily
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () {},
                  //   // color: Theme.of(context).colorScheme.primary,
                  //   // height: ScreenSize.screenHeight(context) * 0.08,
                  //   child: Row(
                  //     children: [
                  //       Icon(Remix.upload_2_line, size: 20,),
                  //       SizedBox(
                  //         width: ScreenSize.screenWidth(context) * 0.1,
                  //       ),
                  //       Text(
                  //         'Upload a video',
                  //         style: TextStyle(fontSize: 18,
                  //           fontFamily: fontFamily
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ));
    });
  }

}







class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {

  // bool isSelectedCategory = false;
  int isCategory = 0;
  List<Map<String, dynamic>> categoryList = [
    {
      "type": 'All',
      "isSelected": true,
    },
    {
      "type": 'Trending',
      "isSelected": false,
    },
    {
      "type": 'Music',
      "isSelected": false,
    },
    {
      "type": 'Sports',
      "isSelected": false,
    },
    {
      "type": 'News',
      "isSelected": false,
    },
    {
      "type": 'Gaming',
      "isSelected": false,
    },
    {
      "type": 'Comedy',
      "isSelected": false,
    },

  ];
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        // backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(

              title: const Text(
                appName,
                style: TextStyle(
                  fontFamily: fontFamily,
                // fontWeight: FontWeight
                ),
              ),
              floating: true,
              pinned: false,
              snap: false,
              // backgroundColor: Theme.of(context).colorScheme.surface,
              leading: const Icon(Remix.youtube_fill, size: 35, color: Colors.red,),
              actions: [
                IconButton(
                  onPressed: () {
                    GoRouter.of(context).pushNamed('searchPage');
                  },
                  icon: const Icon(HeroiconsOutline.magnifyingGlass, size: 22,),
                ),
                // SizedBox(width: screenWidth * 0.01),
                IconButton(
                  onPressed: () {
                    GoRouter.of(context).pushNamed('notificationPage');
                  },
                  icon: const Icon(HeroiconsOutline.bell, size: 22,),
                ),
                SizedBox(width: ScreenSize.screenWidth(context) * 0.008),
              ],

              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(ScreenSize.screenHeight(context) * 0.06),
                  child: Column(
                    children: [
                      categoryListView(),
                      SizedBox(height: ScreenSize.screenHeight(context) * 0.006,)
                    ],
                  )
              ),
            ),

            SliverToBoxAdapter(
              child: AllCategory(category: categoryList[isCategory]['type']),
            ),

          ],
        ),
    );
  }


  Widget categoryListView(){
    return BlocBuilder<VideoCategoriesBloc, VideoCategoryState>(
      builder: (BuildContext context, state) {
        if(state is VideoCategoriesLoading){
          return Center(child: CircularProgressIndicator(),);
        }else if(state is VideoCategoriesLoaded){
          return Container(
            // color: Colors.red,
            height: ScreenSize.screenHeight(context) * 0.04,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.categories.length,
                itemBuilder: (context, index) {

                  return Padding(
                    padding: EdgeInsets.only(
                      left: ScreenSize.screenWidth(context) * 0.02,
                      // right: ScreenSize.screenWidth(context) * 0.001
                    ),
                    child: GestureDetector(
                      onTap: (){
                        // onCategorySelected(index);
                        context.read<VideoCategoriesBloc>().add(SelectCategory(selectedCategory: index));

                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: index == state.selectedCategory ? blue : Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(20),
                          // border: Border.all(
                          //     color: index == state.selectedCategory ?  selectedTabOutline : unSelectedTabOutline,
                          //     width: 0.5
                          // )
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenSize.screenWidth(context) * 0.05,
                          // vertical: screenHeight*0.0001
                        ),
                        child: Center(
                          child: Text(
                            '${state.categories[index].name}',
                            style: TextStyle(
                              // color: index == state.selectedCategory ? tabButton1 : tabButton2,
                                color: index == state.selectedCategory ? Colors.white : Colors.black87,
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

        return ListView.builder(
          itemCount: 8,
            itemBuilder: (context, index){
              return ShimmerWidget.rectangular(
                  height: 20.h,
                  isBorder: false
              );
            }
        );
      },
    );
  }

// CustomHomePageCategoriesList(
//   categoryList: state.categories,
//   categoryName: state.categories,
//   selectedIndex: isCategory,
//   onCategorySelected: (index) {
//     setState(() {
//       isCategory = index;
//     });
//   },
// );
}
