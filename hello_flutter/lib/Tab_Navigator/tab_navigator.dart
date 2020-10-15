import 'package:flutter/material.dart';
import 'package:hello_flutter/pages/home.dart';
import 'package:hello_flutter/pages/my.dart';
import 'package:hello_flutter/pages/search.dart';
import 'package:hello_flutter/pages/travel.dart';
// import 'package:hello_flutter/widgets/longwaytogo.dart';


class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState()=>_TabNavigatorState();
  
}

class _TabNavigatorState extends State {
  final _defaultColor = Colors.grey;
  final _selectedColor = Colors.blue;
  int _currentIndex = 0;
  final PageController _controller = PageController(
    initialPage: 0
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Home(),
          Search(),
          Travel(),
          My()
          // LongWayToGo()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [       
        _bottomItem(Icons.home, '首页', 0),
        _bottomItem(Icons.search, '搜索', 1),
        _bottomItem(Icons.camera_alt, '旅拍', 2),
        _bottomItem(Icons.account_circle, '我的', 3),
      ]),
    );
  }
    _bottomItem(IconData iconData,String itemString,int index) {
      return BottomNavigationBarItem(
        icon: Icon(iconData, color: _defaultColor),
        activeIcon: Icon(iconData, color:_selectedColor),
        title: Text(itemString,
          style: TextStyle(
            color: _currentIndex != index ? _defaultColor : _selectedColor
          ),
        )
      );
    }
  
}