import 'package:flickr_app/data/viewmodels/local_viewmodel.dart';
import 'package:flickr_app/data/viewmodels/photos_viewmodel.dart';
import 'package:flickr_app/ui/widgets/item_photo.dart';
import 'package:flickr_app/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:jbaza/jbaza.dart';

import '../../utils/constants.dart';

class PhotosPage extends ViewModelBuilderWidget<PhotosViewModel> {
  PhotosPage({Key? key}) : super(key: key);
  final ScrollController _scrollController = ScrollController();
  final String moreLoadTag = 'more_load';
  final String newLoadTag = 'new_load';
  final String searchTag = 'search_photo';
  String _searchText = '';

  @override
  void onViewModelReady(PhotosViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.getPhotos(searchTag);
    _setScrollListenerForMorePhotos(viewModel);
  }

  void _setScrollListenerForMorePhotos(PhotosViewModel viewModel) {
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
  Widget builder(
      BuildContext context, PhotosViewModel viewModel, Widget? child) {
    int listLength = viewModel.listPhotos.length;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: viewModel.isSearchView
            ? TextField(
                style: kTextStyle(color: Colors.white),
                maxLines: 1,
                decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    isDense: true,
                    hintText: 'Search',
                    hintStyle: kTextStyle(color: Colors.white70)),
                onSubmitted: (value) {
                  if (value.length > 3) {
                    viewModel.getPhotos(searchTag,
                        search: value, isClear: true);
                  }
                },
                onChanged: (value) {
                  if (value != _searchText) {
                    _searchText = value;
                    if (value.length > 3) {
                      viewModel.getPhotos(searchTag,
                          search: value, isClear: true);
                    } else if (value.isEmpty) {
                      viewModel.getPhotos(searchTag, isClear: true);
                    }
                  }
                },
              )
            : Text(
                'Photos',
                style: kTextStyle(
                    color: Colors.white, size: 18, fontWeight: FontWeight.w600),
              ),
        actions: [
          IconButton(
              onPressed: () {
                if (viewModel.isSearchView) {
                  viewModel.getPhotos(searchTag, isClear: true);
                }
                viewModel.setSearchView(!viewModel.isSearchView);
              },
              icon: Icon(viewModel.isSearchView ? Icons.close : Icons.search,
                  color: Colors.white))
        ],
      ),
      body: viewModel.isBusy(tag: searchTag)
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
                              viewModel.listPhotos.elementAt(index), viewModel);
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
  PhotosViewModel viewModelBuilder(BuildContext context) {
    return PhotosViewModel(locator<LocalViewModel>().client!, context);
  }
}
