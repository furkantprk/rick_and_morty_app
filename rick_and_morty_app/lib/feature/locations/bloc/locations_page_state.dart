import 'package:api_veri/feature/characters/model/user_model.dart';
import 'package:api_veri/feature/locations/model/location_model.dart';
import 'package:api_veri/product/utility/constants/view_status_enum.dart';
import 'package:equatable/equatable.dart';

class LocationsPageState extends Equatable {
  final ViewStatus status;
  final List<LocationModel>? locations;
  final List<bool>? detailList;
  final List<List<UserModel>>? residentList;
  final String? errorMessage;

  const LocationsPageState({
    this.status = ViewStatus.initial,
    this.locations,
    this.detailList,
    this.residentList,
    this.errorMessage,
  });

  @override
  List<Object?> get props =>
      [status, locations, detailList, residentList, errorMessage];

  LocationsPageState copyWith({
    ViewStatus? status,
    List<LocationModel>? locations,
    List<bool>? detailList,
    List<List<UserModel>>? residentList,
    String? errorMessage,
  }) {
    return LocationsPageState(
      status: status ?? this.status,
      locations: locations ?? this.locations,
      detailList: detailList ?? this.detailList,
      residentList: residentList ?? this.residentList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
