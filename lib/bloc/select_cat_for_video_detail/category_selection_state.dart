import 'package:equatable/equatable.dart';

abstract class CategorySelectionState extends Equatable {
  @override
  List<Object> get props => [];
}

class CategorySelectionInitial extends CategorySelectionState {}

class CategorySelected extends CategorySelectionState {
  final List<int> selectedCategoryIds;
  final List<String> selectedCategoryNames;

  CategorySelected({required this.selectedCategoryIds, required this.selectedCategoryNames});

  @override
  List<Object> get props => [selectedCategoryIds, selectedCategoryNames];
}
