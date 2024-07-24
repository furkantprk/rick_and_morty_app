import 'package:api_veri/feature/locations/model/location_model.dart';
import 'package:api_veri/feature/characters/model/user_model.dart';
import 'package:api_veri/product/database/hive_initialize.dart';

class HiveOperations with HiveInitialize {
  Future<List<LocationModel>> getLocations() async {
    if (locationsBox.isNotEmpty) {
      return locationsBox.values.toList();
    }
    return [];
  }

  Future<void> saveLocations(List<LocationModel> locations) async {
    for (var location in locations) {
      locationsBox.put(location.id, location);
    }
  }

  Future<List<UserModel>> getUsersByIds(List<int> userIds) async {
    return userIds
        .map((id) => usersBox.get(id))
        .where((user) => user != null)
        .cast<UserModel>()
        .toList();
  }

  Future<void> saveUsers(List<UserModel> users) async {
    for (var user in users) {
      usersBox.put(user.id, user);
    }
  }

  Future<List<String>> getFollowedUsers() async {
    return userPrefsBox.get('followedUsers')?.cast<String>() ?? [];
  }

  Future<void> saveFollowedUsers(List<String> followedUsers) async {
    await userPrefsBox.put('followedUsers', followedUsers);
  }

  Future<List<String>> getUserNames() async {
    return userPrefsBox.get('userNames')?.cast<String>() ?? [];
  }

  Future<void> saveUserNames(List<String> userNames) async {
    await userPrefsBox.put('userNames', userNames);
  }
}
