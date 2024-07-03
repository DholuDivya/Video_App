import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/config/constants.dart';

class LikeDislikeButton extends StatefulWidget {
  final int initialLikeCount;
  final bool initialIsLiked;
  final bool initialIsDisliked;

  const LikeDislikeButton({
    Key? key,
    this.initialLikeCount = 0,
    this.initialIsLiked = false,
    this.initialIsDisliked = false,
  }) : super(key: key);

  @override
  _LikeDislikeButtonState createState() => _LikeDislikeButtonState();
}

class _LikeDislikeButtonState extends State<LikeDislikeButton> {
  late bool _isLiked;
  late bool _isDisLiked;
  late int _likeCount;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.initialIsLiked;
    _isDisLiked = widget.initialIsDisliked;
    _likeCount = widget.initialLikeCount;
  }

  void _toggleLike() {
    setState(() {
      if (_isLiked) {
        _isLiked = false;
        _likeCount--;
      } else {
        _isLiked = true;
        _likeCount++;
        if (_isDisLiked) {
          _isDisLiked = false;
        }
      }
    });
  }

  void _toggleDislike() {
    setState(() {
      if (_isDisLiked) {
        _isDisLiked = false;
      } else {
        _isDisLiked = true;
        if (_isLiked) {
          _isLiked = false;
          _likeCount--;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(25),
          ),
          padding: EdgeInsets.only(
            left: ScreenSize.screenWidth(context) * 0.03,
            right: ScreenSize.screenWidth(context) * 0.03,
            top: ScreenSize.screenHeight(context) * 0.009,
            bottom: ScreenSize.screenHeight(context) * 0.009,
          ),
          child: Row(
            children: [
              InkWell(
                onTap: _toggleLike,
                child: Row(
                  children: [
                    _isLiked
                        ? const Icon(Remix.thumb_up_fill, size: 17)
                        : const Icon(Remix.thumb_up_line, size: 17),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Text(
                      '$_likeCount',
                      style: const TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              const VerticalDivider(thickness: 0.5),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              InkWell(
                onTap: _toggleDislike,
                child: _isDisLiked
                    ? const Icon(Remix.thumb_down_fill, size: 17)
                    : const Icon(Remix.thumb_down_line, size: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
