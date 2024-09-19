import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vimeo_clone/App/MyApp.dart';
import 'package:vimeo_clone/Config/colors.dart';
import 'package:vimeo_clone/bloc/help_and_support/help_and_support_bloc.dart';
import 'package:vimeo_clone/bloc/help_and_support/help_and_support_event.dart';
import 'package:vimeo_clone/bloc/help_and_support/help_and_support_state.dart';
import 'package:vimeo_clone/config/api_routes.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import 'package:vimeo_clone/utils/widgets/custom_text_field_upload.dart';

class HelpAndSupportPage extends StatefulWidget {
  const HelpAndSupportPage({super.key});

  @override
  State<HelpAndSupportPage> createState() => _HelpAndSupportPageState();
}

class _HelpAndSupportPageState extends State<HelpAndSupportPage> {
  final TextEditingController _queryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Help & support',
          style: TextStyle(
            fontFamily: fontFamily
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Text(
                'Need help?',
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 20.sp,
                fontWeight: FontWeight.w400
              ),
            ),
            SizedBox(height: 5.h,),

            Text(
                'We\'re here to help with any questions or issues you may have.',
              style: TextStyle(
                fontFamily: fontFamily,
                color: greyShade500
              ),
            ),
            SizedBox(height: 20.h,),

            Text(
                'Enter your query',
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 18.sp,
                // fontWeight: FontWeight.w400
              ),
            ),

            CustomTextFieldUpload(
              readOnly: false,
                isEnabled: true,
                controller: _queryController,
                fieldLabel: ''
            )
          ],
        ),
      ),
      floatingActionButton: BlocListener<HelpAndSupportBloc, HelpAndSupportState>(
       listener: (BuildContext context, HelpAndSupportState state) {
          if(state is HelpAndSupportSuccess){

          }},
         child: ElevatedButton(
            onPressed: (){
              final userId = int.parse(Global.userData!.userId!);
              final userEmail = Global.userData!.userEmail;
              final helpMessage = _queryController.text;
              context.read<HelpAndSupportBloc>().add(HelpAndSupportRequest(
                  userId: userId,
                  userEmail: userEmail!,
                  helpMessage: helpMessage
              ));

              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                  horizontal: 135.w, vertical: 14.h),
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Submit',
              style: TextStyle(
                  fontFamily: fontFamily,
                fontSize: 15.sp
              ),
            )
        ),
      ),
    );
  }
}
