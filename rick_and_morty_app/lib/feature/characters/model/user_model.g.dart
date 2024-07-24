// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsersModelLocationAdapter extends TypeAdapter<UsersModelLocation> {
  @override
  final int typeId = 1;

  @override
  UsersModelLocation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UsersModelLocation(
      name: fields[0] as String?,
      url: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UsersModelLocation obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsersModelLocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UsersModelOriginAdapter extends TypeAdapter<UsersModelOrigin> {
  @override
  final int typeId = 2;

  @override
  UsersModelOrigin read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UsersModelOrigin(
      name: fields[0] as String?,
      url: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UsersModelOrigin obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsersModelOriginAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 3;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as String?,
      fields[5] as String?,
      fields[6] as UsersModelOrigin?,
      fields[7] as UsersModelLocation?,
      fields[8] as String?,
      (fields[9] as List?)?.cast<String?>(),
      fields[10] as String?,
      fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.species)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.origin)
      ..writeByte(7)
      ..write(obj.location)
      ..writeByte(8)
      ..write(obj.image)
      ..writeByte(9)
      ..write(obj.episode)
      ..writeByte(10)
      ..write(obj.url)
      ..writeByte(11)
      ..write(obj.created);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersModelLocation _$UsersModelLocationFromJson(Map<String, dynamic> json) =>
    UsersModelLocation(
      name: json['name'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$UsersModelLocationToJson(UsersModelLocation instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };

UsersModelOrigin _$UsersModelOriginFromJson(Map<String, dynamic> json) =>
    UsersModelOrigin(
      name: json['name'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$UsersModelOriginToJson(UsersModelOrigin instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['id'] as int?,
      json['name'] as String?,
      json['status'] as String?,
      json['species'] as String?,
      json['type'] as String?,
      json['gender'] as String?,
      json['origin'] == null
          ? null
          : UsersModelOrigin.fromJson(json['origin'] as Map<String, dynamic>),
      json['location'] == null
          ? null
          : UsersModelLocation.fromJson(
              json['location'] as Map<String, dynamic>),
      json['image'] as String?,
      (json['episode'] as List<dynamic>?)?.map((e) => e as String?).toList(),
      json['url'] as String?,
      json['created'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'species': instance.species,
      'type': instance.type,
      'gender': instance.gender,
      'origin': instance.origin,
      'location': instance.location,
      'image': instance.image,
      'episode': instance.episode,
      'url': instance.url,
      'created': instance.created,
    };
