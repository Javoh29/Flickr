import 'package:flickr_app/utils/constants.dart';
import 'package:flickr_app/utils/locator.dart';
import 'package:flickr_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:jbaza/jbaza.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      title: 'Flickr app',
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
