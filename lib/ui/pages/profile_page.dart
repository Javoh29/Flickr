import 'package:flickr_app/data/viewmodels/local_viewmodel.dart';
import 'package:flickr_app/data/viewmodels/profile_viewmodel.dart';
import 'package:flickr_app/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:jbaza/jbaza.dart';

import '../../utils/constants.dart';
import '../widgets/item_photo.dart';

class ProfilePage extends ViewModelBuilderWidget<ProfileViewModel> {
  ProfilePage({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();
  final String moreLoadTag = 'more_load';
  final String initLoadTag = 'init_load';

  @override
  void onViewModelReady(ProfileViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.getUserData(initLoadTag);
    _setScrollListenerForMorePhotos(viewModel);
  }

  void _setScrollListenerForMorePhotos(ProfileViewModel viewModel) {
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
      BuildContext context, ProfileViewModel viewModel, Widget? child) {
    var listLength = viewModel.listPhotos.length;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Profile',
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
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 20),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'assets/img_user.png',
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                ),
                Text(
                  '${viewModel.userModel?.firstName} ${viewModel.userModel?.lastName}',
                  style: kTextStyle(size: 18, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  child: Text(
                    viewModel.userModel?.email ?? '',
                    style: kTextStyle(
                        size: 18,
                        fontWeight: FontWeight.w600,
                        color: textColor2),
                  ),
                ),
                const Divider(color: textColor2, indent: 15, endIndent: 15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'My photos',
                      style: kTextStyle(
                          size: 16,
                          fontWeight: FontWeight.w600,
                          color: textColor1),
                    ),
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shrinkWrap: true,
                    controller: _scrollController,
                    itemBuilder: ((context, index) {
                      if (index != listLength) {
                        return ItemPhoto(
                          viewModel.listPhotos.elementAt(index),
                          viewModel,
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
              ],
            ),
    );
  }

  @override
  ProfileViewModel viewModelBuilder(BuildContext context) {
    return ProfileViewModel(locator<LocalViewModel>().client!, context);
  }
}
