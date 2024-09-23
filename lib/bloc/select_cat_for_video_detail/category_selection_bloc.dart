// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'category_selection_event.dart';
// import 'category_selection_state.dart';
//
// class CategorySelectionBloc extends Bloc<CategorySelectionEvent, CategorySelectionState> {
//   CategorySelectionBloc() : super(CategorySelectionInitial()) {
//     on<SelectCategoryEvent>(_onSelectCategory);
//     on<ClearCategorySelectionEvent>(_onClearCategorySelection);
//   }
//
//   void _onSelectCategory(SelectCategoryEvent event, Emitter<CategorySelectionState> emit) {
//     final currentState = state;
//     if (currentState is CategorySelected) {
//       // Toggle the selection state: Add the category if not selected, remove it if already selected
//       final updatedCategoryIds = List<int>.from(currentState.selectedCategoryIds);
//       final updatedCategoryNames = List<String>.from(currentState.selectedCategoryNames);
//
//       final isSelected = updatedCategoryIds.contains(event.categoryId);
//
//       if (isSelected) {
//         // Find the index of the userId in the selectedIndices list
//         final removeIndex = updatedCategoryIds.indexOf(event.categoryId);
//
//         // Remove userId and corresponding username
//         updatedCategoryIds.removeAt(removeIndex);
//         updatedCategoryNames.removeAt(removeIndex);
//       } else {
//         // Add userId and corresponding username
//         updatedCategoryIds.add(event.categoryId);
//         updatedCategoryNames.add(event.categoryName);
//       }
//
//
//
//       // if (updatedCategoryIds.contains(event.categoryId)) {
//       //   updatedCategoryIds.remove(event.categoryId); // Deselect if already selected
//       // } else {
//       //   updatedCategoryIds.add(event.categoryId); // Select if not already selected
//       // }
//
//       emit(CategorySelected(selectedCategoryIds: updatedCategoryIds, selectedCategoryNames: updatedCategoryNames));
//     }
//   }
//
//   void _onClearCategorySelection(ClearCategorySelectionEvent event, Emitter<CategorySelectionState> emit) {
//     // Clear all selected categories
//     emit(CategorySelectionInitial());
//   }
// }









import 'package:flutter_bloc/flutter_bloc.dart';

import 'category_selection_event.dart';
import 'category_selection_state.dart';

class CategorySelectionBloc extends Bloc<CategorySelectionEvent, CategorySelectionState> {
  CategorySelectionBloc() : super(CategorySelectionInitial()) {
    on<SelectCategoryEvent>(_onSelectCategory);
    on<DeselectCategoryEvent>(_onDeselectCategory);
    on<ClearCategorySelectionEvent>(_onClearCategorySelection);
    on<UpdateCategorySelectionEvent>(_onUpdateCategorySelection);

  }

  void _onSelectCategory(SelectCategoryEvent event, Emitter<CategorySelectionState> emit) {
    final currentState = state;
    if (currentState is CategorySelected) {
      final updatedCategoryIds = List<int>.from(currentState.selectedCategoryIds);
      final updatedCategoryNames = List<String>.from(currentState.selectedCategoryNames);

      // Add the selected category if not already selected
      if (!updatedCategoryIds.contains(event.categoryId)) {
        updatedCategoryIds.add(event.categoryId);
        updatedCategoryNames.add(event.categoryName);
      }

      emit(CategorySelected(selectedCategoryIds: updatedCategoryIds, selectedCategoryNames: updatedCategoryNames));
      emit(CategorySelectionInitial());
    } else {
      // Initial category selection if state is CategorySelectionInitial
      emit(CategorySelected(
        selectedCategoryIds: [event.categoryId],
        selectedCategoryNames: [event.categoryName],
      ));
      emit(CategorySelectionInitial());
    }
  }

  void _onDeselectCategory(DeselectCategoryEvent event, Emitter<CategorySelectionState> emit) {
    final currentState = state;
    if (currentState is CategorySelected) {
      final updatedCategoryIds = List<int>.from(currentState.selectedCategoryIds);
      final updatedCategoryNames = List<String>.from(currentState.selectedCategoryNames);

      // Remove the category if it is already selected
      updatedCategoryIds.remove(event.categoryId);
      updatedCategoryNames.removeWhere((name) => name == event.categoryName);

      emit(CategorySelected(selectedCategoryIds: updatedCategoryIds, selectedCategoryNames: updatedCategoryNames));
      emit(CategorySelectionInitial());
    }
  }

  void _onClearCategorySelection(ClearCategorySelectionEvent event, Emitter<CategorySelectionState> emit) {
    // Clear all selected categories
    emit(CategorySelectionInitial());
  }


  void _onUpdateCategorySelection(UpdateCategorySelectionEvent event, Emitter<CategorySelectionState> emit) {
    // Emit the selected categories
    emit(CategorySelected(
      selectedCategoryIds: event.selectedCategoryIds,
      selectedCategoryNames: event.selectedCategoryNames,
    ));
  }



}





