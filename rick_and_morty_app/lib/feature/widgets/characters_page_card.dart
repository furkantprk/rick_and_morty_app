import 'package:flutter/material.dart';
import 'package:api_veri/feature/characters/model/user_model.dart';
import 'package:api_veri/product/utility/constants/color_constants.dart';
import 'package:api_veri/product/utility/constants/icon_constants.dart';

class CharactersPageCard extends StatelessWidget {
  final UserModel user;
  final bool isFollowed;
  final bool showDetails;
  final VoidCallback onToggleDetail;
  final VoidCallback onToggleFollow;

  const CharactersPageCard({
    Key? key,
    required this.user,
    required this.isFollowed,
    required this.showDetails,
    required this.onToggleDetail,
    required this.onToggleFollow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 40,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
      ),
      color: AppColor.card,
      child: ListTile(
        title: TextButton(
          onPressed: onToggleDetail,
          child: Text(
            '${user.id ?? ''} ${user.name ?? ''}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.white,
            ),
          ),
        ),
        subtitle: Visibility(
          visible: showDetails,
          child: Text(
              "${user.status ?? ''} ${user.species ?? ''} ${user.gender ?? ''}"),
        ),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.image ?? ''),
        ),
        trailing: IconButton(
          icon: isFollowed ? AppIcons.followed : AppIcons.unfollowed,
          onPressed: onToggleFollow,
        ),
      ),
    );
  }
}
