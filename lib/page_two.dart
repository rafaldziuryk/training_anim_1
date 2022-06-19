import 'package:anim_1/page_three.dart';
import 'package:flutter/material.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PageThree(index: index),
          )),
          title: Text(index.toString()),
          subtitle: Hero(
            child: Material(
              child: Text("Item widget $index"),
              type: MaterialType.transparency,
            ),
            tag: "title_$index",
          ),
          trailing: Hero(
            tag: 'image_$index',
            child: Image.network(
              "https://picsum.photos/200/300?random=$index",
            ),
          ),
        ),
      ),
    );
  }
}
