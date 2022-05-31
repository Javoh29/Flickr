class Url {
  static Uri getUrl(String method) => Uri.parse(
      "https://www.flickr.com/services/rest/?method=$method&format=json&nojsoncallback=1");
}
