import 'package:flutter/material.dart';
import 'package:hello_flutter/model/common_model.dart';
import 'package:hello_flutter/model/grid_nav_model.dart';
import 'package:hello_flutter/widgets/web_detail.dart';

class GirdNav extends StatelessWidget {
  final GridNavModel navModel;
  const GirdNav({Key key, this.navModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(children: _gridItems(context)),
    );
  }

  _gridItems(BuildContext context) {
    List<Widget> items = [];
    if (navModel == null) {
      return items;
    }
    if (navModel.hotel != null) {
      items.add(_girdNavItem(context, navModel.hotel, true));
    }
    if (navModel.flight != null) {
      items.add(_girdNavItem(context, navModel.flight, false));
    }
    if (navModel.travel != null) {
      items.add(_girdNavItem(context, navModel.travel, false));
    }
    return items;
  }

  _girdNavItem(BuildContext context, GridNavItem item, bool isFirst) {
    List<Widget> items = [];
    items.add(_mainItem(context, item.mainItem));
    items.add(_doubleItem(context, item.item1, item.item2));
    items.add(_doubleItem(context, item.item3, item.item4));
    List<Widget> expandItems = [];
    items.forEach((item) {
      expandItems.add(Expanded(child: item, flex: 1));
    });
    Color startColor = Color(int.parse('0xff' + item.startColor));
    Color endColor = Color(int.parse('0xff' + item.startColor));
    return Container(
      height: 88,
      margin: isFirst ? null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [startColor, endColor])),
      child: Row(children: expandItems),
    );
  }

  _mainItem(BuildContext context, CommonModel commonModel) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebDetail(
                    title: commonModel.title,
                    url: commonModel.url,
                    hideAppBar: commonModel.hideAppBar,
                    tabbarColor: commonModel.statusBarColor)));
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Image.network(
            commonModel.icon,
            fit: BoxFit.contain,
            height: 80,
            width: 120,
            alignment: AlignmentDirectional.bottomEnd,
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            child: Text(
              commonModel.title,
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  _doubleItem(
      BuildContext context, CommonModel topItem, CommonModel bottomItem) {
    return Column(
      children: <Widget>[
        Expanded(child: _item(context, topItem, true)),
        Expanded(child: _item(context, bottomItem, false))
      ],
    );
  }

  _item(BuildContext context, CommonModel commonModel, bool isFirst) {
    return FractionallySizedBox(
        widthFactor: 1,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WebDetail(
                        url: commonModel.url,
                        title: commonModel.title,
                        tabbarColor: commonModel.statusBarColor,
                        hideAppBar: commonModel.hideAppBar)));
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                  left: BorderSide(width: 0.8, color: Colors.white),
                  bottom: isFirst
                      ? BorderSide(width: 0.8, color: Colors.white)
                      : BorderSide.none),
            ),
            child: Center(
              child: Text(
                commonModel.title,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ));
  }
}
