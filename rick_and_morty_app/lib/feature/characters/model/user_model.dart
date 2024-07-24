import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class UsersModelLocation {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? url;

  UsersModelLocation({
    this.name,
    this.url,
  });

  factory UsersModelLocation.fromJson(Map<String, dynamic> json) =>
      _$UsersModelLocationFromJson(json);

  Map<String, dynamic> toJson() => _$UsersModelLocationToJson(this);
}

@HiveType(typeId: 2)
@JsonSerializable()
class UsersModelOrigin {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? url;

  UsersModelOrigin({
    this.name,
    this.url,
  });

  factory UsersModelOrigin.fromJson(Map<String, dynamic> json) =>
      _$UsersModelOriginFromJson(json);

  Map<String, dynamic> toJson() => _$UsersModelOriginToJson(this);
}

@HiveType(typeId: 3)
@JsonSerializable()
class UserModel {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? status;
  @HiveField(3)
  final String? species;
  @HiveField(4)
  final String? type;
  @HiveField(5)
  final String? gender;
  @HiveField(6)
  final UsersModelOrigin? origin;
  @HiveField(7)
  final UsersModelLocation? location;
  @HiveField(8)
  final String? image;
  @HiveField(9)
  final List<String?>? episode;
  @HiveField(10)
  final String? url;
  @HiveField(11)
  final String? created;

  UserModel(
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    int? id,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
    UsersModelOrigin? origin,
    UsersModelLocation? location,
    String? image,
    List<String?>? episode,
    String? url,
    String? created,
  }) {
    return UserModel(
      id ?? this.id,
      name ?? this.name,
      status ?? this.status,
      species ?? this.species,
      type ?? this.type,
      gender ?? this.gender,
      origin ?? this.origin,
      location ?? this.location,
      image ?? this.image,
      episode ?? this.episode,
      url ?? this.url,
      created ?? this.created,
    );
  }
}
