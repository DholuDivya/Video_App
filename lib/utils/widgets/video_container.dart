import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/Config/constants.dart';
import 'package:vimeo_clone/config/colors.dart';

class VideoListItem extends StatelessWidget {
  final String? channelPhoto;
  final String thumbnailUrl;
  final String duration;
  final String title;
  final String author;
  final String views;
  final String uploadTime;
  final Function()? onTap;
  final Function()? onTapChannel;
  final Function()? onShowMorePressed;

  const VideoListItem({
    super.key,
    this.channelPhoto,
    required this.thumbnailUrl,
    required this.duration,
    required this.title,
    required this.author,
    required this.views,
    required this.uploadTime,
    this.onTap,
    this.onShowMorePressed,
    this.onTapChannel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: ScreenSize.screenHeight(context) * 0.01),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Stack(
              children: [

                // VIDEO THUMBNAIL --------------------------------------------------------------------------
                ClipRRect(

                  // borderRadius: BorderRadius.circular(10),
                  child: AspectRatio(
                    aspectRatio: 16/9,
                    child: Container(
                      color: Theme.of(context).colorScheme.secondary,
                      child: Image.network(
                        thumbnailUrl,
                        // height: ScreenSize.screenHeight(context) * 0.25,
                        // width: double.infinity,
                        // width: ScreenSize.screenWidth(context) * 0.97,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                // VIDEO DURATION -----------------------------------------------------------------------------
                Positioned(
                  bottom: ScreenSize.screenHeight(context) * 0.010,
                  right: ScreenSize.screenWidth(context) * 0.022,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenSize.screenWidth(context) * 0.012,
                      vertical: ScreenSize.screenHeight(context) * 0.004,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      duration,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),


            // CHANNEL PHOTO, VIDEO TITLE, CHANNEL NAME, UPLOAD TIME,---------------------------------------------
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: onTapChannel,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage('$channelPhoto')
                      // backgroundColor: Theme.of(context).colorScheme.secondary,
                      // child: Icon(Icons.person, color: Theme.of(context).colorScheme.surface),
                    ),
                  ),
                  SizedBox(width: ScreenSize.screenWidth(context) * 0.028),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '$author - $views views - $uploadTime',
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  // VERTICAL MORE BUTTON ------------------------------------------------------------------
                  IconButton(
                      onPressed: onShowMorePressed ?? (){},
                      icon: Icon(HeroiconsOutline.ellipsisVertical, size: 20,)
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
