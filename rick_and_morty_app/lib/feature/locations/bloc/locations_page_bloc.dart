import 'package:api_veri/feature/characters/model/user_model.dart';
import 'package:api_veri/feature/locations/bloc/locations_page_event.dart';
import 'package:api_veri/feature/locations/bloc/locations_page_state.dart';
import 'package:api_veri/feature/locations/model/location_model.dart';

import 'package:api_veri/product/database/hive_manager.dart';
import 'package:api_veri/product/service/operations/location_service.dart';
import 'package:api_veri/product/service/operations/user_service.dart';
import 'package:api_veri/product/utility/constants/view_status_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationsPageBloc extends Bloc<LocationsPageEvent, LocationsPageState> {
  late final LocationService _locationService;
  late final UserService _userService;
  late final HiveManager _hiveManager;

  LocationsPageBloc() : super(const LocationsPageState()) {
    _locationService = LocationService();
    _userService = UserService();
    _hiveManager = HiveManager();
    on<FetchLocations>(_onFetchLocations);
    on<FetchResidents>(_onFetchResidents);
    on<ToggleDetailVisibilityAndFetchResidents>(
        _onToggleDetailVisibilityAndFetchResidents);
  }

  Future<void> _onFetchLocations(
      FetchLocations event, Emitter<LocationsPageState> emit) async {
    emit(state.copyWith(status: ViewStatus.loading));
    try {
      List<LocationModel> fetchedLocations =
          await _hiveManager.operations.getLocations();
      if (fetchedLocations.isEmpty) {
        fetchedLocations = await _locationService.getLocations();
        await _hiveManager.operations.saveLocations(fetchedLocations);
      }

      final detailList = List<bool>.filled(fetchedLocations.length, false);
      final residentList =
          List<List<UserModel>>.generate(fetchedLocations.length, (_) => []);
      emit(state.copyWith(
          status: ViewStatus.loaded,
          locations: fetchedLocations,
          detailList: detailList,
          residentList: residentList));
    } catch (e) {
      emit(state.copyWith(
          status: ViewStatus.error,
          errorMessage: 'Error fetching locations: $e'));
    }
  }

  Future<void> _onFetchResidents(
      FetchResidents event, Emitter<LocationsPageState> emit) async {
    final currentState = state;
    if (currentState.status == ViewStatus.loaded &&
        currentState.locations != null) {
      try {
        final index = event.index;
        final location = currentState.locations![index];
        if (location.residents != null) {
          final residentUrls = location.residents!
              .where((url) => url != null)
              .map((url) => url!)
              .toList();
          final fetchedResidents =
              await Future.wait(residentUrls.map((url) async {
            final userId = int.parse(Uri.parse(url).pathSegments.last);
            final user = await _hiveManager.operations.getUsersByIds([userId]);
            if (user.isEmpty) {
              final fetchedUser = await _userService.getUserById(userId);
              if (fetchedUser != null) {
                await _hiveManager.operations.saveUsers([fetchedUser]);
              }
              return fetchedUser;
            }
            return user.first;
          }).toList());

          final nonNullResidents = fetchedResidents
              .where((resident) => resident != null)
              .cast<UserModel>()
              .toList();

          final updatedResidentList =
              List<List<UserModel>>.from(currentState.residentList!);
          updatedResidentList[index] = nonNullResidents;
          emit(currentState.copyWith(residentList: updatedResidentList));
        }
      } catch (e) {
        emit(state.copyWith(
            status: ViewStatus.error,
            errorMessage: 'Error fetching residents: $e'));
      }
    }
  }

  void _onToggleDetailVisibilityAndFetchResidents(
      ToggleDetailVisibilityAndFetchResidents event,
      Emitter<LocationsPageState> emit) {
    final currentState = state;
    if (currentState.status == ViewStatus.loaded &&
        currentState.locations != null) {
      final index = event.index;
      final updatedDetailList = List<bool>.from(currentState.detailList!);
      updatedDetailList[index] = !updatedDetailList[index];
      emit(currentState.copyWith(detailList: updatedDetailList));

      if (updatedDetailList[index] &&
          currentState.residentList![index].isEmpty) {
        add(FetchResidents(index));
      }
    }
  }
}
