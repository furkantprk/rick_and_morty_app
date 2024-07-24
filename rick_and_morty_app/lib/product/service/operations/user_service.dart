import 'package:api_veri/feature/characters/model/user_model.dart';
import 'package:api_veri/product/service/manager/service_manager.dart';
import 'package:api_veri/product/utility/constants/string_constants.dart';

class UserService with ApiServiceMixin {
  Future<List<UserModel>> getUsers() async {
    final response = await getRequest<Map<String, dynamic>>(
        '${AppString.baseUrl}/character', (json) => json);
    return (response['results'] as List)
        .map((userJson) => UserModel.fromJson(userJson))
        .toList();
  }

  Future<UserModel?> getUserById(int id) async {
    return await getRequest<UserModel?>('${AppString.baseUrl}/character/$id',
        (json) => UserModel.fromJson(json));
  }

  Future<UserModel?> createUser(UserModel user) async {
    return await postRequest<UserModel?>('${AppString.baseUrl}/character',
        user.toJson(), (json) => UserModel.fromJson(json));
  }

  Future<UserModel?> updateUser(int id, UserModel user) async {
    return await putRequest<UserModel?>('${AppString.baseUrl}/character/$id',
        user.toJson(), (json) => UserModel.fromJson(json));
  }

  Future<void> deleteUser(int id) async {
    await deleteRequest('${AppString.baseUrl}/character/$id');
  }
}
