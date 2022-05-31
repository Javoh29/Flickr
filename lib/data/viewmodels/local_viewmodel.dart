import 'package:jbaza/jbaza.dart';
import 'package:oauth1/oauth1.dart';

import '../../utils/constants.dart';

class LocalViewModel extends BaseViewModel {
  LocalViewModel() {
    initOauthClient();
  }
  Client? client;

  initOauthClient() {
    var platform = Platform(
        'https://www.flickr.com/services/oauth/request_token',
        'https://www.flickr.com/services/oauth/authorize',
        'https://www.flickr.com/services/oauth/access_token',
        SignatureMethods.hmacSha1);
    var clientCredentials = ClientCredentials(consumerKey, consumerSecret);
    client = Client(platform.signatureMethod, clientCredentials,
        Credentials(oauthToken, oauthTokenSecret));
  }
}
