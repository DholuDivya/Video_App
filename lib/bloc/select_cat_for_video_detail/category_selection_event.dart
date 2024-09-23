import 'package:equatable/equatable.dart';
import '../../model/video_categories_model.dart';


abstract class CategorySelectionEvent extends Equatable {}

class SelectCategoryEvent extends CategorySelectionEvent {
  final int categoryId;
  final String categoryName;

  SelectCategoryEvent({required this.categoryId, required this.categoryName});

  @override
  List<Object?> get props => [categoryId, categoryName];
}

class DeselectCategoryEvent extends CategorySelectionEvent {
  final int categoryId;
  final String categoryName;

  DeselectCategoryEvent({required this.categoryId, required this.categoryName});

  @override
  List<Object?> get props => [categoryId, categoryName];
}

class ClearCategorySelectionEvent extends CategorySelectionEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateCategorySelectionEvent extends CategorySelectionEvent {
  final List<int> selectedCategoryIds;
  final List<String> selectedCategoryNames;

  UpdateCategorySelectionEvent({required this.selectedCategoryIds, required this.selectedCategoryNames});

  @override
  List<Object?> get props => [selectedCategoryIds, selectedCategoryNames];
}

