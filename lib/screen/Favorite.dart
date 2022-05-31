import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../main.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite list"),
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box(favorites_box).listenable(),
          builder: (context, Box box, child) {
            List names = List.from(box.values);
            print(names);
            

            return ListView(children: [
              ...names.map(
                (e) => ListTile(
                  title: Text(
                    "${e["name"]}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(e["description"] == null ? "" : e["description"]),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Text(
                                e["language"] == null ? "" : e["language"]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(e["watchers_count"] == null
                                ? ""
                                : e["watchers_count"].toString()),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                                e["size"] == null ? "" : e["size"].toString()),
                          )
                        ],
                      ),
                    ],
                  ),
                  leading: CachedNetworkImage(
                    imageBuilder: (context, imageProvider) => Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(
                              0xFF139ea1), //                   <--- border color
                          width: 2.0,
                        ),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    imageUrl: e["owner"]["avatar_url"],
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        box.delete(e["id"]);
                      },
                      icon: Icon(Icons.delete)),
                ),
              )
            ]);
          }),
    );
  }
}
