import 'package:api_veri/product/database/hive_manager.dart';
import 'package:api_veri/product/utility/constants/view_status_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_veri/feature/characters/model/user_model.dart';
import 'package:api_veri/product/service/operations/user_service.dart';
import 'package:api_veri/feature/characters/bloc/characters_page_event.dart';
import 'package:api_veri/feature/characters/bloc/characters_page_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  late final UserService _service;
  late final HiveManager _hiveManager;

  CharactersBloc() : super(const CharactersState()) {
    _hiveManager = HiveManager();
    _service = UserService();
    on<FetchUsers>(_onFetchUsers);
    on<SearchUsers>(_onSearchUsers);
    on<ToggleFollowUser>(_onToggleFollowUser);
    on<ToggleDetailVisibility>(_onToggleDetailVisibility);
    on<RenameUser>(_onRenameUser);
  }

  Future<void> _onFetchUsers(
      FetchUsers event, Emitter<CharactersState> emit) async {
    emit(state.copyWith(status: ViewStatus.loading));
    try {
      List<UserModel> fetchedUsers = await _service.getUsers();
      List<bool> detailList = List<bool>.filled(fetchedUsers.length, false);
      List<bool> followedUsers = List<bool>.filled(fetchedUsers.length, false);

      List<String> followedUsersList =
          await _hiveManager.operations.getFollowedUsers();
      if (followedUsersList.isNotEmpty) {
        followedUsers = fetchedUsers
            .map((user) => followedUsersList.contains(user.id.toString()))
            .toList();
      }

      List<String> userNames = await _hiveManager.operations.getUserNames();
      if (userNames.isNotEmpty) {
        fetchedUsers.asMap().forEach((index, user) {
          fetchedUsers[index] = user.copyWith(name: userNames[index]);
        });
      }

      emit(state.copyWith(
          status: ViewStatus.loaded,
          users: fetchedUsers,
          filteredUsers: fetchedUsers,
          detailList: detailList,
          followedUsers: followedUsers));
    } catch (e) {
      emit(state.copyWith(
          status: ViewStatus.error, errorMessage: 'Error fetching users: $e'));
    }
  }

  void _onSearchUsers(SearchUsers event, Emitter<CharactersState> emit) {
    if (state.status == ViewStatus.loaded) {
      try {
        final currentState = state;
        String searchQuery = event.query.toLowerCase();
        List<UserModel> filteredUsers = currentState.users!
            .where((user) => user.name!.toLowerCase().contains(searchQuery))
            .toList();
        List<bool> detailList = List<bool>.filled(filteredUsers.length, false);

        emit(state.copyWith(
            filteredUsers: filteredUsers, detailList: detailList));
      } catch (e) {
        emit(state.copyWith(
            status: ViewStatus.error,
            errorMessage: 'Error searching users: $e'));
      }
    }
  }

  Future<void> _onToggleFollowUser(
      ToggleFollowUser event, Emitter<CharactersState> emit) async {
    if (state.status == ViewStatus.loaded) {
      try {
        final currentState = state;
        List<bool> followedUsers = List.from(currentState.followedUsers!);
        followedUsers[event.index] = !followedUsers[event.index];

        List<String> followedUsersList = currentState.users!
            .where((user) => followedUsers[currentState.users!.indexOf(user)])
            .map((user) => user.id.toString())
            .toList();

        await _hiveManager.operations.saveFollowedUsers(followedUsersList);

        emit(state.copyWith(followedUsers: followedUsers));
      } catch (e) {
        emit(state.copyWith(
            status: ViewStatus.error,
            errorMessage: 'Error toggling follow user: $e'));
      }
    }
  }

  void _onToggleDetailVisibility(
      ToggleDetailVisibility event, Emitter<CharactersState> emit) {
    if (state.status == ViewStatus.loaded) {
      try {
        final currentState = state;
        List<bool> detailList = List.from(currentState.detailList!);
        detailList[event.index] = !detailList[event.index];

        emit(state.copyWith(detailList: detailList));
      } catch (e) {
        emit(state.copyWith(
            status: ViewStatus.error,
            errorMessage: 'Error toggling detail visibility: $e'));
      }
    }
  }

  Future<void> _onRenameUser(
      RenameUser event, Emitter<CharactersState> emit) async {
    if (state.status == ViewStatus.loaded) {
      try {
        final currentState = state;
        if (event.index >= 0 && event.index < currentState.users!.length) {
          List<UserModel> updatedUsers = List.from(currentState.users!);
          updatedUsers[event.index] =
              updatedUsers[event.index].copyWith(name: event.newName);

          List<UserModel> filteredUsers =
              List.from(currentState.filteredUsers!);
          List<bool> detailList = List.from(currentState.detailList!);

          int filteredIndex = filteredUsers
              .indexWhere((user) => user.id == updatedUsers[event.index].id);
          if (filteredIndex != -1) {
            filteredUsers[filteredIndex] = updatedUsers[event.index];
            detailList[filteredIndex] = currentState.detailList![filteredIndex];
          }

          await _hiveManager.operations.saveUserNames(
              updatedUsers.map((user) => user.name ?? '').toList());

          emit(state.copyWith(
              users: updatedUsers,
              filteredUsers: filteredUsers,
              detailList: detailList));
        }
      } catch (e) {
        emit(state.copyWith(
            status: ViewStatus.error, errorMessage: 'Error renaming user: $e'));
      }
    }
  }
}
