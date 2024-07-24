import 'package:equatable/equatable.dart';

abstract class LocationsPageEvent extends Equatable {
  const LocationsPageEvent();

  @override
  List<Object> get props => [];
}

class FetchLocations extends LocationsPageEvent {}

class FetchResidents extends LocationsPageEvent {
  final int index;

  const FetchResidents(this.index);

  @override
  List<Object> get props => [index];
}

class ToggleDetailVisibilityAndFetchResidents extends LocationsPageEvent {
  final int index;

  const ToggleDetailVisibilityAndFetchResidents(this.index);

  @override
  List<Object> get props => [index];
}
