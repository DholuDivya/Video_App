import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/Repo/video_category_repo.dart';
import 'package:vimeo_clone/bloc/video_category/video_category_event.dart';
import 'package:vimeo_clone/bloc/video_category/video_category_state.dart';
import 'package:vimeo_clone/model/video_categories_model.dart';

class VideoCategoriesBloc extends Bloc<VideoCategoryEvent, VideoCategoryState>{
  final VideoCategoriesRepo videoCategoriesRepo;

  VideoCategoriesBloc(this.videoCategoriesRepo) : super(VideoCategoriesInitial()){
    on<GetCategoryEvent>(_onFetchVideoCategories);
    on<SelectCategory>(_onSelectCategory);


    // on<GetCategoryEvent>((event, emit) async {
    //   emit(VideoCategoriesLoading());
    //   print('vvvvvvvvvvvvvvvvvvvvv');
    //   try{
    //     print('[[[[[[[[[[[[[[[[[[[[[[');
    //     final List<VideoCategoriesModel>? categories = await videoCategoriesRepo.getVideoCategories();
    //     print('|||||||||  ${categories?[2].name}  |||||||||||||');
    //     emit(VideoCategoriesLoaded(categories: categories!));
    //   }catch(e){
    //     emit(VideoCategoriesFailure(error: e.toString()));
    //   }
    // });
  }

  Future<void> _onFetchVideoCategories(GetCategoryEvent event, Emitter<VideoCategoryState> emit) async {
    emit(VideoCategoriesLoading());
    try {
      final List<VideoCategoriesModel>? categories = await videoCategoriesRepo.getVideoCategories();
      emit(VideoCategoriesLoaded(categories: categories!, selectedCategory: 0));
    } catch (e) {
      emit(VideoCategoriesFailure(error: e.toString()));
    }
  }

  void _onSelectCategory(SelectCategory event, Emitter<VideoCategoryState> emit) {
    if (state is VideoCategoriesLoaded) {
      emit(VideoCategoriesLoaded( selectedCategory: event.selectedCategory, categories: (state as VideoCategoriesLoaded).categories));
    }
  }


}