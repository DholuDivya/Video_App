import 'package:equatable/equatable.dart';

import '../../model/video_categories_model.dart';

abstract class CategorySelectionState extends Equatable {
  @override
  List<Object> get props => [];
}

class CategorySelectionInitial extends CategorySelectionState {}

class CategorySelected extends CategorySelectionState {
  final List<int> selectedCategoryIds;

  CategorySelected({required this.selectedCategoryIds});
}
