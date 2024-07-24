import 'package:equatable/equatable.dart';

abstract class CharactersEvent extends Equatable {
  const CharactersEvent();

  @override
  List<Object> get props => [];
}

class FetchUsers extends CharactersEvent {}

class SearchUsers extends CharactersEvent {
  final String query;

  const SearchUsers(this.query);

  @override
  List<Object> get props => [query];
}

class ToggleFollowUser extends CharactersEvent {
  final int index;

  const ToggleFollowUser(this.index);

  @override
  List<Object> get props => [index];
}

class ToggleDetailVisibility extends CharactersEvent {
  final int index;

  const ToggleDetailVisibility(this.index);

  @override
  List<Object> get props => [index];
}

class RenameUser extends CharactersEvent {
  final int index;
  final String newName;

  const RenameUser(this.index, this.newName);

  @override
  List<Object> get props => [index, newName];
}
