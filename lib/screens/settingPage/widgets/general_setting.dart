// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vimeo_clone/config/colors.dart';
// import 'package:vimeo_clone/Utils/Widgets/toggle_button.dart';
// import 'package:vimeo_clone/bloc/theme/theme_bloc.dart';
// import 'package:vimeo_clone/bloc/theme/theme_event.dart';
//
// import '../../../config/constants.dart';
//
// class GeneralSettings extends StatefulWidget {
//   const GeneralSettings({super.key});
//
//   @override
//   State<GeneralSettings> createState() => _GeneralSettingsState();
// }
//
// enum AppearanceTheme { lightAppearance, darkAppearance, systemAppearance }
//
// class _GeneralSettingsState extends State<GeneralSettings> {
//   bool _isRemindMeToTakeBreak = false;
//   bool _isRemindBedTime = false;
//   AppearanceTheme? _selectedAppearance = AppearanceTheme.lightAppearance;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _setSelectedAppearance();
//   }
//
//   void _setSelectedAppearance() {
//     final themeBlocState = context.read<ThemeBloc>().state;
//     _selectedAppearance = themeBlocState == ThemeMode.dark
//         ? AppearanceTheme.darkAppearance
//         : (themeBlocState == ThemeMode.light
//         ? AppearanceTheme.lightAppearance
//         : AppearanceTheme.systemAppearance
//     );
//   }
//
//   void _showAppearanceDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               title: Text('Appearance'),
//               content: SingleChildScrollView(
//                 child: ListBody(
//                   children: [
//                     ListTile(
//                       title: Text('Light Mode'),
//                       leading: Radio<AppearanceTheme>(
//                         activeColor: primaryColor,
//                         value: AppearanceTheme.lightAppearance,
//                         groupValue: _selectedAppearance,
//                         onChanged: (AppearanceTheme? value) {
//                           setState(() {
//                             _selectedAppearance = value;
//                           });
//                           // Update the state of the parent widget
//                           this.setState(() {
//                             if (value == AppearanceTheme.lightAppearance) {
//                               context.read<ThemeBloc>().add(ThemeChangeEvent(isDark: false));
//                             } else if (value == AppearanceTheme.darkAppearance) {
//                               context.read<ThemeBloc>().add(ThemeChangeEvent(isDark: true));
//                             } else {
//                               // Handle system appearance if needed
//                             }
//                           });
//                         },
//                       ),
//                     ),
//                     ListTile(
//                       title: Text('Dark Mode'),
//                       leading: Radio<AppearanceTheme>(
//                         activeColor: primaryColor,
//                         value: AppearanceTheme.darkAppearance,
//                         groupValue: _selectedAppearance,
//                         onChanged: (AppearanceTheme? value) {
//                           setState(() {
//                             _selectedAppearance = value;
//                           });
//                           // Update the state of the parent widget
//                           this.setState(() {
//                             if (value == AppearanceTheme.lightAppearance) {
//                               context.read<ThemeBloc>().add(ThemeChangeEvent(isDark: false));
//                             } else if (value == AppearanceTheme.darkAppearance) {
//                               context.read<ThemeBloc>().add(ThemeChangeEvent(isDark: true));
//                             } else {
//                               // Handle system appearance if needed
//                             }
//                           });
//                         },
//                       ),
//                     ),
//                     ListTile(
//                       title: Text('System Mode'),
//                       leading: Radio<AppearanceTheme>(
//                         activeColor: primaryColor,
//                         value: AppearanceTheme.systemAppearance,
//                         groupValue: _selectedAppearance,
//                         onChanged: (AppearanceTheme? value) {
//                           setState(() {
//                             _selectedAppearance = value;
//                           });
//                           // Update the state of the parent widget
//                           this.setState(() {
//                             // Handle system appearance if needed
//                           });
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               actions: <Widget>[
//                 TextButton(
//                   child: Text('Done',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: fontFamily
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'General',
//           style: TextStyle(fontFamily: fontFamily),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//
//
//
//             // REMIND ME TO TAKE A BREAK
//             CustomToggleButton(
//               onTap: () {
//                 // setState(() {
//                 //   _isRemindMeToTakeBreak = !_isRemindMeToTakeBreak;
//                 // });
//               },
//               toggleName: 'Remind me to take a break',
//               // toggleValue: context.read<ThemeBloc>().state == ThemeMode.dark,
//               //
//               // onChanged: (bool value){
//               //   context.read<ThemeBloc>().add(ThemeChangeEvent(isDark: value));
//               // },
//               toggleValue: _isRemindMeToTakeBreak,
//               onChanged: (bool value) {
//                 setState(() {
//                   _isRemindMeToTakeBreak = value;
//                 });
//               },
//               toggleState: _isRemindMeToTakeBreak ? 'on' : 'off',
//             ),
//
//
//
//
//             // REMIND ME WHEN IT'S BEDTIME
//             CustomToggleButton(
//               onTap: () {},
//               toggleName: 'Remind me when it\'s bedtime',
//               toggleValue: _isRemindBedTime,
//               onChanged: (bool value) {
//                 setState(() {
//                   _isRemindBedTime = value;
//                 });
//               },
//               toggleState: _isRemindBedTime ? '11:00 PM - 5:00 AM' : 'off',
//             ),
//
//
//
//
//             // APPEARANCE THEME OF APP
//             InkWell(
//               onTap: _showAppearanceDialog,
//               child: Container(
//                 height: ScreenSize.screenHeight(context) * 0.09,
//                 width: double.infinity,
//                 padding: EdgeInsets.only(
//                   left: ScreenSize.screenWidth(context) * 0.05,
//                   right: ScreenSize.screenWidth(context) * 0.05,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Appearance',
//                       style: TextStyle(fontSize: 16, fontFamily: fontFamily),
//                     ),
//                     Text(
//                       'Choose your light or dark theme preferences',
//                       style: TextStyle(
//                           fontFamily: fontFamily,
//                           fontSize: 12,
//                           color: Theme.of(context).colorScheme.tertiary),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//
//
//
//
//
//             // APP LANGUAGE
//             InkWell(
//               onTap: (){
//                 // _selectLanguage();
//               },
//               child: Container(
//                 height: ScreenSize.screenHeight(context) * 0.09,
//                 width: double.infinity,
//                 padding: EdgeInsets.only(
//                   left: ScreenSize.screenWidth(context) * 0.05,
//                   right: ScreenSize.screenWidth(context) * 0.05,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'App language',
//                       style: TextStyle(fontSize: 16, fontFamily: fontFamily),
//                     ),
//                     Text(
//                       'English - United States',
//                       style: TextStyle(
//                           fontFamily: fontFamily,
//                           fontSize: 12,
//                           color: Theme.of(context).colorScheme.tertiary),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
//
