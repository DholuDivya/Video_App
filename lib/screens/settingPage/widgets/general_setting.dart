import 'package:flutter/material.dart';
import 'package:vimeo_clone/Utils/Widgets/toggle_button.dart';

class GeneralSettings extends StatefulWidget {
  const GeneralSettings({super.key});

  @override
  State<GeneralSettings> createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
  bool _isRemindMeToTakeBreak = false;
  bool _isRemindBedTime = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('General', style:  TextStyle(fontFamily: 'Poppins'),),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            // REMIND ME TO TAKE A BREAK
            CustomToggleButton(
                onTap: (){
                  // setState(() {
                  //   _isRemindMeToTakeBreak = !_isRemindMeToTakeBreak;
                  // });
                },
                toggleName: 'Remind me to take a break',
                toggleValue: _isRemindMeToTakeBreak,
                onChanged: (bool value){
                  setState(() {
                    _isRemindMeToTakeBreak = value;
                  });
                },
                toggleState: _isRemindMeToTakeBreak ? 'on' : 'off',
            ),


            // REMIND ME WHEN IT'S BEDTIME
            CustomToggleButton(
              onTap: (){},
              toggleName: 'Remind me when it\'s bedtime',
              toggleValue: _isRemindBedTime,
              onChanged: (bool value){
                setState(() {
                  _isRemindBedTime = value;
                });
              },
              toggleState: _isRemindBedTime ? '11:00 PM - 5:00 AM' : 'off',
            ),


          ],
        ),
      ),
    );
  }
}
