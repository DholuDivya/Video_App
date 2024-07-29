import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:remixicon/remixicon.dart';
import 'package:vimeo_clone/Utils/Widgets/setting_page_btn.dart';
import 'package:vimeo_clone/bloc/auth/auth_event.dart';
import 'package:vimeo_clone/bloc/theme/theme_bloc.dart';
import 'package:vimeo_clone/bloc/theme/theme_event.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import 'package:vimeo_clone/utils/widgets/CustomLogOutWidget.dart';


import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../config/constants.dart';
import '../../config/security.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}


class _SettingPageState extends State<SettingPage> {


  void showThemeDialog(BuildContext context) {
    ThemeMode? _selectedTheme = context.read<ThemeBloc>().state;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // backgroundColor: Theme.of(context).colorScheme.surface,
            contentPadding: EdgeInsets.only(
                // left: ScreenSize.screenWidth(context) * 0.04,
                // right: ScreenSize.screenWidth(context) * 0.04
            ),
            actionsPadding: EdgeInsets.only(
                right: ScreenSize.screenWidth(context) * 0.03,
                bottom: ScreenSize.screenHeight(context) * 0.01),
            title: Text("Appearance"),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20.w,),
                    RadioListTile<ThemeMode>(
                      visualDensity: const VisualDensity(horizontal: -4),
                      activeColor: Colors.blue,
                      title: const Text('Light Mode',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: fontFamily
                          )
                      ),
                      value: ThemeMode.light,
                      groupValue: _selectedTheme,
                      onChanged: (ThemeMode? value) {
                        setState(() {
                          _selectedTheme = value;
                        });
                      },
                    ),
                    RadioListTile<ThemeMode>(
                      visualDensity: const VisualDensity(horizontal: -4),
                      activeColor: Colors.blue,
                      title: Text(
                        'Dark Mode',
                        style:
                        TextStyle(fontSize: 15,
                            fontFamily: fontFamily
                        ),
                      ),
                      value: ThemeMode.dark,
                      groupValue: _selectedTheme,
                      onChanged: (ThemeMode? value) {
                        setState(() {
                          _selectedTheme = value;
                        });
                      },
                    ),
                    RadioListTile<ThemeMode>(
                      visualDensity: const VisualDensity(horizontal: -4),
                      activeColor: Colors.blue,
                      title: const Text('System Mode',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: fontFamily
                          )
                      ),
                      value: ThemeMode.system,
                      groupValue: _selectedTheme,
                      onChanged: (ThemeMode? value) {
                        setState(() {
                          _selectedTheme = value;
                        });
                      },
                    ),
                  ],
                );
              },
            ),
            actions: [
              // TextButton(
              //   child: const Text('Cancel',
              //       style: TextStyle(
              //           color: Colors.blue,
              //           fontSize: 16,
              //           fontFamily: "Poppins-Bold")),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
              TextButton(
                child: const Text(
                  'Apply',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontFamily: fontFamily
                  ),
                ),
                onPressed: () {
                  if (_selectedTheme != null) {
                    context.read<ThemeBloc>().add(
                        ThemeChanged(_selectedTheme!));
                  }
                  GoRouter.of(context).pop();
                },
              ),
            ],
          );
        });
  }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Settings', style: TextStyle(fontFamily: fontFamily),),
        ),
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if(state is AuthLogOut){
              // print('Logged Out ---- ${headers} \n Token${Global.userName}');
              print('Logged Out ---- ${headers} \n Token${Global.token}');
              GoRouter.of(context).pushReplacementNamed('signupPage');
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [

                  // EDIT MY CHANNEL
                  CustomSettingButton(
                      icon: HeroiconsOutline.pencilSquare,
                      btnName: ('Edit My Channel'),
                      onTap: () {}
                  ),

                  // WITHDRAWALS
                  CustomSettingButton(
                      icon: HeroiconsOutline.buildingLibrary,
                      btnName: ('Withdrawals'),
                      onTap: () {}
                  ),

                  // GO PRO
                  CustomSettingButton(
                      icon: Remix.star_fill,
                      btnName: ('Go Pro'),
                      onTap: () {}
                  ),

                  // AUTOPLAY
                  CustomSettingButton(
                      icon: HeroiconsOutline.checkBadge,
                      btnName: ('Verification'),
                      onTap: () {}
                  ),

                  // POINTS
                  CustomSettingButton(
                      icon: Remix.sticky_note_line,
                      btnName: ('Points'),
                      onTap: () {}
                  ),

                  // BLOCKED USERS
                  CustomSettingButton(
                      icon: HeroiconsOutline.noSymbol,
                      btnName: ('Blocked Users'),
                      onTap: () {}
                  ),

                  // WALLETS
                  CustomSettingButton(
                      icon: HeroiconsOutline.wallet,
                      btnName: ('Wallet'),
                      onTap: () {}
                  ),


                  SizedBox(height: 10,),
                  Divider(thickness: 0.5, color: Colors.grey,),
                  SizedBox(height: 10,),


                  // PASSWORD
                  CustomSettingButton(
                      icon: HeroiconsOutline.lockClosed,
                      btnName: ('Password'),
                      onTap: () {}
                  ),

                  // TWO-FACTOR AUTHENTICATION
                  CustomSettingButton(
                      icon: HeroiconsOutline.key,
                      btnName: ('Two-factor authentication'),
                      onTap: () {}
                  ),

                  // MANAGE SESSIONS
                  CustomSettingButton(
                      icon: HeroiconsOutline.tv,
                      btnName: ('Manage Sessions'),
                      onTap: () {}
                  ),


                  SizedBox(height: 10,),
                  Divider(thickness: 0.5, color: Colors.grey,),
                  SizedBox(height: 10,),


                  // THEME
                  CustomSettingButton(
                      icon: Remix.palette_line,
                      btnName: ('Theme'),
                      onTap: () {
                        showThemeDialog(context);
                      }
                  ),

                  // PICTURE IN PICTURE
                  CustomSettingButton(
                      icon: Remix.picture_in_picture_2_line,
                      btnName: ('Picture in picture'),
                      onTap: () {}
                  ),


                  SizedBox(height: 10,),
                  Divider(thickness: 0.5, color: Colors.grey,),
                  SizedBox(height: 10,),


                  // CLEAR WATCHED HISTORY
                  CustomSettingButton(
                      icon: HeroiconsOutline.xCircle,
                      btnName: ('Clear watched history'),
                      onTap: () {}
                  ),

                  // PAUSE WATCH HISTORY
                  CustomSettingButton(
                      icon: HeroiconsOutline.pauseCircle,
                      btnName: ('Pause watch history'),
                      onTap: () {}
                  ),

                  // CLEAR CACHE
                  CustomSettingButton(
                      icon: Remix.brush_2_line,
                      btnName: ('Clear cache'),
                      onTap: () {}
                  ),


                  SizedBox(height: 10,),
                  Divider(thickness: 0.5, color: Colors.grey,),
                  SizedBox(height: 10,),


                  // RATE OUR APP
                  CustomSettingButton(
                      icon: HeroiconsOutline.star,
                      btnName: ('Rate our app'),
                      onTap: () {}
                  ),

                  // INVITE FRIENDS
                  CustomSettingButton(
                      icon: HeroiconsOutline.userPlus,
                      btnName: ('Invite friends'),
                      onTap: () {}
                  ),

                  // ABOUT US
                  CustomSettingButton(
                      icon: HeroiconsOutline.informationCircle,
                      btnName: ('About us'),
                      onTap: () {}
                  ),

                  // TERMS OF USE
                  CustomSettingButton(
                      icon: HeroiconsOutline.clipboardDocumentList,
                      btnName: ('Terms of use '),
                      onTap: () {}
                  ),


                  // HELP
                  CustomSettingButton(
                      icon: HeroiconsOutline.questionMarkCircle,
                      btnName: ('Help'),
                      onTap: () {
                        GoRouter.of(context).pushReplacementNamed('signupPage');
                      }
                  ),

                  SizedBox(height: 10,),
                  Divider(thickness: 0.5, color: Colors.grey,),
                  SizedBox(height: 10,),

                  CustomLogOutWidget(
                      btnName: 'Delete account',
                      onTap: (){
                        // GoRouter.of(context).pushReplacementNamed('');
                      }
                  ),

                  CustomLogOutWidget(
                      btnName: 'Log Out',
                      onTap: () {
                        print('log out');
                        context.read<AuthBloc>().add(OnLogOutRequestEvent());
                      }
                  ),




                ],
              ),
            );
          },
        )


      );
    }
}











