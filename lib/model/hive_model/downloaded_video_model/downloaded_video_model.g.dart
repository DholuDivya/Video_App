// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downloaded_video_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DownloadedVideoModelAdapter extends TypeAdapter<DownloadedVideoModel> {
  @override
  final int typeId = 1;

  @override
  DownloadedVideoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DownloadedVideoModel(
      videoId: fields[0] as String?,
      videoSlug: fields[1] as String?,
      videoType: fields[2] as String?,
      videoSource: fields[3] as String?,
      videoThumbnail: fields[4] as String?,
      videoTitle: fields[5] as String?,
      videoDescription: fields[6] as String?,
      videoHashtag: fields[7] as String?,
      videoCreateAtHuman: fields[8] as String?,
      videoDuration: fields[9] as String?,
      videoViews: fields[10] as String?,
      videoCategory: fields[11] as String?,
      videoComments: fields[12] as String?,
      videoLikes: fields[13] as String?,
      channelLogo: fields[14] as String?,
      channelName: fields[15] as String?,
      contentType: fields[16] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DownloadedVideoModel obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.videoId)
      ..writeByte(1)
      ..write(obj.videoSlug)
      ..writeByte(2)
      ..write(obj.videoType)
      ..writeByte(3)
      ..write(obj.videoSource)
      ..writeByte(4)
      ..write(obj.videoThumbnail)
      ..writeByte(5)
      ..write(obj.videoTitle)
      ..writeByte(6)
      ..write(obj.videoDescription)
      ..writeByte(7)
      ..write(obj.videoHashtag)
      ..writeByte(8)
      ..write(obj.videoCreateAtHuman)
      ..writeByte(9)
      ..write(obj.videoDuration)
      ..writeByte(10)
      ..write(obj.videoViews)
      ..writeByte(11)
      ..write(obj.videoCategory)
      ..writeByte(12)
      ..write(obj.videoComments)
      ..writeByte(13)
      ..write(obj.videoLikes)
      ..writeByte(14)
      ..write(obj.channelLogo)
      ..writeByte(15)
      ..write(obj.channelName)
      ..writeByte(16)
      ..write(obj.contentType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownloadedVideoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
