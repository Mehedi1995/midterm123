import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

import 'Book.dart';
import 'DetailScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List bookList;
  double screenHeight, screenWidth;
  String titlecenter = "Loading Book...";

  @override
  void initState() {
    super.initState();
    _loadRestaurant();
  }

  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('MainScreen'),
      ),
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: [
          bookList == null
              ? Flexible(
                  child: Container(
                      child: Center(
                          child: Text(
                  titlecenter,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ))))
              : Flexible(
                  child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: (screenWidth / screenHeight) / 1.5,
                  children: List.generate(bookList.length, (index) {
                    return Padding(
                        padding: EdgeInsets.all(1),
                        child: Card(
                          child: InkWell(
                            onTap: () => _loadBookDetail(index),
                            child: Column(
                              children: [
                                Container(
                                    height: screenHeight / 3,
                                    width: screenWidth / 1,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "http://slumberjer.com/bookdepo/bookcover/${bookList[index]['cover']}.jpg",
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          new CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          new Icon(
                                        Icons.broken_image,
                                        size: screenWidth / 2,
                                      ),
                                    )),
                                SizedBox(height: 5),
                                Text(
                                  bookList[index]['booktitle'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  bookList[index]['booktitle'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  bookList[index]['author'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  bookList[index]['price'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  bookList[index]['rating'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ));
                  }),
                ))
        ],
      ),
    );
  }

  void _loadRestaurant() {
    http.post("http://slumberjer.com/bookdepo/php/load_books.php",
        body: {}).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        bookList = null;
        setState(() {
          titlecenter = "No Book Found";
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          bookList = jsondata["books"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  _loadBookDetail(int index) {
    print(bookList[index]['restname']);
    Book book1 = new Book(
      bookid: bookList[index]['bookid'],
      booktitle: bookList[index]['booktitle'],
      author: bookList[index]['author'],
      price: bookList[index]['price'],
      description: bookList[index]['description'],
      rating: bookList[index]['rating'],
      publisher: bookList[index]['publisher'],
      isbn: bookList[index]['isbn'],
      cover: bookList[index]['cover'],
    );
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => DetailScreen(book: book1)));
  }
}
