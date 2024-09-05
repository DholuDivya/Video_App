import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/bloc/edit_channel/edit_channel_bloc.dart';
import 'package:vimeo_clone/bloc/edit_channel/edit_channel_event.dart';
import 'package:vimeo_clone/bloc/edit_channel/edit_channel_state.dart';
import 'package:vimeo_clone/bloc/get_channel_logo/get_channel_logo_bloc.dart';
import 'package:vimeo_clone/bloc/get_channel_logo/get_channel_logo_event.dart';
import 'package:vimeo_clone/bloc/get_channel_logo/get_channel_logo_state.dart';
import 'package:vimeo_clone/config/colors.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import 'package:vimeo_clone/utils/widgets/custom_text_field_upload.dart';

class EditChannelPage extends StatefulWidget {
  const EditChannelPage({super.key});

  @override
  State<EditChannelPage> createState() => _EditChannelPageState();
}

class _EditChannelPageState extends State<EditChannelPage> {

  late TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  late bool isEdit = false;
  CroppedFile? finalChannelLogo;

  @override
  void initState() {
    if(isEdit == false){
      _nameController = TextEditingController(text: Global.userData!.userName);
    }else{
      _nameController = TextEditingController();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print('IIIIIIIIIIIIIiiii  :::  ${Global.userData!.userNumber}');
    if(isEdit == false){
      _nameController = TextEditingController(text: Global.userData!.userName);
    }

    String channelLogo = Global.userData!.userProfilePhoto!;

    return Scaffold(
      appBar: AppBar(
        leading: isEdit == true ? IconButton(
            onPressed: (){
              setState(() {
                isEdit = false;
              });
            },
            icon: const Icon(HeroiconsOutline.xMark)
        ) : IconButton(
            onPressed: (){
              GoRouter.of(context).pop();
            },
            icon: const Icon(HeroiconsOutline.chevronLeft)
        ),
        title: const Text(
            'Update channel',
          style: TextStyle(
            fontFamily: fontFamily,
          ),
        ),
        actions: [
          isEdit == false ? IconButton(
              onPressed: (){
                setState(() {
                  isEdit = true;
                });
              },
              icon: const Icon(HeroiconsOutline.pencilSquare)
          ) : Container()
        ],
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
            BlocBuilder<GetChannelLogoBloc, GetChannelLogoState>(
              builder: (BuildContext context, GetChannelLogoState state) {
                if(state is GetChannelLogoLoaded){
                  finalChannelLogo = state.channelLogo;
                  channelLogo = finalChannelLogo!.path;
                  return Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(1.8.h),
                        child: CircleAvatar(
                          radius: 70.r,
                          backgroundImage: channelLogo.startsWith('http')
                              ? NetworkImage(channelLogo)  // Load from network if it's a valid URL
                              : FileImage(File(channelLogo)),
                        ),
                      ),
                      if (isEdit)
                        Positioned(
                          bottom: 8.h,
                          right: 15.w,
                          child: GestureDetector(
                            onTap: () {
                              context.read<GetChannelLogoBloc>().add(OpenFilesToGetChannelLogo());
                            },
                            child: Container(
                              height: 20.h,
                              width: 25.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              child: const Icon(HeroiconsOutline.photo, size: 18),
                            ),
                          ),
                        ),
                    ],
                  );
                }
                return Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(1.8.h),
                      child: CircleAvatar(
                        radius: 70.r,
                        backgroundImage: NetworkImage(channelLogo),
                      ),
                    ),
                    if (isEdit)
                      Positioned(
                        bottom: 8.h,
                        right: 15.w,
                        child: GestureDetector(
                          onTap: () {
                            context.read<GetChannelLogoBloc>().add(OpenFilesToGetChannelLogo());
                          },
                          child: Container(
                            height: 20.h,
                            width: 25.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            child: const Icon(HeroiconsOutline.photo, size: 20),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),

            SizedBox(
                height: 25.h,
              ),

              CustomTextFieldUpload(
                readOnly: isEdit == false ? true : false,
                  isEnabled: isEdit == false ? false : true,
                  controller: _nameController,
                  fieldLabel: 'Name',
                onChange: (value){
                  print('909090090909090909    $value');
                },
              ),
              SizedBox(
                height: 15.h,
              ),

              CustomTextFieldUpload(
                  readOnly: true,
                isEnabled: false,
                controller: TextEditingController(
                  text: 'Channel URL'
                ),
                fieldLabel: 'Channel URL',
                suffix: InkWell(
                  splashColor: greyShade500,
                  onTap: (){

                  },
                  child: const Icon(Remix.file_copy_line),
                )
              ),
              SizedBox(
                height: 15.h,
              ),

              CustomTextFieldUpload(
                  readOnly: false,
                  isEnabled: false,
                  controller: TextEditingController(
                      text: Global.userData!.userEmail
                  ),
                  fieldLabel: 'Email'
              ),
              SizedBox(
                height: 15.h,
              ),

              CustomTextFieldUpload(
                  readOnly: false,
                  isEnabled: false,
                  controller: TextEditingController(
                      text: Global.userData!.userNumber
                  ),
                  fieldLabel: 'Phone number'
              ),
              SizedBox(
                height: 15.h,
              ),



            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isEdit == true ? BlocBuilder<EditChannelBloc, EditChannelState>(
        builder: (BuildContext context, EditChannelState state) {
          if(state is EditChannelSuccess){
            if(Navigator.canPop(context)){
              Navigator.pop(context);
            }
            ToastManager().showToast(
                context: context,
                message: 'Channel details is successfully updated!'
            );
          }
          return ElevatedButton(
              onPressed: (){
                String channelName = '';
                var logo;
                print('!!!!!!!!!!!!!!!!!!!     :::::   ${_nameController.text}');
                Global.userData!.userName == _nameController.text
                    ? null : channelName = _nameController.text;
                final channelLogo = finalChannelLogo;
                // final channelBanner = null;

                print('popopopoopoppopopop    $channelName');
                context.read<EditChannelBloc>().add(EditChannelRequest(
                  channelName: channelName.isEmpty ? null : channelName,
                  channelLogo: channelLogo,

                ));

              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: 135.w, vertical: 10.h),
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Update',
                style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 18
                ),
              )
          );
        },
      ) : Container(),
    );
  }
}
