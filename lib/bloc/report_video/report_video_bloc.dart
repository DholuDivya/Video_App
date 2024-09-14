import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/bloc/report_video/report_video_event.dart';
import 'package:vimeo_clone/bloc/report_video/report_video_state.dart';

class ReportVideoBloc extends Bloc<ReportVideoEvent, ReportVideoState>{
  ReportVideoBloc() : super(ReportVideoInitial()){
    on<ReportVideoRequest>(_onReportVideoRequest);
  }

  Future<void> _onReportVideoRequest(ReportVideoRequest event, Emitter<ReportVideoState> emit) async {
    try{

    }catch(e){
      emit(ReportVideoFailure(error: e.toString()));
    }
  }
}