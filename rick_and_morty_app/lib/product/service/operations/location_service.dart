import 'package:api_veri/feature/locations/model/location_model.dart';
import 'package:api_veri/product/service/manager/service_manager.dart';
import 'package:api_veri/product/utility/constants/string_constants.dart';

class LocationService with ApiServiceMixin {
  Future<List<LocationModel>> getLocations() async {
    final response = await getRequest<Map<String, dynamic>>(
        '${AppString.baseUrl}/location', (json) => json);
    return (response['results'] as List)
        .map((locationJson) => LocationModel.fromJson(locationJson))
        .toList();
  }

  Future<LocationModel?> getLocationById(int id) async {
    return await getRequest<LocationModel?>('${AppString.baseUrl}/location/$id',
        (json) => LocationModel.fromJson(json));
  }

  Future<LocationModel?> createLocation(LocationModel location) async {
    return await postRequest<LocationModel?>('${AppString.baseUrl}/location',
        location.toJson(), (json) => LocationModel.fromJson(json));
  }

  Future<LocationModel?> updateLocation(int id, LocationModel location) async {
    return await putRequest<LocationModel?>('${AppString.baseUrl}/location/$id',
        location.toJson(), (json) => LocationModel.fromJson(json));
  }

  Future<void> deleteLocation(int id) async {
    await deleteRequest('${AppString.baseUrl}/location/$id');
  }
}
