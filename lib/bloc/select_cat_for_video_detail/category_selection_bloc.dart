import 'package:flutter_bloc/flutter_bloc.dart';

import 'category_selection_event.dart';
import 'category_selection_state.dart';

class CategorySelectionBloc extends Bloc<CategorySelectionEvent, CategorySelectionState> {
  CategorySelectionBloc() : super(CategorySelectionInitial()) {
    on<SelectCategoryEvent>(_onSelectCategory);
    on<ClearCategorySelectionEvent>(_onClearCategorySelection);
  }

  void _onSelectCategory(SelectCategoryEvent event, Emitter<CategorySelectionState> emit) {
    final currentState = state;
    if (currentState is CategorySelected) {
      // Toggle the selection state: Add the category if not selected, remove it if already selected
      final updatedCategoryIds = List<int>.from(currentState.selectedCategoryIds);

      if (updatedCategoryIds.contains(event.categoryId)) {
        updatedCategoryIds.remove(event.categoryId); // Deselect if already selected
      } else {
        updatedCategoryIds.add(event.categoryId); // Select if not already selected
      }

      emit(CategorySelected(selectedCategoryIds: updatedCategoryIds));
    } else {
      // First category selected, no prior selections
      emit(CategorySelected(selectedCategoryIds: [event.categoryId]));
    }
  }

  void _onClearCategorySelection(ClearCategorySelectionEvent event, Emitter<CategorySelectionState> emit) {
    // Clear all selected categories
    emit(CategorySelectionInitial());
  }
}

//
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vimeo_clone/bloc/select_cat_for_video_detail/category_selection_event.dart';
// import 'package:vimeo_clone/bloc/select_cat_for_video_detail/category_selection_state.dart';
//
// class CategorySelectionBloc extends Bloc<CategorySelectionEvent, CategorySelectionState> {
//   CategorySelectionBloc() : super(CategorySelectionInitial()) {
//     on<SelectCategoryEvent>(_onSelectCategory);
//     on<DeselectCategoryEvent>(_onDeselectCategory);
//   }
//
//   // Handle category selection logic
//   void _onSelectCategory(SelectCategoryEvent event, Emitter<CategorySelectionState> emit) {
//     final currentSelectedIds = state is CategorySelected
//         ? (state as CategorySelected).selectedCategoryIds
//         : [];
//
//     // Only add the category if it hasn't been selected already
//     if (!currentSelectedIds.contains(event.categoryId)) {
//       final newSelectedIds = List<int>.from(currentSelectedIds)..add(event.categoryId);
//       emit(CategorySelected(selectedCategoryIds: newSelectedIds));
//     }
//   }
//
//   // Handle category deselection logic
//   void _onDeselectCategory(DeselectCategoryEvent event, Emitter<CategorySelectionState> emit) {
//     final currentSelectedIds = state is CategorySelected
//         ? (state as CategorySelected).selectedCategoryIds
//         : [];
//
//     // Remove the category from the selected list if it exists
//     if (currentSelectedIds.contains(event.categoryId)) {
//       final newSelectedIds = List<int>.from(currentSelectedIds)..remove(event.categoryId);
//       emit(CategorySelected(selectedCategoryIds: newSelectedIds));
//     }
//   }
// }