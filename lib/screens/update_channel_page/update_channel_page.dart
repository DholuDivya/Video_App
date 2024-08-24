import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/utils/widgets/custom_text_field_auth.dart';
import 'package:vimeo_clone/utils/widgets/custom_text_field_upload.dart';

class UpdateChannelPage extends StatefulWidget {
  const UpdateChannelPage({super.key});

  @override
  State<UpdateChannelPage> createState() => _UpdateChannelPageState();
}

class _UpdateChannelPageState extends State<UpdateChannelPage> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: CustomScrollView(
    //     physics: NeverScrollableScrollPhysics(),
    //     slivers: [
    //       SliverAppBar(
    //         pinned: true,
    //         floating: false,
    //         snap: false,
    //         expandedHeight: 400,
    //         flexibleSpace: FlexibleSpaceBar(
    //           background: Container(
    //             width: double.infinity,
    //             child: Stack(
    //               children: [
    //                 Container(
    //                   height: 350,
    //                   width: double.infinity,
    //                   child: Image.asset(
    //                     "assets/images/sport.jpg",
    //                     fit: BoxFit.fill,
    //                   ),
    //                 ),
    //                 Container(
    //                   width: double.infinity,
    //                   // decoration: BoxDecoration(
    //                   //   gradient: LinearGradient(
    //                   //     begin: Alignment.topCenter,
    //                   //     end: Alignment.bottomCenter,
    //                   //     colors: [
    //                   //       // Colors.black.withOpacity(0.5),
    //                   //       // Colors.black.withOpacity(0.15),
    //                   //       // Colors.black26.withOpacity(1.0)
    //                   //       // Colors.white.withOpacity(0.5),
    //                   //       // Colors.white.withOpacity(0.15),
    //                   //       // Colors.white.withOpacity(1.0),
    //                   //       Theme.of(context)
    //                   //           .colorScheme
    //                   //           .surface
    //                   //           .withOpacity(0.5),
    //                   //       Theme.of(context)
    //                   //           .colorScheme
    //                   //           .surface
    //                   //           .withOpacity(0.15),
    //                   //       Theme.of(context)
    //                   //           .colorScheme
    //                   //           .surface
    //                   //           .withOpacity(1.0),
    //                   //     ],
    //                   //     stops: const [
    //                   //       0.01,
    //                   //       0.4,
    //                   //       0.7,
    //                   //     ],
    //                   //   ),
    //                   // ),
    //                 ),
    //                           Column(
    //                             children: [
    //                               SizedBox(height: 215.h,),
    //                               Center(
    //                                 child: Stack(
    //                                   children: [
    //
    //                                     CircleAvatar(
    //                                       backgroundColor: Colors.transparent,
    //                                       radius: 51.r,
    //                                       child: Container(
    //                                         decoration: BoxDecoration(
    //                                           // color: yellow,
    //                                           borderRadius: BorderRadius.circular(100),
    //                                           border: Border.all(
    //                                             color: Colors.white,
    //                                             width: 2.0.h
    //                                           )
    //                                         ),
    //                                       ),
    //                                     ),
    //
    //                                     Padding(
    //                                       padding: EdgeInsets.all(1.8.h),
    //                                       child: CircleAvatar(
    //                                         radius: 49.r,
    //                                         // backgroundColor: greyShade500,
    //                                         backgroundImage: const AssetImage('assets/images/sonysab.jpg'),
    //                                       ),
    //                                     ),
    //
    //                                     Positioned(
    //                                       bottom: 2.h,
    //                                         right: 14.w,
    //                                         child: Container(
    //                                           height: 15.h,
    //                                           width: 18.w,
    //                                           decoration: BoxDecoration(
    //                                             borderRadius: BorderRadius.circular(5),
    //                                             color: greyShade500,
    //                                           ),
    //                                             child: const Icon(HeroiconsOutline.pencilSquare, size: 15,)
    //                                         )
    //                                     )
    //
    //                                     // InkWell(
    //                                     //   borderRadius: BorderRadius.circular(100),
    //                                     //   onTap: (){},
    //                                     //   child: Padding(
    //                                     //       padding: EdgeInsets.all(2.5.h),
    //                                     //     child: CircleAvatar(
    //                                     //       radius: 70.r,
    //                                     //       backgroundColor: Colors.transparent,
    //                                     //       child: Container(
    //                                     //         decoration: BoxDecoration(
    //                                     //           borderRadius: BorderRadius.circular(100),
    //                                     //           color: Colors.black.withOpacity(0.2)
    //                                     //         ),
    //                                     //         child: Center(
    //                                     //           child: Icon(HeroiconsOutline.camera, color: greyShade300,),
    //                                     //         ),
    //                                     //       ),
    //                                     //     ),
    //                                     //   ),
    //                                     // )
    //
    //                                   ],
    //                                 ),
    //                                                   ),
    //                             ],
    //                           ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         actions: [
    //           IconButton(
    //             onPressed: () {
    //               GoRouter.of(context).pushNamed('SearchPage');
    //             },
    //             icon: const Icon(
    //               Remix.search_line,
    //               size: 22,
    //             ),
    //           ),
    //           IconButton(
    //             onPressed: () {
    //               GoRouter.of(context).pushNamed('notificationPage');
    //             },
    //             icon: const Icon(
    //               Remix.notification_3_line,
    //               size: 22,
    //             ),
    //           ),
    //           SizedBox(width: ScreenSize.screenWidth(context) * 0.008),
    //         ],
    //       ),
    //
    //       SliverToBoxAdapter(
    //         child: Padding(
    //           padding: EdgeInsets.only(
    //             left: 15.w,
    //             right: 15.w
    //           ),
    //           child: Column(
    //             children: [
    //                         SizedBox(
    //                           height: 5.h,
    //                         ),
    //
    //                         CustomTextFieldUpload(
    //                           readOnly: false,
    //                             controller: _nameController,
    //                             fieldLabel: 'Name',
    //                         ),
    //                         SizedBox(
    //                           height: 12.h,
    //                         ),
    //
    //                         CustomTextFieldUpload(
    //                             readOnly: true,
    //                           isEnabled: true,
    //                           controller: TextEditingController(
    //                             text: 'Channel URL'
    //                           ),
    //                           fieldLabel: 'Channel URL',
    //                           suffix: InkWell(
    //                             splashColor: greyShade500,
    //                             onTap: (){
    //
    //                             },
    //                             child: Icon(Remix.file_copy_line),
    //                           )
    //                         ),
    //                         SizedBox(
    //                           height: 12.h,
    //                         ),
    //
    //                         CustomTextFieldUpload(
    //                             readOnly: false,
    //                             isEnabled: false,
    //                             controller: _emailController,
    //                             fieldLabel: 'Email'
    //                         ),
    //                         SizedBox(
    //                           height: 10.h,
    //                         ),
    //
    //                         CustomTextFieldUpload(
    //                             readOnly: false,
    //                             isEnabled: false,
    //                             controller: _phoneNumberController,
    //                             fieldLabel: 'Phone number'
    //                         ),
    //                         SizedBox(
    //                           height: 10.h,
    //                         ),
    //               //
    //             ],
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );



    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Update channel',
          style: TextStyle(
            fontFamily: fontFamily,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 20.h,
            left: 15.w,
            right: 15.w
          ),
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [

                    // CircleAvatar(
                    //   backgroundColor: Colors.transparent,
                    //   radius: 72.r,
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       // color: yellow,
                    //       borderRadius: BorderRadius.circular(100),
                    //       border: Border.all(
                    //         color: greyShade500,
                    //         width: 1.0.h
                    //       )
                    //     ),
                    //   ),
                    // ),

                    Padding(
                      padding: EdgeInsets.all(1.8.h),
                      child: CircleAvatar(
                        radius: 70.r,
                        // backgroundColor: blue,
                        backgroundImage: const AssetImage('assets/images/sonysab.jpg'),
                      ),
                    ),

                    Positioned(
                      bottom: 8.h,
                        right: 15.w,
                        child: Container(
                          height: 20.h,
                          width: 25.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: greyShade500,
                          ),
                            child: const Icon(HeroiconsOutline.pencilSquare, size: 20,)
                        )
                    )

                    // InkWell(
                    //   borderRadius: BorderRadius.circular(100),
                    //   onTap: (){},
                    //   child: Padding(
                    //       padding: EdgeInsets.all(2.5.h),
                    //     child: CircleAvatar(
                    //       radius: 70.r,
                    //       backgroundColor: Colors.transparent,
                    //       child: Container(
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(100),
                    //           color: Colors.black.withOpacity(0.2)
                    //         ),
                    //         child: Center(
                    //           child: Icon(HeroiconsOutline.camera, color: greyShade300,),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // )

                  ],
                ),
              ),
              SizedBox(
                height: 25.h,
              ),

              CustomTextFieldUpload(
                readOnly: false,
                  controller: _nameController,
                  fieldLabel: 'Name',
              ),
              SizedBox(
                height: 15.h,
              ),

              CustomTextFieldUpload(
                  readOnly: true,
                isEnabled: true,
                controller: TextEditingController(
                  text: 'Channel URL'
                ),
                fieldLabel: 'Channel URL',
                suffix: InkWell(
                  splashColor: greyShade500,
                  onTap: (){

                  },
                  child: Icon(Remix.file_copy_line),
                )
              ),
              SizedBox(
                height: 15.h,
              ),

              CustomTextFieldUpload(
                  readOnly: false,
                  isEnabled: false,
                  controller: _emailController,
                  fieldLabel: 'Email'
              ),
              SizedBox(
                height: 15.h,
              ),

              CustomTextFieldUpload(
                  readOnly: false,
                  isEnabled: false,
                  controller: _phoneNumberController,
                  fieldLabel: 'Phone number'
              ),
              SizedBox(
                height: 15.h,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
