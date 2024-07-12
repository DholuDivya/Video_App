import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vimeo_clone/Config/constants.dart';
import 'package:vimeo_clone/config/colors.dart';

class VideoListItem extends StatelessWidget {
  final String thumbnailUrl;
  final String duration;
  final String title;
  final String author;
  final String views;
  final String uploadTime;
  final Function()? onMorePressed;

  const VideoListItem(
      {super.key,
    required this.thumbnailUrl,
    required this.duration,
    required this.title,
    required this.author,
    required this.views,
    required this.uploadTime,
    this.onMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: ScreenSize.screenHeight(context) * 0.025),
      decoration: BoxDecoration(
        // color: Theme.of(context).colorScheme.surface,
      ),
      child: GestureDetector(
        onTap: (){
          GoRouter.of(context).pushNamed('videoPage');
        },
        child: Column(
          children: [
            Stack(
              children: [

                // VIDEO THUMBNAIL --------------------------------------------------------------------------
                ClipRRect(
                  // borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    thumbnailUrl,
                    height: ScreenSize.screenHeight(context) * 0.25,
                    width: double.infinity,
                    // width: ScreenSize.screenWidth(context) * 0.97,
                    fit: BoxFit.cover,
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
                    onTap: (){
                      GoRouter.of(context).pushNamed('channelProfilePage');
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: Icon(Icons.person, color: Theme.of(context).colorScheme.surface),
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
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '$author - $views views - $uploadTime',
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 12,
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
                    onPressed: onMorePressed ?? () {},
                    icon: Icon(Icons.more_vert, size: 18,),
                    color: Colors.grey[700],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
