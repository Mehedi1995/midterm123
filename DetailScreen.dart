import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Book.dart';

class DetailScreen extends StatefulWidget {
  final Book book;

  const DetailScreen({Key key, this.book}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  


  GlobalKey<RefreshIndicatorState> refreshKey;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('DetailScreen'),
      ),
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Container(
            child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.book.bookid,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.book.booktitle,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.book.author,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.book.price,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.book.description,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.book.rating,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.book.publisher,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.book.isbn,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.book.cover,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        )),
      ),
    );
  }
}
