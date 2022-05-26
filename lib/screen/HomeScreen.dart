import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int per_page = 15;
  int _page = 1;
  ScrollController _scrollController = new ScrollController();
  bool isLoading = false;
  List names = [];
  List tempList = [];
  bool isInternetAvailable = false;

  final dio = new Dio();
  void _getMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      print("dio $_page");

      final response = await dio.get(
          "https://api.github.com/users/JakeWharton/repos?page=$_page&per_page=$per_page");
      print(response.data);
      print("redd ${response.data.length}");
      if (response.data.length == 0) {
        Fluttertoast.showToast(msg: "No more data available");
        setState(() {
          isLoading = false;
        });
      } else {
        for (int i = 0; i < response.data.length; i++) {
          tempList.add(response.data[i]);

          print(tempList);
          print("object");
        }

        setState(() {
          isLoading = false;
          names.addAll(tempList);
        });
      }
    }
  }

  Future<bool> checkConnection() async {
    ConnectivityResult connectivityResult =
        await (new Connectivity().checkConnectivity());

    debugPrint(connectivityResult.toString());

    if ((connectivityResult == ConnectivityResult.mobile) ||
        (connectivityResult == ConnectivityResult.wifi)) {
      print("internet available");
      setState(() {
        isInternetAvailable = false;
      });

      return true;
    } else {
      setState(() {
        isInternetAvailable = true;
      });
      Fluttertoast.showToast(msg: "No internet available");
      return false;
    }
  }

  @override
  void initState() {
    checkConnection();
    this._getMoreData();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          tempList.clear();
          _page = _page + 1;
          _getMoreData();
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      //+1 for progressbar
      itemCount: names.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == names.length) {
          print("name l ${names.length}");
          return _buildProgressIndicator();
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  "${names[index]["name"]}",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(names[index]["description"] == null
                        ? ""
                        : names[index]["description"]),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Text(names[index]["language"] == null
                              ? ""
                              : names[index]["language"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(names[index]["watchers_count"] == null
                              ? ""
                              : names[index]["watchers_count"].toString()),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(names[index]["size"] == null
                              ? ""
                              : names[index]["size"].toString()),
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
                  imageUrl: names[index]["owner"]["avatar_url"] == null
                      ? "https://firebasestorage.googleapis.com/v0/b/immunomate.appspot.com/o/download.png?alt=media&token=0065121f-7048-439f-a4c4-c7fe1f3ab388"
                      : names[index]["owner"]["avatar_url"],
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Divider(
                thickness: 2,
              )
            ],
          );
        }
      },
      controller: _scrollController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return isInternetAvailable == false
        ? Scaffold(
            appBar: AppBar(
              title: Text("Jakes's Git"),
              elevation: 0.0, // no shade
              backgroundColor: Color(0xff5e615f),
              textTheme: TextTheme(
                  headline6: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
            body: Container(
              child: _buildList(),
            ),
          )
        : Center(
            child: Image.asset(
              'assets/internet.jpg',
              height: MediaQuery.of(context).size.height * 0.5,
            ),
          );
  }
}