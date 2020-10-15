import 'package:flutter/material.dart';
import 'package:hello_flutter/widgets/search_bar.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(),
        body: SafeArea(child: Column(
          children: <Widget>[
            SearchBar(
              hideLeft: true,
              hint: '啦啦',
              leftBtnDid: () {},
            )
          ],
        )));
  }
}
