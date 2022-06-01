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
        setError(
            VMException(data['message'] ?? 'Unknown error',
                callFuncName: 'getUserData', line: '1', response: response),
            tag: tag,
            isShowInfo: true);
      }
    } on SocketException {
      setError(VMException(errInet, callFuncName: 'getUserData', line: '2'),
          tag: tag, isShowInfo: true);
    } catch (e) {
      setError(
          VMException(e.toString(), callFuncName: 'getUserData', line: '3'),
          tag: tag,
          isShowInfo: true);
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
}
