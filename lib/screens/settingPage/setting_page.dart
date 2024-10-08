import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:remixicon/remixicon.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vimeo_clone/Utils/Widgets/setting_page_btn.dart';
import 'package:vimeo_clone/bloc/auth/auth_event.dart';
import 'package:vimeo_clone/bloc/clear_all_history/clear_all_history_bloc.dart';
import 'package:vimeo_clone/bloc/clear_all_history/clear_all_history_event.dart';
import 'package:vimeo_clone/bloc/get_user_history/get_user_history_event.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_bloc.dart';
import 'package:vimeo_clone/bloc/get_user_playlist/get_user_playlist_event.dart';
import 'package:vimeo_clone/bloc/theme/theme_bloc.dart';
import 'package:vimeo_clone/bloc/theme/theme_event.dart';
import 'package:vimeo_clone/config/global_variable.dart';
import 'package:vimeo_clone/config/internet_connectivity.dart';
import 'package:vimeo_clone/utils/widgets/CustomLogOutWidget.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/change_app_language/change_app_language_bloc.dart';
import '../../bloc/change_app_language/change_app_language_event.dart';
import '../../bloc/get_user_history/get_user_history_bloc.dart';
import '../../config/colors.dart';
import '../../config/constants.dart';
import '../../routes/myapproute.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../utils/widgets/custom_radio_bottom_sheet.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}


class _SettingPageState extends State<SettingPage> {

  final int channelId = int.parse(Global.userData!.userChannelId!);
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  void disposeApi(){
    context.read<GetUserHistoryBloc>().add(GetUserHistoryRequest());
    context.read<GetUserPlaylistBloc>().add(GetUserPlaylistRequest(channelId: channelId));
  }

