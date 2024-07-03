import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/Utils/Widgets/setting_page_btn.dart';
import 'package:vimeo_clone/bloc/theme/theme_bloc.dart';
import 'package:vimeo_clone/bloc/theme/theme_event.dart';
import 'package:vimeo_clone/config/colors.dart';

import '../../config/constants.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

enum AppearanceTheme { lightAppearance, darkAppearance, systemAppearance }

class _SettingPageState extends State<SettingPage> {

  AppearanceTheme? _selectedAppearance = AppearanceTheme.lightAppearance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setSelectedAppearance();
  }

  void _setSelectedAppearance() {
    final themeBlocState = context.read<ThemeBloc>().state;
    _selectedAppearance = themeBlocState == ThemeMode.dark
        ? AppearanceTheme.darkAppearance
        : (themeBlocState == ThemeMode.light
        ? AppearanceTheme.lightAppearance
        : AppearanceTheme.systemAppearance
    );
  }

  void _showAppearanceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Appearance'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    ListTile(
                      title: Text('Light Mode'),
                      leading: Radio<AppearanceTheme>(
                        activeColor: primaryColor,
                        value: AppearanceTheme.lightAppearance,
                        groupValue: _selectedAppearance,
                        onChanged: (AppearanceTheme? value) {
                          setState(() {
                            _selectedAppearance = value;
                          });
                          // Update the state of the parent widget

                        },
                      ),
                    ),
                    ListTile(
                      title: Text('Dark Mode'),
                      leading: Radio<AppearanceTheme>(
                        activeColor: primaryColor,
                        value: AppearanceTheme.darkAppearance,
                        groupValue: _selectedAppearance,
                        onChanged: (AppearanceTheme? value) {
                          setState(() {
                            _selectedAppearance = value;
                          });

                        },
                      ),
                    ),
                    ListTile(
                      title: Text('System Mode'),
                      leading: Radio<AppearanceTheme>(
                        activeColor: primaryColor,
                        value: AppearanceTheme.systemAppearance,
                        groupValue: _selectedAppearance,
                        onChanged: (AppearanceTheme? value) {
                          setState(() {
                            _selectedAppearance = value;
                          });

                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Done',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: fontFamily
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style:  TextStyle(fontFamily: fontFamily),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            // EDIT MY CHANNEL
            CustomSettingButton(
              icon: HeroiconsOutline.pencilSquare,
                btnName: ('Edit My Channel'),
                onTap: (){}
            ),

            // WITHDRAWALS
            CustomSettingButton(
              icon: HeroiconsOutline.buildingLibrary,
                btnName: ('Withdrawals'),
                onTap: (){}
            ),

            // GO PRO
            CustomSettingButton(
              icon: Remix.star_fill,
                btnName: ('Go Pro'),
                onTap: (){}
            ),

            // AUTOPLAY
            CustomSettingButton(
              icon: HeroiconsOutline.checkBadge,
                btnName: ('Verification'),
                onTap: (){}
            ),

            // POINTS
            CustomSettingButton(
              icon: Remix.sticky_note_line,
                btnName: ('Points'),
                onTap: (){}
            ),

            // BLOCKED USERS
            CustomSettingButton(
              icon: HeroiconsOutline.noSymbol,
                btnName: ('Blocked Users'),
                onTap: (){}
            ),

            // WALLETS
            CustomSettingButton(
              icon: HeroiconsOutline.wallet,
                btnName: ('Wallet'),
                onTap: (){}
            ),



            SizedBox(height: 10,),
            Divider(thickness: 0.5, color: Colors.grey,),
            SizedBox(height: 10,),


            // PASSWORD
            CustomSettingButton(
              icon: HeroiconsOutline.lockClosed,
                btnName: ('Password'),
                onTap: (){}
            ),

            // TWO-FACTOR AUTHENTICATION
            CustomSettingButton(
              icon: HeroiconsOutline.key,
                btnName: ('Two-factor authentication'),
                onTap: (){}
            ),

            // MANAGE SESSIONS
            CustomSettingButton(
              icon: HeroiconsOutline.tv,
                btnName: ('Manage Sessions'),
                onTap: (){}
            ),


            SizedBox(height: 10,),
            Divider(thickness: 0.5, color: Colors.grey,),
            SizedBox(height: 10,),



            // THEME
            CustomSettingButton(
              icon: Remix.palette_line,
                btnName: ('Theme'),
                onTap: _showAppearanceDialog
            ),

            // PICTURE IN PICTURE
            CustomSettingButton(
              icon: Remix.picture_in_picture_2_line,
                btnName: ('Picture in picture'),
                onTap: (){}
            ),


            SizedBox(height: 10,),
            Divider(thickness: 0.5, color: Colors.grey,),
            SizedBox(height: 10,),


            // CLEAR WATCHED HISTORY
            CustomSettingButton(
              icon: HeroiconsOutline.xCircle,
                btnName: ('Clear watched history'),
                onTap: (){}
            ),

            // PAUSE WATCH HISTORY
            CustomSettingButton(
              icon: HeroiconsOutline.pauseCircle,
                btnName: ('Pause watch history'),
                onTap: (){}
            ),

            // CLEAR CACHE
            CustomSettingButton(
              icon: Remix.brush_2_line,
                btnName: ('Clear cache'),
                onTap: (){}
            ),


            SizedBox(height: 10,),
            Divider(thickness: 0.5, color: Colors.grey,),
            SizedBox(height: 10,),



            // RATE OUR APP
            CustomSettingButton(
              icon: HeroiconsOutline.star,
                btnName: ('Rate our app'),
                onTap: (){}
            ),

            // INVITE FRIENDS
            CustomSettingButton(
              icon: HeroiconsOutline.userPlus,
                btnName: ('Invite friends'),
                onTap: (){}
            ),

            // ABOUT US
            CustomSettingButton(
              icon: HeroiconsOutline.informationCircle,
                btnName: ('About us'),
                onTap: (){}
            ),

            // TERMS OF USE
            CustomSettingButton(
              icon: HeroiconsOutline.clipboardDocumentList,
                btnName: ('Terms of use '),
                onTap: (){}
            ),


            // HELP
            CustomSettingButton(
              icon: HeroiconsOutline.questionMarkCircle,
                btnName: ('Help'),
                onTap: (){}
            ),

          ],
        ),
      ),
    );
  }
}
