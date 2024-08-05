import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:vimeo_clone/config/constants.dart';

class GetShortsThumbnail extends StatelessWidget {
  const GetShortsThumbnail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add thumbnail'),
      ),

      floatingActionButton: ElevatedButton(
          onPressed: (){},
          child: Container(
            padding: EdgeInsets.only(left: 10),
              child: Text('Next'))
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: AspectRatio(
          aspectRatio: 9/16,
          child: DottedBorder(
            color: Theme.of(context).colorScheme.secondaryFixedDim,
            borderType: BorderType.RRect,
            dashPattern: [4, 3],
            radius: Radius.circular(15),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Add thumbnail of your shorts',
                    style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 15,
                        color: Theme.of(context)
                            .colorScheme
                            .secondaryFixedDim),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  ClipRRect(

                    // radius: 50,
                    child: Container(
                      height: 300.h,
                      width: 230.w,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.tertiaryFixedDim,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Icon(
                        HeroiconsOutline.plus,
                        size: 25,
                        color: Theme.of(context).colorScheme.secondaryFixedDim,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
