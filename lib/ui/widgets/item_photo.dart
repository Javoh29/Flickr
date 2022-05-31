import 'package:cached_network_image/cached_network_image.dart';
import 'package:flickr_app/data/models/photo_model.dart';
import 'package:flickr_app/data/viewmodels/fav_viewmodel.dart';
import 'package:flickr_app/data/viewmodels/photos_viewmodel.dart';
import 'package:flickr_app/utils/constants.dart';
import 'package:flickr_app/utils/routes.dart';
import 'package:flickr_app/utils/url.dart';
import 'package:flutter/material.dart';

class ItemPhoto extends StatelessWidget {
  ItemPhoto(this.model, this.viewModel, {this.isFavorite = false, Key? key})
      : super(key: key);
  PhotoModel model;
  dynamic viewModel;
  bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)]),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, Routes.imgViewPage,
                arguments: {"model": model}),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: CachedNetworkImage(
                imageUrl: Url.getImgUrl(model.imgPath),
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
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Text(
                    model.title ?? 'Unknown name',
                    style: kTextStyle(
                        color: textColor1,
                        size: 15,
                        fontWeight: FontWeight.w500),
                  )),
                  Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    child: viewModel.isBusy(tag: model.id!)
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              if (viewModel is PhotosViewModel) {
                                viewModel.setFavorite(model.id!);
                              } else if (viewModel is FavViewModel) {
                                viewModel.removeFavorite(model.id);
                              }
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: model.isFav || isFavorite
                                  ? Colors.redAccent
                                  : textColor3,
                            )),
                  )
                ]),
          )
        ],
      ),
    );
  }
}
