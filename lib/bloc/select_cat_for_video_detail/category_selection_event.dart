import 'package:equatable/equatable.dart';
import '../../model/video_categories_model.dart';


abstract class CategorySelectionEvent extends Equatable {}

class SelectCategoryEvent extends CategorySelectionEvent {
  final int categoryId;

  SelectCategoryEvent({required this.categoryId});

  @override
  List<Object?> get props => [categoryId];
}

class DeselectCategoryEvent extends CategorySelectionEvent {
  final int categoryId;

  DeselectCategoryEvent({required this.categoryId});

  @override
  List<Object?> get props => [categoryId];
}