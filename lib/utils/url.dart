import 'package:flickr_app/data/models/photo_model.dart';

class Url {
  static Uri getUrl(String method, {String query = ''}) => Uri.parse(
      "https://www.flickr.com/services/rest/?method=$method&format=json&nojsoncallback=1$query");
  static String getImgUrl(String path, {bool isOrig = false}) =>
      'https://live.staticflickr.com/${path}_${isOrig ? 'b' : 'm'}.jpg';
}
