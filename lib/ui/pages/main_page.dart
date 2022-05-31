import 'package:flickr_app/data/viewmodels/main_viewmodel.dart';
import 'package:flickr_app/ui/pages/favorites_page.dart';
import 'package:flickr_app/ui/pages/photos_page.dart';
import 'package:flickr_app/ui/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:jbaza/jbaza.dart';

import '../../utils/constants.dart';

class MainPage extends ViewModelBuilderWidget<MainViewModel> {
  MainPage({Key? key}) : super(key: key);

  final PageStorageBucket _bucket = PageStorageBucket();
  final List<Widget> pages = const <Widget>[
    PhotosPage(),
    FavoritesPage(),
    ProfilePage()
  ];

  @override
  Widget builder(BuildContext context, MainViewModel viewModel, Widget? child) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            viewModel.getTitle(),
            style: kTextStyle(
                color: Colors.white, size: 16, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: PageStorage(
          bucket: _bucket,
          child: pages[viewModel.currentTab],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: kTextStyle(color: primaryColor, size: 12),
          selectedItemColor: primaryColor,
          unselectedItemColor: textColor2,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedLabelStyle: kTextStyle(color: textColor2, size: 12),
          currentIndex: viewModel.currentTab,
          onTap: (int index) {
            viewModel.currentTab = index;
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.photo),
              label: 'Photos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ));
  }

  @override
  MainViewModel viewModelBuilder(BuildContext context) {
    return MainViewModel();
  }
}
