import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/bloc/channel_profile/channel_profile_bloc.dart';
import 'package:vimeo_clone/bloc/channel_profile/channel_profile_event.dart';
import 'package:vimeo_clone/bloc/subscribe_channel/subscribe_channel_bloc.dart';
import 'package:vimeo_clone/bloc/subscribe_channel/subscribe_channel_event.dart';
import 'package:vimeo_clone/bloc/subscribe_channel/subscribe_channel_state.dart';
import 'package:vimeo_clone/config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/screens/channel_profile_page/widgets/home_preview_page.dart';
import 'package:vimeo_clone/screens/channel_profile_page/widgets/live_preview_page.dart';
import 'package:vimeo_clone/screens/channel_profile_page/widgets/playlist_preview_page.dart';
import 'package:vimeo_clone/screens/channel_profile_page/widgets/shorts_preview_page.dart';
import 'package:vimeo_clone/screens/channel_profile_page/widgets/videos_preview_page.dart';

import '../../bloc/channel_profile/channel_profile_state.dart';

class ChannelProfilePage extends StatefulWidget {
  final String channelId;
  const ChannelProfilePage({super.key, required this.channelId});

  @override
  State<ChannelProfilePage> createState() => _ChannelProfilePageState();
}

class _ChannelProfilePageState extends State<ChannelProfilePage> {
  late bool _isSubscribed = false;
  late int _subscribeCount = 0;
  late int _channelId;

