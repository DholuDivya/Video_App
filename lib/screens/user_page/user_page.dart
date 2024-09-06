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
import 'package:vimeo_clone/bloc/your_videos/your_videos_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import 'package:vimeo_clone/config/security.dart';
import 'package:vimeo_clone/model/user_history_model.dart';
import 'package:vimeo_clone/screens/user_page/widgets/custom_user_page_button.dart';
import 'package:vimeo_clone/screens/user_page/widgets/user_header_widget.dart';
import 'package:vimeo_clone/screens/user_page/widgets/user_history_widget.dart';
import 'package:vimeo_clone/screens/user_page/widgets/user_playlist_widget.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  var historyLength = 0;
  var historyData = [];


  @override
  void initState() {
    print('88888888888888888888888   ');

    context.read<GetUserHistoryBloc>().add(GetUserHistoryRequest());

    final historyBloc = context.read<GetUserHistoryBloc>();
    historyBloc.stream.listen((state){
      if(state is GetUserHistorySuccess){
        historyLength = state.userHistory.first.data!.length;
        historyData = state.userHistory.first.data!;
      }
    });
    super.initState();
  }

  Future<void> refreshData() async {
    context.read<GetUserHistoryBloc>().add(GetUserHistoryRequest());
    context.read<GetUserPlaylistBloc>().add(GetUserPlaylistRequest());
  }


  @override
  Widget build(BuildContext context) {
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
              log('***********************${Global.userData}*********************');
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


              // historyLength > 0
                  const UserHistoryWidget(),
                  // : Container(),

              // SizedBox(height: 10.h,),
              UserPlaylistWidget(),

              BlocBuilder<YourVideosBloc, YourVideosState>(
                builder: (BuildContext context, YourVideosState state) {
                  int? totalVideos;
                  print('pppppppppppppp   $state');
                  if(state is YourVideosLoaded){

                    totalVideos = state.videoData.first.videoCount;
                    print('&&&&&&&&&&&&&&&&&&   $totalVideos');
                  }
                  return UserPageButton(
                    buttonName: 'Your Videos',
                    subTitle: '$totalVideos videos',
                    buttonIcon: HeroiconsOutline.play,
                    onTap: (){
                      Future.delayed(const Duration(milliseconds: 220),(){
                        GoRouter.of(context).pushNamed('yourVideoPage');
                      });
                    },
                  );
                },
              ),


              const UserPageButton(
                  buttonName: 'Downloads',
                  buttonIcon: HeroiconsOutline.arrowDownTray
              ),

              const Divider(thickness: 0.2, color: Colors.grey,),

              UserPageButton(
                  onTap: (){
                    GoRouter.of(context).pushNamed('plansPage');
                  },
                  buttonName: 'Get $appName Premium',
                  appLogo: HeroiconsOutline.arrowUpRight,
              ),

              // const Divider(thickness: 0.2, color: Colors.grey,),

              UserPageButton(
                  buttonName: 'Time watched',
                  buttonIcon: HeroiconsOutline.chartBarSquare,
                onTap: (){
                    GoRouter.of(context).pushNamed('editVideoDetailPage');
                    // GoRouter.of(context).pushNamed('editVideoDetailPage', pathParameters: {
                    //   'videoSlug': ''
                    // });
                },
              ),

              UserPageButton(
                  buttonName: 'Help & feedback',
                  buttonIcon: HeroiconsOutline.questionMarkCircle,
                onTap: (){},
              ),

            ],
          ),
        ),
      ),
    );
  }
}







