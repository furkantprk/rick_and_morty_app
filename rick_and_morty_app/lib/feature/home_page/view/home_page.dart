import 'package:api_veri/product/utility/constants/color_constants.dart';
import 'package:api_veri/product/utility/constants/icon_constants.dart';
import 'package:api_veri/product/utility/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:api_veri/feature/home_page/view_model/home_page_view_model.dart';

class HomePage extends StatefulWidget {
  final Widget child;
  const HomePage({required this.child, Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          Consumer<HomePageViewModel>(builder: (context, viewModel, child) {
        return BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: AppIcons.characters,
              label: AppString.charactersLabel,
            ),
            BottomNavigationBarItem(
              icon: AppIcons.locations,
              label: AppString.locationsLabel,
            ),
            BottomNavigationBarItem(
              icon: AppIcons.following,
              label: AppString.followingLabel,
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: viewModel.currentIndex,
          onTap: (index) {
            viewModel.indexChange(index);
          },
          backgroundColor: AppColor.scaffoldBackGround,
          selectedItemColor: AppColor.main,
        );
      }),
      body: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => widget.child,
          );
        },
      ),
    );
  }
}
