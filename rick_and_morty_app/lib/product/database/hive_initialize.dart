import 'package:hive/hive.dart';
import 'package:api_veri/feature/locations/model/location_model.dart';
import 'package:api_veri/feature/characters/model/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

mixin HiveInitialize {
  late Box<LocationModel> _locationsBox;
  late Box<UserModel> _usersBox;
  late Box _userPrefsBox;

  Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(LocationModelAdapter());
    Hive.registerAdapter(UserModelAdapter());

    _locationsBox = await Hive.openBox<LocationModel>('locations');
    _usersBox = await Hive.openBox<UserModel>('users');
    _userPrefsBox = await Hive.openBox('userPrefs');
  }

  Box<LocationModel> get locationsBox => _locationsBox;
  Box<UserModel> get usersBox => _usersBox;
  Box get userPrefsBox => _userPrefsBox;
}
