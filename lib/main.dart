import 'package:flickr_app/ui/pages/main_page.dart';
import 'package:flickr_app/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:jbaza/jbaza.dart';

void main() {
  setupConfigs(() async {
    setupLocator();
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}
