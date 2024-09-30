import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vimeo_clone/Config/colors.dart';
import 'package:vimeo_clone/Config/constants.dart';
import 'package:vimeo_clone/Screens/NotificationPage/Widgets/notification_card.dart';
import 'package:vimeo_clone/bloc/get_notification/get_notification_bloc.dart';
import 'package:vimeo_clone/bloc/get_notification/get_notification_event.dart';
import 'package:vimeo_clone/bloc/get_notification/get_notification_state.dart';
import 'package:vimeo_clone/model/get_notification_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  List<Today> today_data = [];
  List<Today> this_week_data = [];
  List<Today> older_data = [];

  @override
  void initState() {
    // TODO: implement initState
    context.read<GetNotificationBloc>().add(GetNotificationRequest());
    super.initState();
  }


  Future<void> _refreshNotification() async {
    context.read<GetNotificationBloc>().add(GetNotificationRequest());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.notifications,
          style: TextStyle(
            fontFamily: fontFamily
          ),
        ),
      ),

      body: RefreshIndicator(
        onRefresh: _refreshNotification,
        child: SingleChildScrollView(
          child: BlocBuilder<GetNotificationBloc, GetNotificationState>(
            builder: (BuildContext context, GetNotificationState state) {
              if(state is GetNotificationLoaded){

                today_data = state.notificationData.first.data!.today!;
                this_week_data = state.notificationData.first.data!.thisWeek!;
                older_data = state.notificationData.first.data!.older!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h,),
                    today_data.isNotEmpty ? Padding(
                      padding: EdgeInsets.only(
                        left: 15.h
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.today,
                        style: TextStyle(
                            fontFamily: fontFamily,
                            color: greyShade500,
                          fontSize: 15.sp
                        ),
                      ),
                    ) : const SizedBox.shrink(),
                    SizedBox(height: 3.h,),
                    today_data.isNotEmpty ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: today_data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return NotificationCard(
                          onTap: (){
                            Future.delayed(
                                const Duration(milliseconds: 200),
                                    () {
                                  print('Video clicked>>>>>>>>>>>>>.');
                                  GoRouter.of(context).pushNamed('videoPage',
                                      pathParameters: {
                                        "slug":
                                        state.notificationData.first.data!.today![index].slug!
                                      });
                                });
                          },
                          onChannelTap: () {
                            final String channelId =
                            state.notificationData.first.data!.today![index].channel!.id.toString();
                            GoRouter.of(context).pushNamed('channelProfilePage',
                                pathParameters: {'channelId': channelId});
                          },
                          videoThumbnail: state.notificationData.first.data!.today![index].thumbnail!,
                          channelProfile: state.notificationData.first.data!.today![index].channel!.logo!,
                          videoTitle: state.notificationData.first.data!.today![index].title!,
                          uploadTime: state.notificationData.first.data!.today![index].createdAtHuman!,
                        );
                      },
                    ) : const SizedBox.shrink(),
                    SizedBox(height: ScreenSize.screenHeight(context) * 0.005,),

                    this_week_data.isNotEmpty ? Padding(
                      padding: EdgeInsets.only(
                          left: 5.h
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.thisWeek,
                        style: TextStyle(
                            fontFamily: fontFamily,
                            color: greyShade500,
                            fontSize: 15.sp
                        ),
                      ),
                    ) : const SizedBox.shrink(),
                    SizedBox(height: 2.h,),
                    this_week_data.isNotEmpty ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: this_week_data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return NotificationCard(
                          onTap: (){
                            Future.delayed(
                                const Duration(milliseconds: 200),
                                    () {
                                  print('Video clicked>>>>>>>>>>>>>.');
                                  GoRouter.of(context).pushNamed('videoPage',
                                      pathParameters: {
                                        "slug":
                                        state.notificationData.first.data!.thisWeek![index].slug!
                                      });
                                });
                          },
                          onChannelTap: () {
                            final String channelId =
                              state.notificationData.first.data!.thisWeek![index].channel!.id.toString();
                            GoRouter.of(context).pushNamed('channelProfilePage',
                                pathParameters: {'channelId': channelId});
                          },
                          videoThumbnail: state.notificationData.first.data!.thisWeek![index].thumbnail!,
                          channelProfile: state.notificationData.first.data!.thisWeek![index].channel!.logo!,
                          videoTitle: state.notificationData.first.data!.thisWeek![index].title!,
                          uploadTime: state.notificationData.first.data!.thisWeek![index].createdAtHuman!,
                        );
                      },
                    ) : const SizedBox.shrink(),

                    SizedBox(height: ScreenSize.screenHeight(context) * 0.005,),

                    older_data.isNotEmpty ? Padding(
                      padding: EdgeInsets.only(
                          left: 5.h
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.older,
                        style: TextStyle(
                            fontFamily: fontFamily,
                            color: greyShade500,
                            fontSize: 15.sp
                        ),
                      ),
                    ) : const SizedBox.shrink(),
                    SizedBox(height: 4.h,),
                    older_data.isNotEmpty ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: older_data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return NotificationCard(
                          onTap: (){
                            Future.delayed(
                                const Duration(milliseconds: 200),
                                    () {
                                  print('Video clicked>>>>>>>>>>>>>.');
                                  GoRouter.of(context).pushNamed('videoPage',
                                      pathParameters: {
                                        "slug":
                                        state.notificationData.first.data!.older![index].slug!
                                      });
                                });
                          },
                          videoThumbnail: state.notificationData.first.data!.older![index].thumbnail!,
                          channelProfile: state.notificationData.first.data!.older![index].channel!.logo!,
                          videoTitle: state.notificationData.first.data!.older![index].title!,
                          uploadTime: state.notificationData.first.data!.older![index].createdAtHuman!,
                        );
                      },
                    ) : const SizedBox.shrink(),
                  ],
                );
              }
              else if(state is GetNotificationFailure){
                ToastManager().showToast(
                    context: context,
                    message: AppLocalizations.of(context)!.somethingWentWrong
                );
              }
              return Container(
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
                      AppLocalizations.of(context)!.notificationsNotAvailable,
                      style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 15.sp
                      ),
                    ),
                  ],
                ),),
              );
            },
          ),
        ),
      ),
    );
  }
}
