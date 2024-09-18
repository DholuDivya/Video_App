import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/bloc/about_us/about_us_event.dart';
import 'package:vimeo_clone/bloc/about_us/about_us_state.dart';

class AboutUsBloc extends Bloc<AboutUsEvent, AboutUsState>{
  AboutUsBloc() : super(AboutUsInitial()){
    on<AboutUsRequest>(_onAboutUsRequest);
  }

  Future<void> _onAboutUsRequest(AboutUsRequest event, Emitter<AboutUsState> emit) async {
    try{

    }catch(e){
      emit(AboutUsFailure(error: e.toString()));
    }
  }
}