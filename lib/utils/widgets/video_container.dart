import 'package:flutter/material.dart';
import 'package:vimeo_clone/Config/constants.dart';

import '../../Screens/VideoPage/videopage.dart';

class VideoListItem extends StatelessWidget {
  final String thumbnailUrl;
  final String duration;
  final String title;
  final String author;
  final String views;
  final String uploadTime;
  final Function()? onMorePressed;

  const VideoListItem({
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VideoPage()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: ScreenSize.screenHeight(context) * 0.025),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0.0),
                    topRight: Radius.circular(0.0),
                  ),
                  child: Image.network(
                    thumbnailUrl,
                    height: ScreenSize.screenHeight(context) * 0.25,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
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
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  SizedBox(width: ScreenSize.screenWidth(context) * 0.028),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '$author - $views views - $uploadTime',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: onMorePressed ?? () {},
                    icon: Icon(Icons.more_vert),
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
