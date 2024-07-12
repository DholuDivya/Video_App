import 'package:equatable/equatable.dart';

abstract class VideoCategoryEvent extends Equatable{}

class GetCategoryEvent extends VideoCategoryEvent{
  @override
  List<Object?> get props => [];
}

class SelectCategory extends VideoCategoryEvent{
  final int selectedCategory;

  SelectCategory({required this.selectedCategory});
  @override
  List<Object?> get props => [selectedCategory];

}