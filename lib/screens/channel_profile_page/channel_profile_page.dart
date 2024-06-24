import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/Config/constants.dart';
import 'package:vimeo_clone/Config/theme_data.dart';


class ChannelProfilePage extends StatefulWidget {
  const ChannelProfilePage({super.key});

  @override
  State<ChannelProfilePage> createState() => _ChannelProfilePageState();
}

class _ChannelProfilePageState extends State<ChannelProfilePage> {
  bool _isSubscribed = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: false,
              snap: false,
              expandedHeight: 350,

              flexibleSpace: FlexibleSpaceBar(
                // title: Text('Channel Name'),
                background: Container(
                  // color: Colors.red,
                  width: double.infinity,
                  child: Column(
                    children: [
                          SizedBox(
                            // color: Colors.green,
                            height: 200,
                            width: double.infinity,
                            child: Stack(
                              children: [
                                Container(
                                  // color: Colors.orange,
                                  height: 200,
                                  width: double.infinity,
                                  child: Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Big_Buck_Bunny_thumbnail_vlc.png/1200px-Big_Buck_Bunny_thumbnail_vlc.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.yellow,
                                      ),
                                      SizedBox(height: ScreenSize.screenHeight(context) * 0.01,),
                                      Text('Channel Name',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 18,
                                          color: Colors.white
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                // Positioned(
                                //   top: ScreenSize.screenHeight(context) * 0.2,
                                //   // bottom: ScreenSize.screenHeight(context) * 0.01,
                                //   left: ScreenSize.screenWidth(context) * 0.2,
                                //   right: ScreenSize.screenWidth(context) * 0,
                                //     child: ElevatedButton(
                                //         onPressed: (){},
                                //         child: Text('Subscribed')
                                //     )
                                // )
                              ],
                            ),
                          ),
                      SizedBox(height: ScreenSize.screenHeight(context) * 0.02,),

                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: (){
                          setState(() {
                            _isSubscribed = !_isSubscribed;
                          });
                        },
                        child: Container(
                          height: ScreenSize.screenHeight(context) * 0.045,
                          width: _isSubscribed ? ScreenSize.screenWidth(context) * 0.50 : ScreenSize.screenWidth(context) * 0.45,
                          decoration: BoxDecoration(
                            color: _isSubscribed ? Colors.grey.shade200 : grade1,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              _isSubscribed ? 'Unsubscribe' : 'Subscribe',
                              style: TextStyle(
                                fontSize: 14,
                                color: _isSubscribed ? Colors.black : Colors.white,
                                fontFamily: 'Poppins',

                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: ScreenSize.screenHeight(context) * 0.02,),

                      Container(
                        height: 45,
                        width: 240,
                        // color: Colors.red,
                        // padding: EdgeInsets.only(
                        //   left: ScreenSize.screenWidth(context) * 0.15,
                        //   right: ScreenSize.screenWidth(context) * 0.15,
                        // ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 45,
                              width: 90,
                              // color: Colors.grey,
                              child: Column(
                                children: [
                                  Text('2.5M',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      color: Colors.grey[800]
                                    ),
                                  ),
                                  Text('Subscriber',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                        fontSize: 13
                                    ),
                                  )
                                ],
                              ),
                            ),

                            VerticalDivider(thickness: 1, color: Colors.grey[400],),

                            Container(
                              height: 45,
                              width: 90,
                              // color: Colors.grey,
                              child: Column(
                                children: [
                                  Text('210',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                        fontSize: 18
                                    ),
                                  ),
                                  Text('Videos',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                        fontSize: 13
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )


                    ],
                  ),
                ),
              ),


              bottom: TabBar(
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                dividerColor: Theme.of(context).colorScheme.tertiary,
                unselectedLabelColor: Theme.of(context).colorScheme.tertiary,
                labelColor: grade1,
                indicatorColor: grade1,
                tabs: [
                  Tab(child: Text('Home')),
                  Tab(child: Text('Videos')),
                  Tab(child: Text('Shorts')),
                  Tab(child: Text('Live')),
                  Tab(child: Text('Playlist')),
                ],
              ),

              actions: [
                IconButton(
                  onPressed: () {
                    GoRouter.of(context).pushNamed('SearchPage');
                  },
                  icon: Icon(Remix.search_line, size: 22,),
                ),
                // SizedBox(width: screenWidth * 0.01),
                IconButton(
                  onPressed: () {
                    GoRouter.of(context).pushNamed('notificationPage');
                  },
                  icon: const Icon(Remix.notification_3_line, size: 22,),
                ),
                SizedBox(width: ScreenSize.screenWidth(context) * 0.008),
              ],
            ),

            SliverFillRemaining(
              child: TabBarView(
                children: [
                  Center(child: Icon(Icons.directions_car)),
                  Center(child: Icon(Icons.directions_transit)),
                  Center(child: Icon(Icons.directions_bike)),
                  Center(child: Icon(Icons.directions_transit)),
                  Center(child: Icon(Icons.directions_bike)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
