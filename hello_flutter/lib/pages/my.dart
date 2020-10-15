
import 'package:flutter/material.dart';
import 'package:hello_flutter/widgets/web_detail.dart';

class My extends StatefulWidget {
  @override
  _MyState createState()=> _MyState();
}

class _MyState extends State with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body:  WebDetail(
          url:'https://m.ctrip.com/webapp/myctrip/',
          hideAppBar: true,
          title: '我的',
          tabbarColor: '475BC9',
        ),
      );
  }

  @override
  bool get wantKeepAlive => true;
}
