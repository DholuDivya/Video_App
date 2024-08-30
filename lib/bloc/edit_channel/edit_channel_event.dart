import 'package:equatable/equatable.dart';
import 'package:image_cropper/image_cropper.dart';

abstract class EditChannelEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class EditChannelRequest extends EditChannelEvent{
  final String? channelName;
  final CroppedFile? channelLogo;
  final CroppedFile? channelBanner;

  EditChannelRequest({this.channelName, this.channelLogo, this.channelBanner});

  @override
  List<Object?> get props => [channelName, channelLogo, channelBanner];
}
