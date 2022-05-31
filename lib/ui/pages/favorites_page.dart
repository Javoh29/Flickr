import 'package:flickr_app/data/viewmodels/fav_viewmodel.dart';
import 'package:flickr_app/data/viewmodels/local_viewmodel.dart';
import 'package:flickr_app/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:jbaza/jbaza.dart';

import '../../utils/constants.dart';
import '../widgets/item_photo.dart';

class FavoritesPage extends ViewModelBuilderWidget<FavViewModel> {
  FavoritesPage({Key? key}) : super(key: key);
  final ScrollController _scrollController = ScrollController();
  final String moreLoadTag = 'more_load';
  final String newLoadTag = 'new_load';
  final String initLoadTag = 'init_load';

  @override
  void onViewModelReady(FavViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.getPhotos(initLoadTag);
    _setScrollListenerForMorePhotos(viewModel);
  }

  void _setScrollListenerForMorePhotos(FavViewModel viewModel) {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection.index ==
              AxisDirection.down.index &&
          _scrollController.position.maxScrollExtent -
                  _scrollController.offset ==
              0.0) {
        if (!viewModel.isBusy()) {
          int page = viewModel.currentPage + 1;
          if (viewModel.totalPages >= page) {
            viewModel.getPhotos(moreLoadTag, page: page);
          }
        }
      }
    });
  }

  @override
  Widget builder(BuildContext context, FavViewModel viewModel, Widget? child) {
    int listLength = viewModel.listPhotos.length;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Favorites',
          style: kTextStyle(
              color: Colors.white, size: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: viewModel.isBusy(tag: initLoadTag)
          ? const Center(
              child: CircularProgressIndicator(
              strokeWidth: 2,
            ))
          : Column(
              children: [
                Flexible(
                  child: RefreshIndicator(
                    onRefresh: () =>
                        viewModel.getPhotos(newLoadTag, isClear: true),
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemBuilder: ((context, index) {
                        if (index != listLength) {
                          return ItemPhoto(
                            viewModel.listPhotos.elementAt(index),
                            viewModel,
                            isFavorite: true,
                          );
                        } else {
                          if (viewModel.isBusy(tag: moreLoadTag)) {
                            return const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        }
                      }),
                      itemCount: viewModel.listPhotos.length + 1,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  @override
  FavViewModel viewModelBuilder(BuildContext context) {
    return FavViewModel(locator<LocalViewModel>().client!, context);
  }
}
