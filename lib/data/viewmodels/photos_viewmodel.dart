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
  final Client _client;
  Set<PhotoModel> listPhotos = {};
  bool isSearchView = false;
  int totalPages = 1;
  int currentPage = 0;

  Future getPhotos(String tag,
      {String? search, int? page, bool isClear = false}) async {
    setBusy(true, tag: tag);
    try {
      var response = await _client.get(Url.getUrl(
          search != null ? 'flickr.photos.search' : 'flickr.photos.getRecent',
          query:
              '&per_page=15&page=${page ?? 1}${search != null ? '&text=$search' : ''}'));
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        totalPages = data['photos']['pages'];
        currentPage = data['photos']['page'];
        if (isClear) listPhotos.clear();
        for (final item in data['photos']['photo']) {
          listPhotos.add(PhotoModel.fromJson(item));
        }
        setSuccess(tag: tag);
      } else {
        setError(
            VMException(data['message'] ?? 'Unknown error',
                callFuncName: 'getPhotos', line: '1', response: response),
            tag: tag,
            isShowInfo: true);
      }
    } on SocketException {
      setError(VMException(errInet, callFuncName: 'getPhotos', line: '2'),
          tag: tag, isShowInfo: true);
    } catch (e) {
      setError(VMException(e.toString(), callFuncName: 'getPhotos', line: '3'),
          tag: tag, isShowInfo: true);
    }
  }

  Future setFavorite(String id) async {
    setBusy(true, tag: id);
    try {
      var response = await _client
          .post(Url.getUrl('flickr.favorites.add', query: '&photo_id=$id'));
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var e in listPhotos) {
          if (e.id == id) {
            e.isFav = true;
          }
        }
        setSuccess(tag: id);
      } else {
        setError(
            VMException(data['message'] ?? 'Unknown error',
                callFuncName: 'setFavorite', line: '1', response: response),
            tag: id,
            isShowInfo: true);
      }
    } on SocketException {
      setError(VMException(errInet, callFuncName: 'setFavorite', line: '2'),
          tag: id, isShowInfo: true);
    } catch (e) {
      setError(
          VMException(e.toString(), callFuncName: 'setFavorite', line: '3'),
          tag: id,
          isShowInfo: true);
    }
  }

  setSearchView(bool value) {
    isSearchView = value;
    notifyListeners();
  }
}
