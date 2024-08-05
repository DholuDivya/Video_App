// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDataModelAdapter extends TypeAdapter<UserDataModel> {
  @override
  final int typeId = 0;

  @override
  UserDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDataModel(
      userToken: fields[0] as String?,
      userId: fields[1] as String?,
      userName: fields[2] as String?,
      userEmail: fields[4] as String?,
      userNumber: fields[3] as String?,
      userProfilePhoto: fields[5] as String?,
      userChannelId: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserDataModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.userToken)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.userName)
      ..writeByte(3)
      ..write(obj.userNumber)
      ..writeByte(4)
      ..write(obj.userEmail)
      ..writeByte(5)
      ..write(obj.userProfilePhoto)
      ..writeByte(6)
      ..write(obj.userChannelId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
