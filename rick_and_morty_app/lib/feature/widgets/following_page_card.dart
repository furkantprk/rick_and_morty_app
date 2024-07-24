import 'package:api_veri/product/utility/constants/icon_constants.dart';
import 'package:api_veri/product/utility/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:api_veri/product/utility/constants/color_constants.dart';

import 'package:api_veri/feature/characters/model/user_model.dart';

class FollowingPageCard extends StatelessWidget {
  final UserModel user;
  final TextEditingController renameController;
  final VoidCallback onRename;

  const FollowingPageCard({
    Key? key,
    required this.user,
    required this.renameController,
    required this.onRename,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    return Card(
      elevation: 40,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
      ),
      color: AppColor.card,
      child: ListTile(
        title: Text(user.name ?? ''),
        subtitle: Text(
            '${user.status ?? ''} ${user.species ?? ''} ${user.gender ?? ''}'),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.image ?? ''),
        ),
        trailing: PopupMenuButton(
          child: AppIcons.rename,
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text(AppString.renameText),
              value: 1,
            ),
          ],
          onSelected: (menuItem) {
            if (menuItem == 1) {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                        height: screenHeight / 3,
                        color: AppColor.scaffoldBackGround,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextField(
                                controller: renameController,
                                decoration: InputDecoration(
                                  hintText: AppString.renameHintText,
                                ),
                              ),
                              ElevatedButton(
                                child: Text(AppString.renameText),
                                onPressed: onRename,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
