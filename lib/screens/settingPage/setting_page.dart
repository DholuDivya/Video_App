import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:remixicon/remixicon.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vimeo_clone/Utils/Widgets/setting_page_btn.dart';
import 'package:vimeo_clone/bloc/auth/auth_event.dart';
import 'package:vimeo_clone/bloc/theme/theme_bloc.dart';
import 'package:vimeo_clone/bloc/theme/theme_event.dart';
import 'package:vimeo_clone/utils/widgets/CustomLogOutWidget.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../config/colors.dart';
import '../../config/constants.dart';
import '../../routes/myapproute.dart';
import '../../utils/widgets/custom_text_field_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}


class _SettingPageState extends State<SettingPage> {
  TextEditingController _passwordController = TextEditingController();
  bool isPasswordVisible = false;
  String pattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';


  String? _validatePassword(String? value){
    if(value == null || value.isEmpty){
      return "Please enter First Name !";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    RegExp regexp = RegExp(pattern);
    if(!regexp.hasMatch(value)){
      return 'Password must be at least 8 characters long, include an uppercase letter, number, and symbol';
    }
    return null;
  }


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
                          print('iiiiiiiiiiiii     ${_selectedTheme.runtimeType}');
                          _selectedTheme = value;
                        });
                      },
                    ),
                    // RadioListTile<ThemeMode>(
                    //   visualDensity: const VisualDensity(horizontal: -4),
                    //   activeColor: Colors.blue,
                    //   title: const Text('System Mode',
                    //       style: TextStyle(
                    //           fontSize: 15,
                    //           fontFamily: fontFamily
                    //       )
                    //   ),
                    //   value: ThemeMode.system,
                    //   groupValue: _selectedTheme,
                    //   onChanged: (ThemeMode? value) {
                    //     setState(() {
                    //       _selectedTheme = value;
                    //     });
                    //   },
                    // ),
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
          title: Text(AppLocalizations.of(context)!.settings, style: const TextStyle(fontFamily: fontFamily),),
        ),
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if(state is AuthLogOut){
              // print('Logged Out ---- ${headers} \n Token${Global.userName}');
              print('Log Out API Successfully Called');
              GoRouter.of(context).pushReplacementNamed('signupPage');
            }
            else if(state is AuthDeleteUserAccount){
              print('Delete Account API Successfully Called');
              if(Navigator.canPop(context)){
                Navigator.pop(context);
              }
              GoRouter.of(context).pushReplacementNamed('signupPage');
            }
            else if(state is AuthProgress){
              const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [

                  // EDIT MY CHANNEL
                  CustomSettingButton(
                      icon: HeroiconsOutline.pencilSquare,
                      btnName: AppLocalizations.of(context)!.editMyChannel,
                      onTap: () {
                        GoRouter.of(context).pushNamed('editChannelPage');
                      }
                  ),

                  // WITHDRAWALS
                  CustomSettingButton(
                      icon: HeroiconsOutline.buildingLibrary,
                      btnName: AppLocalizations.of(context)!.transactions,
                      onTap: () {
                        GoRouter.of(context).pushNamed('transactionsPage');
                      }
                  ),

                  // THEME
                  CustomSettingButton(
                      icon: Remix.palette_line,
                      btnName: AppLocalizations.of(context)!.theme,
                      onTap: () {
                        showThemeDialog(context);
                      }
                  ),

                  // PICTURE IN PICTURE
                  CustomSettingButton(
                      icon: Remix.vip_crown_line,
                      btnName: AppLocalizations.of(context)!.yourPlans,
                      onTap: () {
                        GoRouter.of(context).pushNamed('plansPage');
                      }
                  ),

                  // CLEAR WATCHED HISTORY
                  CustomSettingButton(
                      icon: HeroiconsOutline.xCircle,
                      btnName: AppLocalizations.of(context)!.clearWatchHistory,
                      onTap: () {}
                  ),

                  SizedBox(height: 10,),
                  Divider(thickness: 0.5, color: Colors.grey,),
                  SizedBox(height: 10,),


                  // RATE OUR APP
                  CustomSettingButton(
                      icon: HeroiconsOutline.star,
                      btnName: AppLocalizations.of(context)!.rateOurApp,
                      onTap: () {
                        launchAppStoreOrPlayStore('com.pubg.imobile');
                      }
                  ),

                  // INVITE FRIENDS
                  CustomSettingButton(
                      icon: HeroiconsOutline.userPlus,
                      btnName: AppLocalizations.of(context)!.inviteFriends,
                      onTap: () async {
                        try {
                          const String packageName = 'com.naturalmotion.customstreetracer2';
                          String url;
                          if (Platform.isAndroid) {
                            // Redirect to Google Play Store
                            url = 'https://play.google.com/store/apps/details?id=$packageName';
                          } else if (Platform.isIOS) {
                            // Redirect to Apple App Store
                            url = 'https://apps.apple.com/app/id$packageName';
                          } else {
                            throw Exception('Unsupported platform');
                          }
                          Share.share('Check out this amazing app: $url');
                        } catch (e) {
                          print('Error launching store or sharing: $e');
                        }
                      }
                  ),

                  // ABOUT US
                  CustomSettingButton(
                      icon: HeroiconsOutline.informationCircle,
                      btnName: AppLocalizations.of(context)!.aboutUs,
                      onTap: () {
                        GoRouter.of(context).pushNamed('aboutUsPage');
                      }
                  ),

                  // TERMS OF USE
                  CustomSettingButton(
                      icon: HeroiconsOutline.clipboardDocumentList,
                      btnName: AppLocalizations.of(context)!.termsAndConditions,
                      onTap: () {
                        GoRouter.of(context).pushNamed('termsAndConditionsPage');

                      }
                  ),


                  // HELP
                  CustomSettingButton(
                      icon: HeroiconsOutline.questionMarkCircle,
                      btnName: AppLocalizations.of(context)!.helpAndSupport,
                      onTap: () {
                        router.pushNamed('helpAndSupportPage');
                      }
                  ),

                  const SizedBox(height: 10,),
                  const Divider(thickness: 0.5, color: Colors.grey,),
                  const SizedBox(height: 10,),

                  CustomLogOutWidget(
                    icon: HeroiconsOutline.trash,
                      btnName: AppLocalizations.of(context)!.deleteAccount,
                      onTap: (){
                        deleteConfirmation();
                      }
                  ),

                  CustomLogOutWidget(
                    icon: HeroiconsOutline.arrowLeftOnRectangle,
                      btnName: AppLocalizations.of(context)!.logOut,
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


    void deleteConfirmation(){
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Center(
              child: CircleAvatar(
                backgroundColor: Colors.red.shade100,
                child: Icon(HeroiconsSolid.exclamationTriangle,
                  color: red,
                ),
              ),
            ),

            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10.h,),
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    'You\'re going to delete your account. Are you sure?',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 16.sp
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(

                        style: ButtonStyle(
                          padding: WidgetStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 10.w)
                          ),
                            backgroundColor: WidgetStatePropertyAll(greyShade300)
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text(
                          'No, Keep it',
                          style: TextStyle(
                              fontFamily: fontFamily,
                              color: greyShade900,
                            fontSize: 12.sp
                          ),
                        )
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          padding: WidgetStatePropertyAll(
                              EdgeInsets.symmetric(horizontal: 10.w)
                          ),
                        backgroundColor: WidgetStatePropertyAll(red)
                      ),
                        onPressed: (){
                          final password = _passwordController.text;
                          context.read<AuthBloc>().add(OnDeleteUserAccountRequestEvent(
                              password: password
                          ));
                        },
                        child: Text(
                            'Yes, Delete it!',
                          style: TextStyle(
                            fontFamily: fontFamily,
                            color: Colors.white,
                              fontSize: 12.sp
                          ),
                        )
                    ),
                  ],
                )
              ],
            ),
          );
        }
      );
    }


    void onDeleteAccountShowDialog(){
      showDialog(
          context: context,
          builder: (context){
            return StatefulBuilder(
              builder: (BuildContext context, void Function(void Function()) setState) {
                return AlertDialog(
                  title: const Center(
                    child: Text(
                        'Enter your password',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 15
                      ),
                    ),
                  ),
                    content: Container(
                      height: 110.h,
                      child: Column(
                        children: [
                          SizedBox(height: 10.h,),
                          CustomTextField(
                            obscureText: true && !isPasswordVisible,
                            controller: _passwordController,
                            validator: _validatePassword,
                            label: 'Password',
                            suffixIcon: IconButton(
                                onPressed: (){
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                                icon: Icon(
                                    isPasswordVisible ? HeroiconsOutline.eye : HeroiconsOutline.eyeSlash
                                )
                            ),
                          ),
                          SizedBox(height: 15.h,),
                          Container(
                            height: 30.h,
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: (){
                                  deleteConfirmation();
                                },
                                child: Text(
                                    'Submit',
                                  style: TextStyle(
                                    fontFamily: fontFamily
                                  ),
                                )
                            ),
                          )
                        ],
                      ),
                    )
                );
              },
            );
          }
      );
    }
}











