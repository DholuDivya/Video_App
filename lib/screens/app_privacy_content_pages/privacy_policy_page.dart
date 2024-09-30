import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vimeo_clone/bloc/privacy_policy/privacy_policy_bloc.dart';
import 'package:vimeo_clone/bloc/privacy_policy/privacy_policy_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.privacyPolicy,
          style: TextStyle(
            fontFamily: fontFamily,
          ),
        ),
      ),

      body: BlocBuilder<PrivacyPolicyBloc, PrivacyPolicyState>(
        builder: (BuildContext context, PrivacyPolicyState state) {
          if(state is PrivacyPolicySuccess){
            return Padding(
              padding: EdgeInsets.only(
                  left: 10.w,
                  right: 10.w
              ),
              child: Html(
                shrinkWrap: true,
                data: state.privacyPolicyLink.first.data!.privacy,
              ),
            );
          }
          return Container();
        },
      ),

    );
  }
}