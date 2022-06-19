import 'package:flutter/material.dart';

class PageThree extends StatelessWidget {
  const PageThree({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: Navigator.of(context).pop,
      ),
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                title: Hero(
                  child: Material(
                    child: Text(
                      "Item widget $index",
                    ),
                    type: MaterialType.transparency,
                  ),
                  tag: "title_$index",
                ),
              ),
            ),
            Positioned.fill(
              top: kToolbarHeight,
              child: Hero(
                  tag: 'image_$index',
                  child: SizedBox.expand(
                    child: Image.network(
                      "https://picsum.photos/200/300?random=$index",
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
