import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vimeo_clone/bloc/terms_and_conditions/terms_and_conditions_bloc.dart';
import 'package:vimeo_clone/bloc/terms_and_conditions/terms_and_conditions_state.dart';
import 'package:vimeo_clone/config/constants.dart';

class TermsAndConditionPage extends StatelessWidget {
  const TermsAndConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Terms & conditions',
          style: TextStyle(
            fontFamily: fontFamily,
          ),
        ),
      ),

      body: BlocBuilder<TermsAndConditionsBloc, TermsAndConditionsState>(
        builder: (BuildContext context, TermsAndConditionsState state) {
          if(state is TermsAndConditionsSuccess){
            return Padding(
              padding: EdgeInsets.only(
                  left: 10.w,
                  right: 10.w
              ),
              child: Html(
                shrinkWrap: true,
                data: state.termsAndConditionLink.first.data!.termsAndConditions,
              ),
            );
          }
          return Container();
        },
      ),

    );
  }
}
