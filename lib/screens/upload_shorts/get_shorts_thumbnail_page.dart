// import 'dart:io';
//
// import 'package:dotted_border/dotted_border.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:heroicons_flutter/heroicons_flutter.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:vimeo_clone/bloc/get_thumbnail_of_shorts/get_shorts_thumbnail_bloc.dart';
// import 'package:vimeo_clone/bloc/get_thumbnail_of_shorts/get_shorts_thumbnail_event.dart';
// import 'package:vimeo_clone/bloc/get_thumbnail_of_shorts/get_shorts_thumbnail_state.dart';
// import 'package:vimeo_clone/config/constants.dart';
//
// class GetShortsThumbnailPage extends StatefulWidget {
//   const GetShortsThumbnailPage({super.key});
//
//   @override
//   State<GetShortsThumbnailPage> createState() => _GetShortsThumbnailPageState();
// }
//
// class _GetShortsThumbnailPageState extends State<GetShortsThumbnailPage> {
//   CroppedFile? shortThumbnail;
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add thumbnail'),
//       ),
//
//       body: BlocBuilder<GetShortsThumbnailBloc, GetShortsThumbnailState>(
//         builder: (BuildContext context, GetShortsThumbnailState state) {
//           if(state is GetShortsThumbnailLoading){
//             return const Center(child: CircularProgressIndicator());
//           }else if(state is GetShortsThumbnailSuccess){
//             print('SUCCESS STATE OF GET SHORTS THUMBNAIL SUCCESS   ------ ');
//             shortThumbnail = state.shortThumbnail;
//             print(']]]]]]]]]]]]]]]]]]     ${shortThumbnail!.path}');
//
//           }
//           return Padding(
//             padding: EdgeInsets.all(10),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 shortThumbnail == null ? InkWell(
//                   borderRadius: BorderRadius.circular(15),
//                   onTap: (){
//                     context.read<GetShortsThumbnailBloc>().add(GetShortsThumbnailRequest());
//                   },
//                   child: AspectRatio(
//                     aspectRatio: 9/16,
//                     child: DottedBorder(
//                       color: Theme.of(context).colorScheme.secondaryFixedDim,
//                       borderType: BorderType.RRect,
//                       dashPattern: [4, 3],
//                       radius: Radius.circular(15),
//                       child: Center(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Add thumbnail of your shorts',
//                               style: TextStyle(
//                                   fontFamily: fontFamily,
//                                   fontSize: 15,
//                                   color: Theme.of(context)
//                                       .colorScheme
//                                       .secondaryFixedDim),
//                             ),
//                             SizedBox(
//                               height: 15.h,
//                             ),
//                             ClipRRect(
//
//                               // radius: 50,
//                               child: Container(
//                                 height: 300.h,
//                                 width: 230.w,
//                                 decoration: BoxDecoration(
//                                     color: Theme.of(context).colorScheme.tertiaryFixedDim,
//                                     borderRadius: BorderRadius.circular(15)
//                                 ),
//                                 child: Icon(
//                                   HeroiconsOutline.plus,
//                                   size: 25,
//                                   color: Theme.of(context).colorScheme.secondaryFixedDim,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//                 : InkWell(
//                   borderRadius: BorderRadius.circular(15),
//                   onTap: (){
//                     context.read<GetShortsThumbnailBloc>().add(GetShortsThumbnailRequest());
//                   },
//                   child: AspectRatio(
//                       aspectRatio: 9/16,
//                     child: Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           image: DecorationImage(
//                               image: FileImage(File(shortThumbnail!.path))
//                           )
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 ElevatedButton(
//                     style: ButtonStyle(
//                         shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
//                             RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15)
//                             )
//                         )
//                     ),
//                     onPressed: (){},
//                     child: Container(
//                         alignment: Alignment.center,
//                         height: 30.h,
//                         width: double.infinity,
//                         child: Text('Next',
//                           style: TextStyle(
//                               fontFamily: fontFamily,
//                               fontSize: 22.sp,
//                               fontWeight: FontWeight.w500
//                           ),
//                         ))
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }












import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:vimeo_clone/bloc/get_thumbnail_of_shorts/get_shorts_thumbnail_bloc.dart';
import 'package:vimeo_clone/bloc/get_thumbnail_of_shorts/get_shorts_thumbnail_event.dart';
import 'package:vimeo_clone/bloc/get_thumbnail_of_shorts/get_shorts_thumbnail_state.dart';
import 'package:vimeo_clone/config/constants.dart';

class GetShortsThumbnailPage extends StatefulWidget {
  const GetShortsThumbnailPage({super.key});

  @override
  State<GetShortsThumbnailPage> createState() => _GetShortsThumbnailPageState();
}

class _GetShortsThumbnailPageState extends State<GetShortsThumbnailPage> {
  CroppedFile? shortThumbnail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addThumbnail),
      ),
      body: BlocBuilder<GetShortsThumbnailBloc, GetShortsThumbnailState>(
        builder: (BuildContext context, GetShortsThumbnailState state) {
          if (state is GetShortsThumbnailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetShortsThumbnailSuccess) {
            shortThumbnail = state.shortThumbnail;
          }

          return Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    context
                        .read<GetShortsThumbnailBloc>()
                        .add(GetShortsThumbnailRequest());
                  },
                  child: AspectRatio(
                    aspectRatio: 9 / 16,
                    child: shortThumbnail == null
                        ? DottedBorder(
                      color:
                      Theme.of(context).colorScheme.secondaryFixedDim,
                      borderType: BorderType.RRect,
                      dashPattern: [4, 3],
                      radius: Radius.circular(15),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.addThumbnailOfYourShorts,
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
                              child: Container(
                                height: 300.h,
                                width: 230.w,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiaryFixedDim,
                                    borderRadius:
                                    BorderRadius.circular(15)),
                                child: Icon(
                                  HeroiconsOutline.plus,
                                  size: 25,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryFixedDim,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: FileImage(File(shortThumbnail!.path)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if(shortThumbnail != null){
                      GoRouter.of(context).pushNamed('uploadShortsPage', extra: shortThumbnail);
                    }else{
                      print('THUMBNAIL IS NOT SELECTED FROM USER ');
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 30.h,
                    width: double.infinity,
                    child: Text(
                      AppLocalizations.of(context)!.next,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
