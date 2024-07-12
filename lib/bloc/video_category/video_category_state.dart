import 'package:equatable/equatable.dart';

import '../../model/video_categories_model.dart';

abstract class VideoCategoryState extends Equatable{}

class VideoCategoriesInitial extends VideoCategoryState{
  @override
  List<Object?> get props => [];
}

class VideoCategoriesLoading extends VideoCategoryState{
  @override
  List<Object?> get props => throw [];
}

class VideoCategoriesLoaded extends VideoCategoryState{
  final List<VideoCategoriesModel> categories;
  final int selectedCategory;

  VideoCategoriesLoaded({required this.categories, required this.selectedCategory});

  @override
  List<Object> get props => [categories, selectedCategory];
}

class VideoCategoriesFailure extends VideoCategoryState{
  final String? error;

  VideoCategoriesFailure({this.error});
  @override
  List<Object?> get props => [error];
}