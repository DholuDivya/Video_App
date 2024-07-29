// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'category_selection_event.dart';
// import 'category_selection_state.dart';
//
// class CategorySelectionBloc extends Bloc<CategorySelectionEvent, CategorySelectionState> {
//   CategorySelectionBloc() : super(CategorySelectionInitial()) {
//     on<SelectCategoryEvent>(_onSelectCategory);
//   }
//
//   void _onSelectCategory(SelectCategoryEvent event, Emitter<CategorySelectionState> emit) {
//     emit(CategorySelected(event.selectedCategory));
//   }
// }




import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_clone/bloc/select_cat_for_video_detail/category_selection_event.dart';
import 'package:vimeo_clone/bloc/select_cat_for_video_detail/category_selection_state.dart';

class CategorySelectionBloc extends Bloc<CategorySelectionEvent, CategorySelectionState> {
  CategorySelectionBloc() : super(CategorySelectionInitial()) {
    on<SelectCategoryEvent>(_onSelectCategory);
    on<DeselectCategoryEvent>(_onDeselectCategory);
  }

  void _onSelectCategory(SelectCategoryEvent event, Emitter<CategorySelectionState> emit) {
    final currentSelectedIds = state is CategorySelected
        ? (state as CategorySelected).selectedCategoryIds
        : [];
    final newSelectedIds = List<int>.from(currentSelectedIds)..add(event.categoryId);
    emit(CategorySelected(selectedCategoryIds: newSelectedIds));
  }

  void _onDeselectCategory(DeselectCategoryEvent event, Emitter<CategorySelectionState> emit) {
    final currentSelectedIds = state is CategorySelected
        ? (state as CategorySelected).selectedCategoryIds
        : [];
    final newSelectedIds = List<int>.from(currentSelectedIds)..remove(event.categoryId);
    emit(CategorySelected(selectedCategoryIds: newSelectedIds));
  }
}
