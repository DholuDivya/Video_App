import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/bloc/channel_profile/channel_profile_bloc.dart';
import 'package:vimeo_clone/bloc/channel_profile/channel_profile_event.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/config/global_variable.dart';

class UserHeaderWidget extends StatelessWidget {
  const UserHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final String userName = Global.userData!.userName!;
    final String channelLogo = Global.userData!.userProfilePhoto!;

    print('mjsfijgio    $channelLogo');
    return Container(
      // color: red,
      height: ScreenSize.screenHeight(context) * 0.12,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Padding(
            padding: EdgeInsets.only(
              left: ScreenSize.screenWidth(context) * 0.04,
              right: ScreenSize.screenWidth(context) * 0.04,
            ),
            child: CircleAvatar(
              radius: 22.r,
              backgroundImage: channelLogo.startsWith('http')
                  ? NetworkImage(channelLogo)  // Load from network if it's a valid URL
                  : FileImage(File(channelLogo)),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: const TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 22
                )
              ),

                GestureDetector(
                  onTap: (){
                    final String? channelId = Global.userData!.userChannelId;
                    context.read<ChannelProfileBloc>().add(GetChannelProfileEvent(channelId: channelId!));
                    GoRouter.of(context).pushNamed(
                      'channelProfilePage',
                      pathParameters: {
                        'channelId': channelId
                      }
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.viewChannel,
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: fontFamily,
                          color: Colors.grey
                        )
                      ),
                      Icon(HeroiconsOutline.chevronRight, size: 10, color: Colors.grey)
                    ],
                  ),
                ),
            ],
          )
        ],
      )
    );
  }
}
