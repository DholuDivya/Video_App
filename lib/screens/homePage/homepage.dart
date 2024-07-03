import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/screens/HomePage/Widgets/all_category.dart';
import 'package:vimeo_clone/screens/SubscriptionScreen/subscription_page.dart';
import 'package:vimeo_clone/screens/ShortsScreen/shorts_page.dart';
import 'package:vimeo_clone/utils/Widgets/horizontal_list.dart';
import '../../Utils/Widgets/bottom_nav_bar.dart';
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
              title: Text(appName, style: TextStyle(
                fontFamily: fontFamily,
                // fontWeight: FontWeight
              ),),
              // centerTitle: true,
              floating: true,
              pinned: false,
              snap: false,
              backgroundColor: Theme.of(context).colorScheme.surface,
              leading: Icon(Remix.youtube_fill, size: 35, color: Colors.red,),
              actions: [
                IconButton(
                  onPressed: () {
                    GoRouter.of(context).pushNamed('searchPage');
                  },
                  icon: Icon(HeroiconsOutline.magnifyingGlass, size: 22,),
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
    return CustomHorizontalList(
      categoryList: categoryList,
      selectedIndex: isCategory,
      onCategorySelected: (index) {
        setState(() {
          isCategory = index;
        });
      },
    );
  }
}
