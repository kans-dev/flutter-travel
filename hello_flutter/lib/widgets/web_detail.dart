// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const backUrl = ['m.ctrip.com/', 'm.ctrip.com/html5/'];

class WebDetail extends StatefulWidget {
  final String url;
  final String title;
  final String tabbarColor;
  final bool hideAppBar;
  WebDetail(
      {Key key,
      this.url,
      this.title,
      this.tabbarColor = 'ffffff',
      this.hideAppBar = false})
      : super(key: key);

  @override
  _WebDetailState createState() => _WebDetailState();
}

class _WebDetailState extends State<WebDetail> {
  // final Completer<WebViewController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(
              Color(int.parse(widget.tabbarColor ?? 'ffffff', radix: 16) +
                  0xFF000000),
              Colors.black),
          Expanded(
              child: WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            navigationDelegate: (NavigationRequest request) {
              if (request.url == 'https://m.ctrip.com/html5/') {
                Navigator.pop(context);
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ))
        ],
      ),
    );
  }

  _appBar(Color bgColor, Color backBtnColor) {
    if (widget.hideAppBar ?? false) {
      return Container(
        color: bgColor,
        height: 30,
      );
    }
    return Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1, color: Color(0xFFeeeeee)))),
      height: 44 + MediaQuery.of(context).padding.top,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
              bottom: 12,
              left: 12,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: backBtnColor,
                  size: 20,
                ),
              )),
          Positioned(
              bottom: 8,
              child: Center(
                  child: Text(
                widget.title ?? '',
                style: TextStyle(color: backBtnColor, fontSize: 20),
              )))
        ],
      ),
    );
  }
}
