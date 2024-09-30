import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/bloc/channel_profile/channel_profile_bloc.dart';
import 'package:vimeo_clone/bloc/channel_profile/channel_profile_event.dart';
import 'package:vimeo_clone/bloc/get_subscribed_channel_list/get_subscribed_channel_list_bloc.dart';
import 'package:vimeo_clone/bloc/get_subscribed_channel_list/get_subscribed_channel_list_event.dart';
import 'package:vimeo_clone/bloc/get_subscribed_channel_list/get_subscribed_channel_list_state.dart';
import 'package:vimeo_clone/bloc/subscribe_channel/subscribe_channel_bloc.dart';
import 'package:vimeo_clone/bloc/subscribe_channel/subscribe_channel_event.dart';
import 'package:vimeo_clone/bloc/theme/theme_bloc.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubscriptionsPage extends StatefulWidget {
  const SubscriptionsPage({super.key});

  @override
  State<SubscriptionsPage> createState() => _SubscriptionsPageState();
}

class _SubscriptionsPageState extends State<SubscriptionsPage> {
  bool isSelectedAll = true;
  bool isSelectedPersonalized = false;
  bool isSelectedNone = false;
  bool isSubscribed = false;
  int? mode;
  var channelLength = 0;

 Future<void> refreshData() async {
   context.read<GetSubscribedChannelListBloc>().add(GetSubscribedChannelListRequest());
 }


 @override
  void initState() {
    // TODO: implement initState

    context.read<GetSubscribedChannelListBloc>().add(GetSubscribedChannelListRequest());
    final subscriptionBloc = context.read<GetSubscribedChannelListBloc>();
    subscriptionBloc.stream.listen((state){
      if(state is GetSubscribedChannelListLoaded){
        channelLength = state.channelList.length;
      }
    });
    super.initState();
  }


