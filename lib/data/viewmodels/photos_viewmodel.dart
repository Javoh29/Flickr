import 'dart:convert';
import 'dart:io';

import 'package:flickr_app/data/models/photo_model.dart';
import 'package:flickr_app/utils/constants.dart';
import 'package:flickr_app/utils/url.dart';
import 'package:flutter/material.dart';
import 'package:jbaza/jbaza.dart';
import 'package:oauth1/oauth1.dart';

class PhotosViewModel extends BaseViewModel {
  PhotosViewModel(this._client, BuildContext context) : super(context: context);
  Client _client;
  List<PhotoModel> listPhotos = [];

  Future getPhotos() async {
    setBusy(true);
    try {
      var response = await _client.get(Url.getUrl('flickr.photos.getRecent'));
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        listPhotos = [
          for (final item in data['photos']['photo']) PhotoModel.fromJson(item)
        ];
        setSuccess();
      } else {
        var model = VMException(data['message'] ?? 'Unknown error',
            callFuncName: 'getPhotos', line: '1', response: response);
        setError(model);
        shwoInfo(model.message);
      }
    } on SocketException {
      var model = VMException(errInet, callFuncName: 'getPhotos', line: '2');
      setError(model);
      shwoInfo(model.message);
    } catch (e) {
      var model =
          VMException(e.toString(), callFuncName: 'getPhotos', line: '3');
      setError(model);
      shwoInfo(model.message);
    }
  }
}
