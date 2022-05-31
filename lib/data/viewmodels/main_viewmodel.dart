import 'package:jbaza/jbaza.dart';

class MainViewModel extends BaseViewModel {
  int _currentTab = 0;

  int get currentTab => _currentTab;

  set currentTab(int value) {
    _currentTab = value;
    notifyListeners();
  }

  String getTitle() {
    switch (_currentTab) {
      case 1:
        return 'Profile';
      case 2:
        return 'Favorites';
      default:
        return 'Photos';
    }
  }
}
