import 'package:equatable/equatable.dart';

abstract class ReportVideoEvent extends Equatable{}

class ReportVideoRequest extends ReportVideoEvent{
  final int userId;
  final int videoId;
  final String reportContent;

  ReportVideoRequest({required this.userId, required this.videoId, required this.reportContent});

  @override
  List<Object?> get props => [userId, videoId, reportContent];
}