 @override
  Widget build(BuildContext context) {
   mode = context.read<ThemeBloc>().mode;
   print('$mode   222222');
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Container(
                padding: EdgeInsets.only(left: 15.w),
                child: mode == 1
                    ? Image.asset('assets/images/homepage_logo_light.png', height: 75.h, width: 115.w,)
                    : Image.asset('assets/images/homepage_logo_dark.png', height: 75.h, width: 115.w,),
              ),
              // centerTitle: true,
              titleSpacing: 1.0,
              floating: true,
              pinned: false,
              snap: false,
              backgroundColor: Theme.of(context).colorScheme.surface,
              // leading: const Icon(
              //   Remix.youtube_fill,
              //   size: 35,
              //   color: Colors.red,
              // ),
              actions: [
                IconButton(
                  onPressed: () {
                    GoRouter.of(context).pushNamed('searchPage');
                  },
                  icon: const Icon(
                    HeroiconsOutline.magnifyingGlass,
                    size: 22,
                  ),
                ),
                // SizedBox(width: screenWidth * 0.01),
                IconButton(
                  onPressed: () {
                    GoRouter.of(context).pushNamed('notificationPage');
                  },
                  icon: const Icon(
                    HeroiconsOutline.bell,
                    size: 22,
                  ),
                ),
                SizedBox(width: ScreenSize.screenWidth(context) * 0.008),
              ],
            ),

            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h,),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 15.w,
                      // right: 10.w
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.subscriptions,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //     left: 15.w,
                  //     right: 15.w
                  //   ),
                  //   child: Divider(thickness: 0.5, color: greyShade500,),
                  // ),
                  SizedBox(height: 5.h,),
                  BlocBuilder<GetSubscribedChannelListBloc, GetSubscribedChannelListState>(
                    builder: (BuildContext context, GetSubscribedChannelListState state) {
                      int unsubscribeChannelId = 0 ;
                      if(state is GetSubscribedChannelListLoaded){
                        print('''''''''''''''''''''' object '''''''''''''''''''''' ');
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.channelList.length,
                            itemBuilder: (context, index){
                              final channelsList = state.channelList[index];
                              channelLength = state.channelList.length;
                              unsubscribeChannelId = channelsList.channelId!;
                              // isSubscribed = channelsList.
                              return channelLength > 0 ? SizedBox(
                                height: 60,
                                child: InkWell(
                                  onTap: (){
                                    final String channelId = state.channelList[index].channelId.toString();
                                    print('00000000000000000000   $channelId');
                                    context.read<ChannelProfileBloc>().add(GetChannelProfileEvent(channelId: channelId));
                                    GoRouter.of(context).pushNamed(
                                      'channelProfilePage',
                                      pathParameters: {
                                        'channelId': channelId
                                      }
                                    );
                                  },
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 22,
                                      backgroundImage: NetworkImage(channelsList.channelLogo!),
                                    ),
                                    title: Text('${channelsList.channelName}'),
                                    trailing: isSubscribed
                                        ? SizedBox(
                                      width: 60, // Adjust this width as needed
                                      child: Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Theme.of(context).colorScheme.secondary,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            _showNotificationDialog(unsubscribeChannelId);
                                          },
                                          child: const Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(HeroiconsOutline.bell, size: 16),
                                              Icon(HeroiconsOutline.chevronDown, size: 16),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                        : const SizedBox.shrink(),
                                  ),
                                ),
                              ) : Container(
                                child: Center(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      // color: red,
                                      height: 120.h,
                                      width: 250.w,
                                      child: Image.asset('assets/images/no_data.png'),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.subscriptionsNotFound,
                                      style: TextStyle(
                                          fontFamily: fontFamily,
                                          fontSize: 15.sp
                                      ),
                                    ),
                                  ],
                                ),),
                              );
                          }
                        );
                      }
                      return Container();
                      // return ListView.builder(
                      //   shrinkWrap: true,
                      //   itemCount: 15,
                      //     itemBuilder: (context, index){
                      //       return Padding(
                      //         padding: EdgeInsets.only(
                      //           top: 5.h,
                      //           bottom: 5.h
                      //         ),
                      //         child: ShimmerWidget.rectangular(
                      //           height: 30.h,
                      //             width: 100.w,
                      //             isBorder: true
                      //         ),
                      //       );
                      //     }
                      // );
                    },
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }


  void _showNotificationDialog(channelId) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.notifications,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 20
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomNotificationRow(
                    notificationIcon: HeroiconsSolid.bellAlert,
                    type: AppLocalizations.of(context)!.all,
                    onTap: () {
                      setState(() {
                        isSelectedAll = true;
                        isSelectedPersonalized = false;
                        isSelectedNone = false;
                        GoRouter.of(context).pop();
                      });
                    },
                    selectedType: isSelectedAll
                        ? Remix.check_line : null,
                  ),
                  CustomNotificationRow(
                    notificationIcon: HeroiconsOutline.bell,
                    type: AppLocalizations.of(context)!.personalized,
                    onTap: (){
                      setState(() {
                        isSelectedAll = false;
                        isSelectedPersonalized = true;
                        isSelectedNone = false;
                        GoRouter.of(context).pop();
                      });
                    },
                    selectedType: isSelectedPersonalized
                        ? Remix.check_line : null,
                  ),
                  CustomNotificationRow(
                    notificationIcon: HeroiconsOutline.bellSlash,
                    type: AppLocalizations.of(context)!.none,
                    onTap: (){
                      setState(() {
                        isSelectedAll = false;
                        isSelectedPersonalized = false;
                        isSelectedNone = true;
                        // Navigator.of(context).pop();
                        GoRouter.of(context).pop();
                      });
                    },
                    selectedType: isSelectedNone
                        ? Remix.check_line : null,
                  ),

                  Divider(thickness: 0.3,),

                   CustomNotificationRow(
                        notificationIcon: HeroiconsOutline.userMinus,
                        type: AppLocalizations.of(context)!.unsubscribe,
                        onTap: (){
                          print('fgioshgosh    $channelId \$\$\$\$\$');
                          context.read<SubscribeChannelBloc>().add(UnsubscribeChannelRequest(channelId: channelId));
                          GoRouter.of(context).pop();
                          setState(() {
                            isSubscribed = !isSubscribed;
                          });
                          context.read<GetSubscribedChannelListBloc>().add(GetSubscribedChannelListRequest());
                        },
                      )

                ],
              ),
            );
          }
        );
      },
    );
  }


}

class CustomNotificationRow extends StatelessWidget {
  final IconData notificationIcon;
  final String type;
  final VoidCallback? onTap;
  final IconData? selectedType;

  const CustomNotificationRow({
    super.key,
    required this.notificationIcon,
    required this.type,
    this.onTap,
    this.selectedType,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Row(
                  children: [
                    Icon(notificationIcon, size: 18,),
                    SizedBox(width: 20),
                    Text(type, style: TextStyle(fontFamily: fontFamily, fontSize: 15),),
                  ],
                ),
                Icon(selectedType)
            ],
          ),
        ),
      ),
    );
  }
}
