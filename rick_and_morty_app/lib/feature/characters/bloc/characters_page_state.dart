import 'package:api_veri/feature/locations/bloc/locations_page_state.dart';
import 'package:api_veri/product/utility/constants/view_status_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:api_veri/feature/characters/model/user_model.dart';

class CharactersState extends Equatable {
  final ViewStatus status;
  final List<UserModel>? users;
  final List<UserModel>? filteredUsers;
  final List<bool>? detailList;
  final List<bool>? followedUsers;
  final String? errorMessage;

  const CharactersState({
    this.status = ViewStatus.initial,
    this.users,
    this.filteredUsers,
    this.detailList,
    this.followedUsers,
    this.errorMessage,
  });

  @override
  List<Object?> get props =>
      [status, users, filteredUsers, detailList, followedUsers, errorMessage];

  CharactersState copyWith({
    ViewStatus? status,
    List<UserModel>? users,
    List<UserModel>? filteredUsers,
    List<bool>? detailList,
    List<bool>? followedUsers,
    String? errorMessage,
  }) {
    return CharactersState(
      status: status ?? this.status,
      users: users ?? this.users,
      filteredUsers: filteredUsers ?? this.filteredUsers,
      detailList: detailList ?? this.detailList,
      followedUsers: followedUsers ?? this.followedUsers,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
