import 'package:flickr_app/data/viewmodels/local_viewmodel.dart';
import 'package:flickr_app/data/viewmodels/photos_viewmodel.dart';
import 'package:flickr_app/ui/widgets/item_photo.dart';
import 'package:flickr_app/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:jbaza/jbaza.dart';

import '../../utils/constants.dart';

class PhotosPage extends ViewModelBuilderWidget<PhotosViewModel> {
  PhotosPage({Key? key}) : super(key: key);

  @override
  void onViewModelReady(PhotosViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.getPhotos();
  }

  @override
  Widget builder(
      BuildContext context, PhotosViewModel viewModel, Widget? child) {
    return ListView(
      children: [
        AppBar(
          backgroundColor: primaryColor,
          title: Text(
            'Photos',
            style: kTextStyle(
                color: Colors.white, size: 16, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        ...viewModel.listPhotos.map(((e) => ItemPhoto())).toList()
      ],
    );
  }

  @override
  PhotosViewModel viewModelBuilder(BuildContext context) {
    return PhotosViewModel(locator<LocalViewModel>().client!, context);
  }
}
