import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vimeo_clone/bloc/about_us/about_us_bloc.dart';
import 'package:vimeo_clone/bloc/about_us/about_us_state.dart';
import 'package:vimeo_clone/config/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.aboutUs,
          style: TextStyle(
            fontFamily: fontFamily,
          ),
        ),
      ),

      body: BlocBuilder<AboutUsBloc, AboutUsState>(
        builder: (BuildContext context, AboutUsState state) {
          if(state is AboutUsSuccess){
            return Padding(
              padding: EdgeInsets.only(
                left: 10.w,
                right: 10.w
              ),
              child: Html(
                shrinkWrap: true,
                data: state.aboutUsLink.first.data!.aboutUs,
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}