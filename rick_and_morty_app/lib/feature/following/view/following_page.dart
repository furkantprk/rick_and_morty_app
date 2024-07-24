import 'package:api_veri/feature/locations/bloc/locations_page_state.dart';
import 'package:api_veri/product/utility/constants/view_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_veri/feature/characters/bloc/characters_page_bloc.dart';
import 'package:api_veri/feature/characters/bloc/characters_page_event.dart';
import 'package:api_veri/feature/characters/bloc/characters_page_state.dart';
import 'package:api_veri/feature/widgets/following_page_card.dart';
import 'package:api_veri/product/router/router.dart';
import 'package:api_veri/product/utility/constants/color_constants.dart';
import 'package:api_veri/product/utility/constants/string_constants.dart';

class FollowingPage extends StatefulWidget {
  const FollowingPage({Key? key}) : super(key: key);

  @override
  State<FollowingPage> createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  final TextEditingController renameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackGround,
      appBar: AppBar(
        title: Text(AppString.followingPageTitle),
      ),
      body: BlocBuilder<CharactersBloc, CharactersState>(
        builder: (context, state) {
          if (state.status == ViewStatus.initial) {
            return Center(child: Text(AppString.plsWaitText));
          } else if (state.status == ViewStatus.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.status == ViewStatus.loaded) {
            final followedUsers = state.users!
                .where(
                    (user) => state.followedUsers![state.users!.indexOf(user)])
                .toList();

            if (followedUsers.isEmpty) {
              return Center(child: Text(AppString.noFollowedCharactersText));
            }

            return ListView.builder(
              itemCount: followedUsers.length,
              itemBuilder: (context, index) {
                final user = followedUsers[index];
                return FollowingPageCard(
                  user: user,
                  renameController: renameController,
                  onRename: () {
                    if (renameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(AppString.followingPageSnackBarText)),
                      );
                    } else {
                      context.read<CharactersBloc>().add(
                            RenameUser(
                              state.users!.indexOf(user),
                              renameController.text,
                            ),
                          );
                      goRouter.pop(context);
                    }
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
