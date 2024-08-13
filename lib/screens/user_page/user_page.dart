import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_bloc.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_event.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import 'package:vimeo_clone/config/security.dart';
import 'package:vimeo_clone/screens/splashScreen/splash_screen.dart';
import 'package:vimeo_clone/screens/user_page/widgets/custom_user_page_button.dart';
import 'package:vimeo_clone/screens/user_page/widgets/user_header_widget.dart';
import 'package:vimeo_clone/screens/user_page/widgets/user_history_widget.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          IconButton(
              onPressed: () {
                GoRouter.of(context).pushNamed('notificationPage');
              },
              icon: Icon(HeroiconsOutline.bell),
          ),

          IconButton(
            onPressed: () {
              GoRouter.of(context).pushNamed('searchPage');
            },
            icon: Icon(HeroiconsOutline.magnifyingGlass),
          ),

          IconButton(
            icon: Icon(HeroiconsOutline.cog8Tooth),
            onPressed: () {
              print('Next Setting Page ${headers}');
              log('***********************${Global.userData}*********************');
              // log('***********************${Global.userName}*********************');
              GoRouter.of(context).pushNamed('settingPage');
            },

          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            UserHeaderWidget(),
            // SizedBox(height: ScreenSize.screenHeight(context) * 0.00,),

            UserHistoryWidget(),

            BlocBuilder<YourVideosBloc, YourVideosState>(
              builder: (BuildContext context, YourVideosState state) {
                var totalVideos;
                if(state is YourVideosLoaded){
                  totalVideos = state.videoData.first.videoCount;
                  print('&&&&&&&&&&&&&&&&&&   ${totalVideos}');
                }
                return UserPageButton(
                  buttonName: 'Your Videos',
                  subTitle: '${totalVideos} videos',
                  buttonIcon: HeroiconsOutline.play,
                  onTap: (){
                    Future.delayed(Duration(milliseconds: 220),(){
                      GoRouter.of(context).pushNamed('yourVideoPage');
                    });
                  },
                );
              },
            ),


            UserPageButton(
                buttonName: 'Downloads',
                buttonIcon: HeroiconsOutline.arrowDownTray
            ),

            Divider(thickness: 0.2, color: Colors.grey,),

            UserPageButton(
                buttonName: 'Your Movies',
                buttonIcon: HeroiconsOutline.film
            ),

            UserPageButton(
                buttonName: 'Get ${appName} Premium',
                buttonIcon: Remix.youtube_line
            ),

            Divider(thickness: 0.2, color: Colors.grey,),

            UserPageButton(
                buttonName: 'Time watched',
                buttonIcon: HeroiconsOutline.chartBarSquare
            ),

            UserPageButton(
                buttonName: 'Help & feedback',
                buttonIcon: HeroiconsOutline.questionMarkCircle
            ),

          ],
        ),
      ),
    );
  }
}
