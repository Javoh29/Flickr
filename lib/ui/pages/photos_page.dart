import 'package:flickr_app/ui/widgets/item_photo.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class PhotosPage extends StatelessWidget {
  const PhotosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        ItemPhoto(),
        ItemPhoto(),
        ItemPhoto(),
        ItemPhoto(),
      ],
    );
  }
}
