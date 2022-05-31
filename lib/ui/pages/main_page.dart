import 'package:flickr_app/ui/pages/favorites_page.dart';
import 'package:flickr_app/ui/pages/photos_page.dart';
import 'package:flickr_app/ui/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/constants.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageStorageBucket _bucket = PageStorageBucket();
  int currentTab = 0;

  final List<Widget> pages = <Widget>[
    PhotosPage(),
    FavoritesPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: primaryColor,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
        body: PageStorage(
          bucket: _bucket,
          child: pages[currentTab],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: kTextStyle(color: primaryColor, size: 12),
          selectedItemColor: primaryColor,
          unselectedItemColor: textColor2,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedLabelStyle: kTextStyle(color: textColor2, size: 12),
          currentIndex: currentTab,
          onTap: (int index) {
            setState(() {
              currentTab = index;
            });
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
}
