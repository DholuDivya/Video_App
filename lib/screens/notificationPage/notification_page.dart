import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/Config/constants.dart';
import 'package:vimeo_clone/Screens/NotificationPage/Widgets/notification_card.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications',
          style: TextStyle(
            // fontFamily: fontFamily
          ),
        ),

        actions: [
          IconButton(
              onPressed: (){
                GoRouter.of(context).pushNamed('searchPage');
              },
              icon: Icon(Remix.search_line)
          ),

          IconButton(
              onPressed: (){},
              icon: Icon(Remix.more_2_fill)
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            NotificationCard(
              videoTitle: 'Tarak Mehta ka Ooltha Chashma - Episode 254',
              channelName: 'Sony Liv',
              // videoThumbnail: null,
            ),
            SizedBox(height: ScreenSize.screenHeight(context) * 0.01,),

            NotificationCard(
              // userProfile: null,
              videoTitle: 'Tarak Mehta ka Ooltha Chashma - Episode 255',
              channelName: 'Sony Liv',
              // videoThumbnail: null,
            ),
            SizedBox(height: ScreenSize.screenHeight(context) * 0.01,),


            NotificationCard(
              // userProfile: null,
              videoTitle: 'Tarak Mehta ka Ooltha Chashma - Episode 256',
              channelName: 'Sony Liv',
              // videoThumbnail: null,
            ),
            SizedBox(height: ScreenSize.screenHeight(context) * 0.01,),


            NotificationCard(
              // userProfile: null,
              videoTitle: 'Tarak Mehta ka Ooltha Chashma - Episode 257',
              channelName: 'Sony Liv',
              // videoThumbnail: null,
            ),
            SizedBox(height: ScreenSize.screenHeight(context) * 0.01,),


            NotificationCard(
              // userProfile: null,
              videoTitle: 'Tarak Mehta ka Ooltha Chashma - Episode 258',
              channelName: 'Sony Liv',
              // videoThumbnail: null,
            ),
            SizedBox(height: ScreenSize.screenHeight(context) * 0.01,),


            NotificationCard(
              // userProfile: null,
              videoTitle: 'Tarak Mehta ka Ooltha Chashma - Episode 259',
              channelName: 'Sony Liv',
              // videoThumbnail: null,
            ),
            SizedBox(height: ScreenSize.screenHeight(context) * 0.01,),


            NotificationCard(
              // userProfile: null,
              videoTitle: 'Tarak Mehta ka Ooltha Chashma - Episode 260',
              channelName: 'Sony Liv',
              // videoThumbnail: null,
            ),
            SizedBox(height: ScreenSize.screenHeight(context) * 0.01,),


          ],
        ),
      ),
    );
  }
}
