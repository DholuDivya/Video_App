import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/Config/constants.dart';
import 'package:vimeo_clone/Screens/HomePage/Widgets/all_category.dart';
import 'package:vimeo_clone/Screens/SubscriptionScreen/subscription_page.dart';
import 'package:vimeo_clone/Screens/ShortsScreen/shorts_page.dart';
import 'package:vimeo_clone/Screens/accountpage.dart';
import 'package:vimeo_clone/Screens/watch.dart';

import '../../Utils/Widgets/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysHide;

  List screens = [
    const HomePageContent(),
    const ShortsPage(),
    const SubscriptionsPage(),
    const WatchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    // final double screenHeight = MediaQuery.of(context).size.height;
    // final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
          onTabTapped: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        onAddButtonPressed: addButton,
        screenHeight: ScreenSize.screenHeight(context) * 0,
        screenWidth: ScreenSize.screenWidth(context) * 0,
      ),
    );
  }


  addButton(){

    return showModalBottomSheet(
                backgroundColor: Colors.white,
                context: context,
                builder: (context)
    {
      return SizedBox(
          height: ScreenSize.screenHeight(context) * 0.5,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {},
                    color: Colors.grey[200],
                    height: ScreenSize.screenHeight(context) * 0.08,
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(
                          width: ScreenSize.screenWidth(context) * 0.1,
                        ),
                        Text(
                          'Video maker',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    color: Colors.grey[200],
                    height: ScreenSize.screenHeight(context) * 0.08,
                    child: Row(
                      children: [
                        Icon(Remix.record_circle_line),
                        SizedBox(
                          width: ScreenSize.screenWidth(context) * 0.1,
                        ),
                        Text(
                          'Record a video',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    color: Colors.grey[200],
                    height: ScreenSize.screenHeight(context) * 0.08,
                    child: Row(
                      children: [
                        Icon(Remix.live_line),
                        SizedBox(
                          width: ScreenSize.screenWidth(context) * 0.1,
                        ),
                        Text(
                          'Go live',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    color: Colors.grey[200],
                    height: ScreenSize.screenHeight(context) * 0.08,
                    child: Row(
                      children: [
                        Icon(Remix.upload_2_line),
                        SizedBox(
                          width: ScreenSize.screenWidth(context) * 0.1,
                        ),
                        Text(
                          'Upload a video',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
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

  bool isSelectedCategory = false;
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
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(appName),
              // centerTitle: true,
              floating: true,
              pinned: false,
              snap: false,
              backgroundColor: Colors.white,
              leading: Icon(Remix.youtube_fill),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Remix.search_line, color: Colors.black),
                ),
                // SizedBox(width: screenWidth * 0.01),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AccountPage())
                    );
                  },
                  icon: const Icon(Remix.notification_3_line, color: Colors.black),
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
    return Container(
      // color: Colors.red,
      height: ScreenSize.screenHeight(context) * 0.05,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                  left: ScreenSize.screenWidth(context) * 0.02,
                  right: ScreenSize.screenWidth(context) * 0.01
              ),
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    isCategory = index;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: index == isCategory ? Colors.purple[200] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                      // border: Border.all(
                      //     color: Colors.grey,
                      //     width: 0
                      // )
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenSize.screenWidth(context) * 0.04,
                    // vertical: screenHeight*0.0001
                  ),
                  child: Center(
                    child: Text(
                      categoryList[index]['type'].toString(),
                      style: TextStyle(
                          color: index == isCategory ? Colors.white : Colors.black,
                          fontSize: 11
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
