 import 'package:flutter/material.dart';
import 'package:hello_flutter/dao/travel_dao.dart';
import 'package:hello_flutter/model/travel_tab_model.dart';
import 'package:hello_flutter/widgets/travel_tab_page.dart';

class TravelTabBar extends StatefulWidget {
   TravelTabBar({Key key}) : super(key: key);
 
   @override
   _TravelTabBarState createState() => _TravelTabBarState();
 }
 
 class _TravelTabBarState extends State<TravelTabBar> with TickerProviderStateMixin {
   List<TravelTab> tabs = [];
   TabController _tabController;
   TravelTabModel tabModel;
   @override
  void initState() {
    _tabController = TabController(length: 0, vsync: this);
    TravelTabDao.fetch().then((TravelTabModel tabModel) {
      _tabController = TabController(length: tabModel.tabs.length, vsync: this);
      setState(() {
        tabs = tabModel.tabs;
        tabModel = tabModel;
      });
    }).catchError((error){
      print(error);
    });
    super.initState();
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
   @override
   Widget build(BuildContext context) {
     return Column(
       children: <Widget>[
     Container(
      //  color: Colors.red,
       padding: EdgeInsets.only(top:0),
        child: TabBar(
          tabs: tabs.map<Tab>((TravelTab tab) { 
           var tab2 = Tab(
             text: tab.labelName
             );
           return tab2;
          }).toList(),
          indicatorColor: Colors.blue,
          indicatorSize: TabBarIndicatorSize.label,
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.black,
          labelPadding: EdgeInsets.fromLTRB(5, 0, 5, 5),
          indicator: UnderlineTabIndicator(
            insets: EdgeInsets.only(bottom:10),
            borderSide: BorderSide(
              color:Colors.pink,
              width: 3
            )
          ),
          ),
     ),
     Flexible(child: TabBarView(
       controller: _tabController,
       children: tabs.map((TravelTab tab)  {
         return TravelTabPage(groupChannelCode: tab.groupChannelCode);
       }).toList()))
     ],
     );
   }
 }