  @override
  void initState() {
    context.read<ChannelProfileBloc>().add(GetChannelProfileEvent(channelId: widget.channelId));
    final channelBloc = context.read<ChannelProfileBloc>();
    channelBloc.stream.listen((state){
      if(state is ChannelProfileLoaded){
        _isSubscribed = state.channelData.first.isSubscribed;
        _subscribeCount = state.channelData.first.subscriberCount;
      }
      print('hihjiiijijijijiji  i     $_isSubscribed');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('bbbbbbbbbbbbbbbbbbb    $_isSubscribed');
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: BlocBuilder<ChannelProfileBloc, ChannelProfileState>(
          builder: (BuildContext context, state) {

            print('ighsirghishgishgisg    $state');
            if(state is ChannelProfileLoaded){
              final channelData = state.channelData.first;
              _channelId = channelData.channel.id;

              print('************      $_isSubscribed');
              return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    pinned: true,
                    floating: false,
                    snap: false,
                    expandedHeight: 400,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Container(
                              height: 350,
                              width: double.infinity,
                              child: Image.network(
                                channelData.channel.bannerImage ?? "assets/images/travel.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    // Colors.black.withOpacity(0.5),
                                    // Colors.black.withOpacity(0.15),
                                    // Colors.black26.withOpacity(1.0)
                                    // Colors.white.withOpacity(0.5),
                                    // Colors.white.withOpacity(0.15),
                                    // Colors.white.withOpacity(1.0),
                                    Theme.of(context)
                                        .colorScheme
                                        .surface
                                        .withOpacity(0.5),
                                    Theme.of(context)
                                        .colorScheme
                                        .surface
                                        .withOpacity(0.15),
                                    Theme.of(context)
                                        .colorScheme
                                        .surface
                                        .withOpacity(1.0),
                                  ],
                                  stops: const [
                                    0.01,
                                    0.4,
                                    0.7,
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 260,
                                ),
                                Container(
                                  height: 80,
                                  width: double.infinity,
                                  // color: Colors.yellow,
                                  padding: EdgeInsets.only(left: 10),
                                  child: Row(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage:
                                        NetworkImage('${channelData.channel.logo}'),
                                      ),
                                      SizedBox(
                                        width: ScreenSize.screenWidth(context) * 0.03,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${channelData.channel.name}',
                                            style: TextStyle(
                                              fontFamily: fontFamily,
                                              fontSize: 20,
                                              // color: Colors.white,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            height: ScreenSize.screenHeight(context) *
                                                0.005,
                                          ),
                                          Text(
                                            '$_subscribeCount subscribers - ${channelData.videoCount} videos',
                                            style: TextStyle(
                                              fontFamily: fontFamily,
                                              fontSize: 12,
                                              color: Theme.of(context).colorScheme.onPrimaryFixedVariant,
                                              // color: Theme.of(context)
                                              //     .colorScheme
                                              //     .tertiary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                state.channelData.first.isAssociated == false
                                    ? BlocBuilder<SubscribeChannelBloc, SubscribeChannelState>(

                                  builder: (BuildContext context, SubscribeChannelState state) {

                                    if (state is SubscribeChannelSuccess) {
                                      // _isSubscribed = state.subscribeChannel.isNotEmpty && state.subscribeChannel[0].isSubscribed!;
                                    } else if (state is UnsubscribeChannelSuccess) {
                                      // _isSubscribed = state.subscribeChannel.isNotEmpty && state.subscribeChannel[0].isSubscribed!;
                                    }
                                    return InkWell(
                                      onTap: () {
                                        if (_isSubscribed) {
                                          ToastManager().showToast(
                                              context: context,
                                              message: 'Unsubscribed successfully'
                                          );
                                          context.read<SubscribeChannelBloc>().add(UnsubscribeChannelRequest(channelId: _channelId));
                                        } else {
                                          ToastManager().showToast(
                                              context: context,
                                              message: 'Subscribed successfully'
                                          );
                                          context.read<SubscribeChannelBloc>().add(SubscribeChannelRequest(channelId: _channelId));
                                        }

                                        setState(() {
                                          print('  BEFORE    $_isSubscribed  ');
                                          _isSubscribed = !_isSubscribed;
                                          if(_isSubscribed){
                                            _subscribeCount++;
                                          }else{
                                            _subscribeCount--;
                                          }
                                          print('  AFTER    $_isSubscribed  ');
                                        });
                                      },
                                      child: Material(
                                        elevation: 5,
                                        shadowColor: Colors.grey,
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                          height:
                                          ScreenSize.screenHeight(context) * 0.045,
                                          // width: _isSubscribed ? ScreenSize.screenWidth(context) * 0.10 : ScreenSize.screenWidth(context) * 0.35,
                                          width: ScreenSize.screenWidth(context) * 0.95,
                                          decoration: BoxDecoration(
                                            color: _isSubscribed
                                                ? Colors.grey.shade200
                                                : primaryColor,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                            child: Text(
                                              _isSubscribed? 'Unsubscribe' : 'Subscribe',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: _isSubscribed? Colors.black : Colors.white,
                                                fontFamily: fontFamily,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                                    : InkWell(
                                  onTap: () {
                                    GoRouter.of(context).pushNamed('updateChannelPage');
                                  },
                                  child: Material(
                                    elevation: 5,
                                    shadowColor: Colors.grey,
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      height:
                                      ScreenSize.screenHeight(context) * 0.045,
                                      // width: _isSubscribed ? ScreenSize.screenWidth(context) * 0.10 : ScreenSize.screenWidth(context) * 0.35,
                                      width: ScreenSize.screenWidth(context) * 0.95,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Manage',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontFamily: fontFamily,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    bottom: PreferredSize(
                      preferredSize:
                      Size.fromHeight(ScreenSize.screenHeight(context) * 0.05),
                      child: Material(
                        color: Theme.of(context).colorScheme.surface,
                        child: Column(
                          children: [
                            TabBar(
                              // overlayColor: WidgetStateProperty.all<Color?>(Colors.blue),
                              tabAlignment: TabAlignment.start,
                              isScrollable: true,
                              dividerColor: Theme.of(context).colorScheme.secondary,
                              unselectedLabelColor:
                              Theme.of(context).colorScheme.tertiary,
                              labelColor: primaryColor,
                              indicatorColor: primaryColor,
                              tabs: const [
                                Tab(child: Text('Home', style: TextStyle(fontFamily: fontFamily),)),
                                Tab(child: Text('Videos', style: TextStyle(fontFamily: fontFamily))),
                                Tab(child: Text('Shorts', style: TextStyle(fontFamily: fontFamily))),
                                Tab(child: Text('Playlist', style: TextStyle(fontFamily: fontFamily))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          GoRouter.of(context).pushNamed('SearchPage');
                        },
                        icon: const Icon(
                          Remix.search_line,
                          size: 22,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          GoRouter.of(context).pushNamed('notificationPage');
                        },
                        icon: const Icon(
                          Remix.notification_3_line,
                          size: 22,
                        ),
                      ),
                      SizedBox(width: ScreenSize.screenWidth(context) * 0.008),
                    ],
                  ),
                ],
                body: TabBarView(
                  children: [
                    // HOME
                    HomePreviewPage(),
                    // Container(),

                    // VIDEOS
                    VideosPreviewPage(),
                    // Container(),


                    // SHORTS
                    ShortsPreviewPage(),
                    // Container(),


                    // PLAYLIST
                    PlaylistPreviewPage(),
                    // Container(),
                  ],
                ),

              );
            }
            return Center(child: SpinKitThreeBounce(
              size: 30,
              color: greyShade500,
            ),);
          },
        ),
      ),
    );
  }
}
