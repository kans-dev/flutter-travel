import 'package:flutter/material.dart';

enum SearchBarType { home, normal, homeLight }

class SearchBar extends StatefulWidget {
  final bool enabled = true;
  final bool hideLeft;
  final SearchBarType searchBarType;
  final String hint;
  final String defaultString;
  final void Function() leftBtnDid;
  final void Function() rightBtnDid;
  final void Function() speakBtnDid;
  final void Function() inputBoxDid;
  final ValueChanged<String> onChanged;

  SearchBar(
      {Key key,
      this.hideLeft,
      this.searchBarType = SearchBarType.normal,
      this.hint,
      this.defaultString = '请输入内容',
      this.leftBtnDid,
      this.rightBtnDid,
      this.speakBtnDid,
      this.inputBoxDid,
      this.onChanged})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool showClear = false;
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.defaultString != null) {
      setState(() {
        _controller.text = widget.defaultString;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.normal
        ? _createNormalSearch()
        : _createHomeSearch();
  }

  _createNormalSearch() {
    return Container(
      child: Row(
        children: <Widget>[
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(6, 5, 10, 5),
                child: widget.hideLeft ?? false
                    ? null
                    : Icon(
                        Icons.arrow_back_ios,
                        color: Colors.grey,
                        size: 26,
                      ),
              ),
              widget.leftBtnDid),
          Expanded(
            flex: 1,
            child: _inputBox(),
          ),
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  '搜索',
                  style: TextStyle(color: Colors.blue, fontSize: 17),
                ),
              ),
              widget.rightBtnDid)
        ],
      ),
    );
  }

  _createHomeSearch() {
    return Container(
      child: Row(
        children: <Widget>[
          _wrapTap(
              Container(
                  padding: EdgeInsets.fromLTRB(6, 5, 10, 5),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '上海',
                        style: TextStyle(
                          fontSize: 14,
                          color: _homeFontColor(),
                        ),
                      ),
                      Icon(
                        Icons.expand_more,
                        color: _homeFontColor(),
                        size: 22,
                      )
                    ],
                  )),
              widget.leftBtnDid),
          Expanded(
            flex: 1,
            child: _inputBox(),
          ),
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Icon(
                  Icons.comment,
                  color: _homeFontColor(),
                  size: 26,
                )
              ),
              widget.rightBtnDid)
        ],
      ),
    );
  }

  _inputBox() {
    Color inputBoxColor;
    if (widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white;
    } else {
      inputBoxColor = Color(int.parse('0xffEDEDED'));
    }
    return Container(
      height: 30,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: inputBoxColor,
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.search,
              size: 20,
              color: widget.searchBarType == SearchBarType.normal
                  ? Color(0xffA9A9A9)
                  : Colors.blue),
          Expanded(
              flex: 1,
              child: widget.searchBarType == SearchBarType.normal
                  ? TextField(
                      controller: _controller,
                      onChanged: _onChanged,
                      decoration: InputDecoration(border: InputBorder.none),
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w300),
                    )
                  : _wrapTap(
                      Container(
                          child: Text(widget.defaultString,
                              style:
                                  TextStyle(fontSize: 13, color: Colors.grey))),
                      widget.inputBoxDid))
        ],
      ),
    );
  }

  _wrapTap(Widget child, void Function() callback) {
    return GestureDetector(
      onTap: () {
        if (callback != null) {
          callback();
        }
      },
      child: child,
    );
  }

  _onChanged(String text) {
    if (text.length > 0) {
      setState(() {
        showClear = true;
      });
    } else {
      showClear = false;
    }
    if (widget.onChanged != null) {
      widget.onChanged(text);
    }
  }
  _homeFontColor() {
    return widget.searchBarType == SearchBarType.homeLight?Colors.black54:Colors.white;
  }
}
