import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vimeo_clone/Config/colors.dart';
import 'package:vimeo_clone/bloc/help_and_support/help_and_support_bloc.dart';
import 'package:vimeo_clone/bloc/help_and_support/help_and_support_event.dart';
import 'package:vimeo_clone/bloc/help_and_support/help_and_support_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import 'package:vimeo_clone/utils/widgets/custom_text_field_upload.dart';

class HelpAndSupportPage extends StatefulWidget {
  const HelpAndSupportPage({super.key});

  @override
  State<HelpAndSupportPage> createState() => _HelpAndSupportPageState();
}

class _HelpAndSupportPageState extends State<HelpAndSupportPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _queryController = TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String emailRegex = r'^[a-zA-Z0-9._%+-]+@[gmail]+\.[a-zA-Z]{2,}$';

  String? _validateEmail(String? value){
    if(value == null || value.isEmpty){
      ToastManager().showToast(
          context: context,
          message: 'Please enter email'
      );
    }
    RegExp regexp = RegExp(emailRegex);
    if(!regexp.hasMatch(value!)){
      ToastManager().showToast(
          context: context,
          message: 'Email is not valid'
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help & support',
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 18.sp
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w
            ),
            child: Form(
              key: _formKey,
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
                      'Email',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 16.sp,
                      color: Theme.of(context).colorScheme.primaryFixedDim
                      // fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(height: 5.h,),
                  CustomTextFieldUpload(
                    readOnly: false,
                      isEnabled: true,
                      controller: _emailController,
                      validator: _validateEmail,
                      fieldLabel: ''
                  ),
                  SizedBox(height: 20.h,),

                  Text(
                    'Subject',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 16.sp,
                        color: Theme.of(context).colorScheme.primaryFixedDim
                      // fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(height: 5.h,),
                  CustomTextFieldUpload(
                      readOnly: false,
                      isEnabled: true,
                      controller: _subjectController,
                      fieldLabel: ''
                  ),
                  SizedBox(height: 20.h,),

                  Text(
                    'Enter your query',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 16.sp,
                        color: Theme.of(context).colorScheme.primaryFixedDim
                      // fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(height: 5.h,),
                  CustomTextFieldUpload(
                      readOnly: false,
                      isEnabled: true,
                      maxLines: 10,
                      minLines: 5,
                      controller: _queryController,
                      fieldLabel: ''
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: BlocListener<HelpAndSupportBloc, HelpAndSupportState>(
       listener: (BuildContext context, HelpAndSupportState state) {
          if(state is HelpAndSupportSuccess){

          }},
         child: ElevatedButton(
            onPressed: (){
              final userId = int.parse(Global.userData!.userId!);
              final userEmail = _emailController.text;
              final helpMessage = _queryController.text;
              final subject = _subjectController.text;

              if(_formKey.currentState!.validate()){
                context.read<HelpAndSupportBloc>().add(HelpAndSupportRequest(
                    userId: userId,
                    userEmail: userEmail,
                    helpMessage: helpMessage,
                    subject: subject
                ));
              }
              Navigator.pop(context);
            },

            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                  horizontal: 135.w, vertical: 13.h),
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
