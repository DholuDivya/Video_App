import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/report_video_repo.dart';
import 'package:vimeo_clone/bloc/report_video/report_video_event.dart';
import 'package:vimeo_clone/bloc/report_video/report_video_state.dart';

class ReportVideoBloc extends Bloc<ReportVideoEvent, ReportVideoState>{
  ReportVideoBloc() : super(ReportVideoInitial()){
    on<ReportVideoRequest>(_onReportVideoRequest);
  }

  Future<void> _onReportVideoRequest(ReportVideoRequest event, Emitter<ReportVideoState> emit) async {
    try{
      final reportApiMessage = await ReportVideoRepo().reportVideoRepo(event.userId, event.videoId, event.reportContent);
      emit(ReportVideoSuccess(reportApiMessage: reportApiMessage));
    }catch(e){
      emit(ReportVideoFailure(error: e.toString()));
    }
  }
}