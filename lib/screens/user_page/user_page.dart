import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_bloc.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_event.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_state.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_event.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_bloc.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_event.dart';
import 'package:vimeo_clone/bloc/your_videos/your_videos_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import 'package:vimeo_clone/config/security.dart';
import 'package:vimeo_clone/screens/download_video/download_video_page.dart';
import 'package:vimeo_clone/screens/help/help_page.dart';
import 'package:vimeo_clone/screens/user_page/widgets/custom_user_page_button.dart';
import 'package:vimeo_clone/screens/user_page/widgets/user_header_widget.dart';
import 'package:vimeo_clone/screens/user_page/widgets/user_history_widget.dart';
import 'package:vimeo_clone/screens/user_page/widgets/user_playlist_widget.dart';
import '../../bloc/your_shorts/your_shorts_bloc.dart';
import '../../bloc/your_shorts/your_shorts_event.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  var historyLength = 0;
  var historyData = [];
  final channelId = Global.userData!.userChannelId;


  @override
  void initState() {
    print('88888888888888888888888');

    context.read<GetUserHistoryBloc>().add(GetUserHistoryRequest());
    context.read<GetUserPlaylistBloc>().add(GetUserPlaylistRequest(channelId: int.parse(channelId!)));


    super.initState();
  }

  Future<void> refreshData() async {
    context.read<GetUserHistoryBloc>().add(GetUserHistoryRequest());
    final historyBloc = context.read<GetUserHistoryBloc>();
    historyBloc.stream.listen((state){
      if(state is GetUserHistorySuccess){
        historyLength = state.userHistory.length;
        historyData = state.userHistory;
      }
    });
    print('= = = = = = = = = = = = = = = = =$historyLength');
    context.read<GetUserPlaylistBloc>().add(GetUserPlaylistRequest(channelId: int.parse(channelId!)));
  }


  @override
  Widget build(BuildContext context) {
    final historyBloc = context.read<GetUserHistoryBloc>();
    historyBloc.stream.listen((state){
      if(state is GetUserHistorySuccess){
        historyLength = state.userHistory.length;
        historyData = state.userHistory;
      }
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                GoRouter.of(context).pushNamed('notificationPage');
              },
              icon: const Icon(HeroiconsOutline.bell),
          ),

          IconButton(
            onPressed: () {
              GoRouter.of(context).pushNamed('searchSuggestionPage');
            },
            icon: const Icon(HeroiconsOutline.magnifyingGlass),
          ),

          IconButton(
            icon: const Icon(HeroiconsOutline.cog8Tooth),
            onPressed: () {
              print('Next Setting Page $headers');
              log('***********************${Global.userData!.userChannelId}*********************');
              GoRouter.of(context).pushNamed('settingPage');
            },

          ),
        ],
      ),

      body: RefreshIndicator(
        onRefresh: refreshData,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const UserHeaderWidget(),
              // SizedBox(height: ScreenSize.screenHeight(context) * 0.00,),

              UserHistoryWidget(),

              // SizedBox(height: 10.h,),
              UserPlaylistWidget(),

              BlocBuilder<YourVideosBloc, YourVideosState>(
                builder: (BuildContext context, YourVideosState state) {
                  int? totalVideos;
                  print('pppppppppppppp   $state');
                  if(state is YourVideosLoaded){
                    totalVideos = state.yourVideoData.length;
                    print('&&&&&&&&&&&&&&&&&&   $totalVideos');
                  }
                  return UserPageButton(
                    buttonName: 'Your videos',
                    buttonIcon: HeroiconsOutline.play,
                    onTap: (){
                      final channelId = Global.userData!.userChannelId;
                      context.read<YourShortsBloc>().add(YourShortsRequest(channelId: int.parse(channelId!)));
                      context.read<YourVideosBloc>().add(GetYourVideosEvent(channelId: int.parse(channelId)));
                      Future.delayed(const Duration(milliseconds: 220),(){
                        GoRouter.of(context).pushNamed('yourVideoPage');
                      });
                    },
                  );
                },
              ),


              UserPageButton(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DownloadedVideosPage())
                  );
                },
                  buttonName: 'Downloads',
                  buttonIcon: HeroiconsOutline.arrowDownTray
              ),

              const Divider(thickness: 0.2, color: Colors.grey,),

              UserPageButton(
                  onTap: (){
                    GoRouter.of(context).pushNamed('plansPage');
                  },
                  buttonName: 'Get $appName Premium',
                  buttonIcon: Remix.vip_crown_line,
              ),

              // const Divider(thickness: 0.2, color: Colors.grey,),


              UserPageButton(
                  buttonName: 'Help & feedback',
                  buttonIcon: HeroiconsOutline.questionMarkCircle,
                onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HelpPage())
                    );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}







