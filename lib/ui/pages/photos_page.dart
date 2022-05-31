import 'package:flickr_app/ui/widgets/item_photo.dart';
import 'package:flutter/material.dart';

class PhotosPage extends StatelessWidget {
  const PhotosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ItemPhoto(),
        ItemPhoto(),
        ItemPhoto(),
        ItemPhoto(),
      ],
    );
  }
}
