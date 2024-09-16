import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class GetShortsEvent extends Equatable{}

class GetShortsFromCamera extends GetShortsEvent{
  @override
  List<Object?> get props => [];
}

class GetShortsFromFile extends GetShortsEvent{
  final BuildContext context;

  GetShortsFromFile({required this.context});

  @override
  List<Object?> get props => [context];
}