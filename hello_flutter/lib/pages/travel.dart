import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_flutter/widgets/travel_tab.dart';

class Travel extends StatefulWidget {
  @override
  _TravelState createState() => _TravelState();
}

class _TravelState extends State {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        child: Scaffold(
            body: SafeArea(
                child: Container(
          child: TravelTabBar(),
        ))),
        value: SystemUiOverlayStyle.dark);
  }
}
