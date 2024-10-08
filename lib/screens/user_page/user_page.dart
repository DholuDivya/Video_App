import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:vimeo_clone/config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import 'package:vimeo_clone/config/security.dart';
import 'package:vimeo_clone/screens/help/help_page.dart';
import 'package:vimeo_clone/screens/user_page/widgets/custom_user_page_button.dart';
import 'package:vimeo_clone/screens/user_page/widgets/user_header_widget.dart';
import 'package:vimeo_clone/screens/user_page/widgets/user_history_widget.dart';
import 'package:vimeo_clone/screens/user_page/widgets/user_playlist_widget.dart';
import '../../bloc/your_shorts/your_shorts_bloc.dart';
import '../../bloc/your_shorts/your_shorts_event.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../config/internet_connectivity.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  var historyLength = 0;
  var historyData = [];
  final channelId = Global.userData!.userChannelId;
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;


  @override
  void initState() {
    print('88888888888888888888888');

    CheckInternet.initConnectivity().then((List<ConnectivityResult> results) {
      if (results.isNotEmpty) {
        setState(() {
          _connectionStatus = results;
        });
      }
    });

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      if (results.isNotEmpty) {
        CheckInternet.updateConnectionStatus(results).then((value) {
          setState(() {
            _connectionStatus = value;
          });
        });
      }
    });
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
  void dispose() {
    // TODO: implement dispose
    _connectivitySubscription.cancel();
    super.dispose();
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

              _connectionStatus.contains(connectivityCheck)
                  ? SizedBox.shrink() : BlocBuilder<YourVideosBloc, YourVideosState>(
                builder: (BuildContext context, YourVideosState state) {
                  int? totalVideos;
                  print('pppppppppppppp   $state');
                  if(state is YourVideosLoaded){
                    totalVideos = state.yourVideoData.length;
                    print('&&&&&&&&&&&&&&&&&&   $totalVideos');
                  }
                  return UserPageButton(
                    buttonName: AppLocalizations.of(context)!.yourVideos,
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
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => DownloadedVideosPage())
                  // );
                  GoRouter.of(context).pushNamed('downloadVideoPage');
                },
                  buttonName: AppLocalizations.of(context)!.downloads,
                  buttonIcon: HeroiconsOutline.arrowDownTray
              ),

              // _connectionStatus.contains(connectivityCheck)
              //     ? SizedBox.shrink() :
              Divider(thickness: 0.2, color: Colors.grey,),

              _connectionStatus.contains(connectivityCheck)
                  ? SizedBox.shrink() : UserPageButton(
                  onTap: (){
                    GoRouter.of(context).pushNamed('plansPage');
                  },
                  buttonName: '${AppLocalizations.of(context)!.get} $appName ${AppLocalizations.of(context)!.premium}',
                  buttonIcon: Remix.vip_crown_line,
              ),

              // const Divider(thickness: 0.2, color: Colors.grey,),


              _connectionStatus.contains(connectivityCheck)
                  ? SizedBox.shrink() : UserPageButton(
                  buttonName: AppLocalizations.of(context)!.helpAndFeedback,
                  buttonIcon: HeroiconsOutline.questionMarkCircle,
                onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HelpPage())
                    );
                },
              ),

              _connectionStatus.contains(connectivityCheck)
                  ? Container(
                child: Center(child: CircularProgressIndicator(color: primaryColor,)),
              ) : SizedBox.shrink()

            ],
          ),
        ),
      ),
    );
  }
}