  @override
  void initState() {
    // TODO: implement initState

    CheckInternet.initConnectivity().then((List<ConnectivityResult> results) {
      if (results.isNotEmpty) {
        setState(() {
          _connectionStatus = results;
        });
      }
    });

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      if (results.isNotEmpty) {
        CheckInternet.updateConnectionStatus(results).then((value) {
          setState(() {
            _connectionStatus = value;
          });
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    disposeApi();
    super.dispose();
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
            title: Text(
              AppLocalizations.of(context)!.appearance,
              style: const TextStyle(
                fontFamily: fontFamily
              ),
            ),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20.w,),
                    RadioListTile<ThemeMode>(
                      visualDensity: const VisualDensity(horizontal: -4),
                      activeColor: Colors.blue,
                      title: Text(
                          AppLocalizations.of(context)!.lightMode,
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
                        AppLocalizations.of(context)!.darkMode,
                        style:
                        const TextStyle(fontSize: 15,
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
                child: Text(
                  AppLocalizations.of(context)!.apply,
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

  String selectedValue = Global.userData!.language ?? 'en';
  final List<Map<String, String>> languageOptions = [
    {'code': 'en', 'name': 'English'},
    {'code': 'hi', 'name': 'Hindi'},
    {'code': 'ar', 'name': 'Arabic'},
    {'code': 'fr', 'name': 'French'},
  ];

  // void languageBottomSheet()async{
  //   customRadioBottomSheet<String>(
  //     bottomSheetTitle: AppLocalizations.of(context)!.chooseLanguage,
  //     context: context,
  //     options: languageOptions.map((lang) => lang['name']!).toList(),
  //     selectedValue: languageOptions.firstWhere((lang) => lang['code'] == selectedValue),
  //     onChanged: (Map<String, String> newValue) {
  //       // Dispatch event to change app language
  //       context.read<ChangeAppLanguageBloc>().add(ChangeAppLanguageRequest(appLanguage: newValue['code']!));
  //
  //       setState(() {
  //         selectedValue = newValue['code']!; // Update the local selected value
  //       });
  //     },
  //   );
  // }


  void languageBottomSheet() async {
    customRadioBottomSheet<String>(
      bottomSheetTitle: AppLocalizations.of(context)!.chooseLanguage,
      context: context,
      options: languageOptions.map((lang) => lang['name']!).toList(), // Only show names
      selectedValue: languageOptions.firstWhere((lang) => lang['code'] == selectedValue)['name']!,
      onChanged: (String newValue) {
        // Find the selected language code based on the name
        final selectedLang = languageOptions.firstWhere((lang) => lang['name'] == newValue);
        context.read<ChangeAppLanguageBloc>().add(ChangeAppLanguageRequest(appLanguage: selectedLang['code']!));
        setState(() {
          selectedValue = selectedLang['code']!;
        });
      },
    );
  }



  // List<Map<String, dynamic>> bottomSheetListTileField(BuildContext context) {
  //   return [
  //     {'name': 'English', 'icon': HeroiconsOutline.bookmark},
  //     {'name': 'Hindi', 'icon': HeroiconsOutline.arrowDownTray},
  //   ];
  // }



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
                  _connectionStatus.contains(connectivityCheck)
                      ? SizedBox.shrink() : CustomSettingButton(
                      icon: HeroiconsOutline.pencilSquare,
                      btnName: AppLocalizations.of(context)!.editMyChannel,
                      onTap: () {
                        GoRouter.of(context).pushNamed('editChannelPage');
                      }
                  ),

                  // WITHDRAWALS
                  _connectionStatus.contains(connectivityCheck)
                      ? SizedBox.shrink() : CustomSettingButton(
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
                  _connectionStatus.contains(connectivityCheck)
                      ? SizedBox.shrink() : CustomSettingButton(
                      icon: Remix.vip_crown_line,
                      btnName: AppLocalizations.of(context)!.yourPlans,
                      onTap: () {
                        GoRouter.of(context).pushNamed('plansPage');
                      }
                  ),

                  // CLEAR WATCHED HISTORY
                  _connectionStatus.contains(connectivityCheck)
                      ? SizedBox.shrink() : CustomSettingButton(
                      icon: HeroiconsOutline.xCircle,
                      btnName: AppLocalizations.of(context)!.clearWatchHistory,
                      onTap: () {
                        clearAllHistory();
                      }
                  ),

                  // LANGUAGE
                  CustomSettingButton(
                      icon: HeroiconsOutline.language,
                      btnName: AppLocalizations.of(context)!.changeLanguage,
                      onTap: () {
                        languageBottomSheet();
                      }
                  ),

                  _connectionStatus.contains(connectivityCheck)
                      ? SizedBox.shrink() : SizedBox(height: 10,),
                  _connectionStatus.contains(connectivityCheck)
                      ? SizedBox.shrink() : Divider(thickness: 0.5, color: Colors.grey,),
                  _connectionStatus.contains(connectivityCheck)
                      ? SizedBox.shrink() : SizedBox(height: 10,),


                  // RATE OUR APP
                  _connectionStatus.contains(connectivityCheck)
                      ? SizedBox.shrink() : CustomSettingButton(
                      icon: HeroiconsOutline.star,
                      btnName: AppLocalizations.of(context)!.rateOurApp,
                      onTap: () {
                        launchAppStoreOrPlayStore('com.pubg.imobile');
                      }
                  ),

                  // INVITE FRIENDS
                  _connectionStatus.contains(connectivityCheck)
                      ? SizedBox.shrink() : CustomSettingButton(
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
                  _connectionStatus.contains(connectivityCheck)
                      ? SizedBox.shrink() : CustomSettingButton(
                      icon: HeroiconsOutline.informationCircle,
                      btnName: AppLocalizations.of(context)!.aboutUs,
                      onTap: () {
                        GoRouter.of(context).pushNamed('aboutUsPage');
                      }
                  ),

                  // TERMS OF USE
                  _connectionStatus.contains(connectivityCheck)
                      ? SizedBox.shrink() : CustomSettingButton(
                      icon: HeroiconsOutline.clipboardDocumentList,
                      btnName: AppLocalizations.of(context)!.termsAndConditions,
                      onTap: () {
                        GoRouter.of(context).pushNamed('termsAndConditionsPage');

                      }
                  ),


                  // HELP
                  _connectionStatus.contains(connectivityCheck)
                      ? SizedBox.shrink() : CustomSettingButton(
                      icon: HeroiconsOutline.questionMarkCircle,
                      btnName: AppLocalizations.of(context)!.helpAndSupport,
                      onTap: () {
                        router.pushNamed('helpAndSupportPage');
                      }
                  ),

                  _connectionStatus.contains(connectivityCheck)
                      ? SizedBox.shrink() : const SizedBox(height: 10,),
                  _connectionStatus.contains(connectivityCheck)
                      ? SizedBox.shrink() : const Divider(thickness: 0.5, color: Colors.grey,),
                  _connectionStatus.contains(connectivityCheck)
                      ? SizedBox.shrink() : const SizedBox(height: 10,),

                  _connectionStatus.contains(connectivityCheck)
                      ? SizedBox.shrink() : CustomLogOutWidget(
                    icon: HeroiconsOutline.trash,
                      btnName: AppLocalizations.of(context)!.deleteAccount,
                      onTap: (){
                        deleteConfirmation();
                      }
                  ),

                  _connectionStatus.contains(connectivityCheck)
                      ? SizedBox.shrink() : CustomLogOutWidget(
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
                    AppLocalizations.of(context)!.youAreGoingToDeleteYourAccount,
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
                          AppLocalizations.of(context)!.noKeepIt,
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
                          // final password = _passwordController.text;
                          context.read<AuthBloc>().add(OnDeleteUserAccountRequestEvent());
                        },
                        child: Text(
                            'Yes, I\'m sure',
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


  void clearAllHistory(){
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
                    'Are you sure? Your history cannot be restored.',
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
                          'No',
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
                          // final password = _passwordController.text;
                          context.read<ClearAllHistoryBloc>().add(ClearAllHistoryRequest());
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Yes, I\'m sure',
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



}











