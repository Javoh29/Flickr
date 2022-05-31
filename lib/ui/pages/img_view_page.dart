import 'package:cached_network_image/cached_network_image.dart';
import 'package:flickr_app/data/models/photo_model.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

import '../../utils/constants.dart';
import '../../utils/url.dart';

class ImgViewPage extends StatelessWidget {
  ImgViewPage(this.model, {Key? key}) : super(key: key);
  PhotoModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          model.title ?? '',
          style: kTextStyle(
              color: Colors.white, size: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: PinchZoom(
        resetDuration: const Duration(milliseconds: 100),
        maxScale: 2.5,
        child: CachedNetworkImage(
          imageUrl: Url.getImgUrl(model.imgPath, isOrig: true),
          placeholder: (context, url) => const Align(
            alignment: Alignment.center,
            child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                )),
          ),
          errorWidget: (context, url, error) =>
              const Icon(Icons.error, color: Colors.red),
          width: double.infinity,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
