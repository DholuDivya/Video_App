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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditChannelPage extends StatefulWidget {
  const EditChannelPage({super.key});

  @override
  State<EditChannelPage> createState() => _EditChannelPageState();
}

class _EditChannelPageState extends State<EditChannelPage> {

  late TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  String channelLogo = '';
  // late bool isEdit = false;
  CroppedFile? finalChannelLogo;

  @override
  void initState() {
    // if(isEdit == false){
    //   _nameController = TextEditingController(text: Global.userData!.userName);
    // }else{
    //   _nameController = TextEditingController();
    // }
    _nameController = TextEditingController(
      text: Global.userData!.userName
    );
    channelLogo = Global.userData!.userProfilePhoto!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print('IIIIIIIIIIIIIiiii  :::  ${Global.userData!.userNumber}');
    // if(isEdit == false){
    //   _nameController = TextEditingController(text: Global.userData!.userName);
    // }



    return Scaffold(
      appBar: AppBar(
        title: Text(
            AppLocalizations.of(context)!.updateChannel,
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
                readOnly: false,
                  isEnabled: true,
                  controller: _nameController,
                  fieldLabel: AppLocalizations.of(context)!.name,
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
                fieldLabel: AppLocalizations.of(context)!.channelUrl,
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
                  fieldLabel: AppLocalizations.of(context)!.email
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
                  fieldLabel: AppLocalizations.of(context)!.phoneNumber
              ),
              SizedBox(
                height: 15.h,
              ),



            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<EditChannelBloc, EditChannelState>(
        builder: (BuildContext context, EditChannelState state) {
          if(state is EditChannelSuccess){
            WidgetsBinding.instance.addPostFrameCallback((_){
              GoRouter.of(context).pushReplacementNamed('homePage');
            });
            ToastManager().showToast(
                context: context,
                message: AppLocalizations.of(context)!.channelDetailsIsSuccessfullyUpdated
            );
          }
          return ElevatedButton(
              onPressed: (){
                String channelName = '';
                var logo;
                print('!!!!!!!!!!!!!!!!!!!     :::::   ${_nameController.text}');
                Global.userData!.userName == _nameController.text
                    ? null : channelName = _nameController.text;
                CroppedFile? channelLogo;
                if (finalChannelLogo is CroppedFile && finalChannelLogo!.path.isNotEmpty) {
                  channelLogo = finalChannelLogo;
                } else {
                  channelLogo = null; // or provide a default CroppedFile if applicable
                }


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
              child: Text(
                AppLocalizations.of(context)!.update,
                style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 18
                ),
              )
          );
        },
      ),
    );
  }
}
