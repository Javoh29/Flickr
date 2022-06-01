import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jbaza/jbaza.dart';
import 'package:oauth1/oauth1.dart';

import '../../utils/constants.dart';
import '../../utils/url.dart';
import '../models/photo_model.dart';

class FavViewModel extends BaseViewModel {
  FavViewModel(this._client, BuildContext context) : super(context: context);
  final Client _client;
  Set<PhotoModel> listPhotos = {};
  int totalPages = 1;
  int currentPage = 0;

  Future getPhotos(String tag, {int? page, bool isClear = false}) async {
    setBusy(true, tag: tag);
    try {
      var response = await _client.get(Url.getUrl('flickr.favorites.getList',
          query: '&per_page=15&page=${page ?? 1}'));
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

  Future removeFavorite(String id) async {
    setBusy(true, tag: id);
    try {
      var response = await _client
          .post(Url.getUrl('flickr.favorites.remove', query: '&photo_id=$id'));
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var e in listPhotos) {
          if (e.id == id) {
            listPhotos.remove(e);
            break;
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
}
