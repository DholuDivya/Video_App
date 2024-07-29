import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

abstract class GetVideoState extends Equatable{}

class GetVideoInitial extends GetVideoState{
  @override
  List<Object?> get props => [];
}

class GetVideoLoading extends GetVideoState{
  @override
  List<Object?> get props => [];
}

class GetVideoSuccess extends GetVideoState{
  final PlatformFile? userVideo;

  GetVideoSuccess({required this.userVideo});

  @override
  List<Object?> get props => [userVideo];
}

class GetVideoFailure extends GetVideoState{
  final String error;

  GetVideoFailure({required this.error});

  @override
  List<Object?> get props => [error];
}