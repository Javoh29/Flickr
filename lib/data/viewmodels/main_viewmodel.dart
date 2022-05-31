import 'package:flickr_app/utils/url.dart';
import 'package:jbaza/jbaza.dart';
import 'package:oauth1/oauth1.dart';


class MainViewModel extends BaseViewModel {
  int _currentTab = 0;
  Client? client;

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

  Future getPhotos() async {
    var response = await client?.get(Url.getUrl('flickr.photos.getRecent'));
    if (response?.statusCode == 200) {}
  }
}
