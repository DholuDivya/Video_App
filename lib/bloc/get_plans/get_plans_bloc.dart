import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/get_plans_repo.dart';
import 'package:vimeo_clone/bloc/get_plans/get_plans_event.dart';
import 'package:vimeo_clone/bloc/get_plans/get_plans_state.dart';
import 'package:vimeo_clone/model/plans_model.dart';

class GetPlansBloc extends Bloc<GetPlansEvent, GetPlansState>{
  GetPlansBloc() : super(GetPlansInitial()){
    on<GetPlansRequest>(_onGetPlansRequest);
  }

  Future<void> _onGetPlansRequest(GetPlansRequest event, Emitter<GetPlansState> emit) async {
    try{
      final List<PlansModel>? plansList = await GetPlansRepo().getPlans();
      emit(GetPlansLoaded(plansList: plansList!));
    }catch(e){
      emit(GetPlansFailure(error: e.toString()));
    }
  }
}