import 'package:flutter/material.dart';

class LongWayToGo extends StatelessWidget {
  const LongWayToGo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: <Widget>[
        Container(
          child: FlutterLogo(
            size: 200,
          ),
        ),
        _titleSection(),
        _btnSection(),
        _textSection()
      ],
    ));
  }
  
  _titleSection() {
    return Container(
        padding: EdgeInsets.all(32),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Text('Flutter Practice EveryDay'),
                ),
                Text(
                  'Long Way To Go',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                )
              ],
            )),
            Icon(
              Icons.star,
              color: Colors.yellow,
            ),
            Text('666')
          ],
        ));
  }

  _btnSection() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _btnItem(Icons.call, 'Call'),
          _btnItem(Icons.alarm, 'Alarm'),
          _btnItem(Icons.bluetooth, 'Bluetooth')
        ],
      ),
    );
  }

  _btnItem(IconData iconData, String name) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          iconData,
          color: Colors.blueAccent,
        ),
        Container(
          padding: EdgeInsets.only(top:8),
            child: Text(
          name,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        ))
      ],
    );
  }
  _textSection(){
    return Container(
      padding: EdgeInsets.all(32),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run',
        softWrap: true,
      ),
    );
  }
}
