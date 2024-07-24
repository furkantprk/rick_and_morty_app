import 'package:api_veri/product/router/router.dart';
import 'package:flutter/cupertino.dart';

class HomePageViewModel extends ChangeNotifier {
  int currentIndex = 0;

  void indexChange(int index) {
    currentIndex = index;
    switch (index) {
      case 0:
        goRouter.go('/home');
        break;
      case 1:
        goRouter.go('/locations');
        break;
      case 2:
        goRouter.go('/following');
        break;
    }
    notifyListeners();
  }
}
