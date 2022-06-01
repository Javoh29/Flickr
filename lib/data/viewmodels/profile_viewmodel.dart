import 'dart:convert';
import 'dart:io';

import 'package:flickr_app/data/models/user_model.dart';
import 'package:flickr_app/utils/url.dart';
import 'package:flutter/material.dart';
import 'package:jbaza/jbaza.dart';
import 'package:oauth1/oauth1.dart';

import '../../utils/constants.dart';
import '../models/photo_model.dart';

class ProfileViewModel extends BaseViewModel {
  ProfileViewModel(this._client, BuildContext context)
      : super(context: context);
  final Client _client;
  UserModel? userModel;
  Set<PhotoModel> listPhotos = {};
  int totalPages = 1;
  int currentPage = 0;

  Future getUserData(String tag) async {
    setBusy(true, tag: tag);
    try {
      var response = await _client.get(Url.getUrl('flickr.profile.getProfile',
          query: '&user_id=195739708@N06'));
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        userModel = UserModel.fromJson(data['profile']);
        await getPhotos(tag);
      } else {
        var model = VMException(data['message'] ?? 'Unknown error',
            callFuncName: 'getUserData', line: '1', response: response);
        setError(model, tag: tag);
        shwoInfo(model.message);
      }
    } on SocketException {
      var model = VMException(errInet, callFuncName: 'getUserData', line: '2');
      setError(model, tag: tag);
      shwoInfo(model.message);
    } catch (e) {
      var model =
          VMException(e.toString(), callFuncName: 'getUserData', line: '3');
      setError(model, tag: tag);
      shwoInfo(model.message);
    }
  }

  Future getPhotos(String tag, {int? page, bool isClear = false}) async {
    setBusy(true, tag: tag);
    try {
      var response = await _client.get(Url.getUrl('flickr.photos.getPopular',
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
        var model = VMException(data['message'] ?? 'Unknown error',
            callFuncName: 'getPhotos', line: '1', response: response);
        setError(model, tag: tag);
        shwoInfo(model.message);
      }
    } on SocketException {
      var model = VMException(errInet, callFuncName: 'getPhotos', line: '2');
      setError(model, tag: tag);
      shwoInfo(model.message);
    } catch (e) {
      var model =
          VMException(e.toString(), callFuncName: 'getPhotos', line: '3');
      setError(model, tag: tag);
      shwoInfo(model.message);
    }
  }
}
