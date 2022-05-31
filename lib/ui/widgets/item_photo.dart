import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemPhoto extends StatelessWidget {
  const ItemPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 10)
            ]),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: "http://via.placeholder.com/350x150",
              placeholder: (context, url) => const Align(
                alignment: Alignment.center,
                child: SizedBox(
                    height: 30, width: 30, child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error, color: Colors.red),
              height: 200,
              fit: BoxFit.cover,
            ),
            Container(
              height: 80,
              width: double.infinity,
              color: Color(0xfff3f5f7),
              child: Row(children: [
                Text('ASDASDADSASD ASDSADAS'),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite,
                    ))
              ]),
            )
          ],
        ),
      ),
    );
  }
}
