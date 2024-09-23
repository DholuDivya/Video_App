import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/bloc/report_video/report_video_bloc.dart';

import '../../bloc/report_video/report_video_event.dart';
import '../../bloc/report_video/report_video_state.dart';
import '../../config/colors.dart';
import '../../config/constants.dart';
import '../../config/global_variable.dart';
import 'custom_radio_button_list.dart';

class CustomReportDialog extends StatefulWidget {
  final int videoId;
  const CustomReportDialog({super.key, required this.videoId});

  @override
  _CustomReportDialogState createState() => _CustomReportDialogState();
}

class _CustomReportDialogState extends State<CustomReportDialog> {
  String _selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      title: const Text('Report Content'),
      content: RadioButtonList<String>(
        options: const [
          'Violent Content',
          'Hateful Content',
          'Harmful Content',
          'Spam',
          'Child Abuse'
        ],
        selectedValue: _selectedValue,
        onChanged: (String newValue) {
          setState(() {
            _selectedValue = newValue;
          });
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel',
            style: TextStyle(
                fontFamily: fontFamily,
                color: greyShade500
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            // Handle the selected value here
            final userId = int.parse(Global.userData!.userId!);
            print('Selected value: $_selectedValue');
            context.read<ReportVideoBloc>().add(ReportVideoRequest(
                userId: userId,
                videoId: widget.videoId,
                reportContent: _selectedValue
            ));
            Navigator.of(context).pop();
            final reportBloc = context.read<ReportVideoBloc>();
            reportBloc.stream.listen((state){
              if(state is ReportVideoSuccess){
                if(mounted){
                  ToastManager().showToast(
                      context: context,
                      message: state.reportApiMessage
                  );
                }
              }
            });

          },
          child: Text(
            'Report',
            style: TextStyle(
                fontFamily: fontFamily,
                color: primaryColor
            ),
          ),
        ),
      ],
    );
  }
}


