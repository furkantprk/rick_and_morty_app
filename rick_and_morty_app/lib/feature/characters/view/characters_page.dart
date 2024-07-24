import 'package:api_veri/feature/locations/bloc/locations_page_state.dart';
import 'package:api_veri/product/utility/constants/view_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_veri/feature/characters/bloc/characters_page_bloc.dart';
import 'package:api_veri/feature/characters/bloc/characters_page_event.dart';
import 'package:api_veri/feature/characters/bloc/characters_page_state.dart';
import 'package:api_veri/feature/widgets/characters_page_card.dart';
import 'package:api_veri/product/utility/constants/color_constants.dart';
import 'package:api_veri/product/utility/constants/icon_constants.dart';
import 'package:api_veri/product/utility/constants/string_constants.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackGround,
      appBar: AppBar(
          title: TextField(
        onChanged: (query) {
          context.read<CharactersBloc>().add(SearchUsers(query));
        },
        decoration: InputDecoration(
          icon: AppIcons.search,
          iconColor: AppColor.white,
          hintText: AppString.searchHintText,
          hintStyle: TextStyle(color: AppColor.white),
        ),
        style: TextStyle(color: AppColor.white),
      )),
      body: BlocBuilder<CharactersBloc, CharactersState>(
        builder: (context, state) {
          if (state.status == ViewStatus.initial) {
            context.read<CharactersBloc>().add(FetchUsers());
            return Center(child: Text(AppString.plsWaitText));
          } else if (state.status == ViewStatus.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.status == ViewStatus.loaded) {
            return ListView.builder(
              itemCount: state.filteredUsers!.length,
              itemBuilder: (context, index) {
                final user = state.filteredUsers![index];
                return CharactersPageCard(
                  user: user,
                  isFollowed: state.followedUsers![state.users!.indexOf(user)],
                  showDetails: state.detailList![index],
                  onToggleDetail: () {
                    context
                        .read<CharactersBloc>()
                        .add(ToggleDetailVisibility(index));
                  },
                  onToggleFollow: () {
                    context
                        .read<CharactersBloc>()
                        .add(ToggleFollowUser(state.users!.indexOf(user)));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.followedUsers![state.users!.indexOf(user)]
                              ? AppString.unfollowedText
                              : AppString.followedText,
                        ),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state.status == ViewStatus.error) {
            return Center(child: Text(state.errorMessage!));
          } else {
            return Center(child: Text(AppString.unknownStateText));
          }
        },
      ),
    );
  }
}
