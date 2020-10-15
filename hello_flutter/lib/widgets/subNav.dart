import 'package:flutter/material.dart';
import 'package:hello_flutter/model/common_model.dart';
import 'package:hello_flutter/widgets/web_detail.dart';

class SubNav extends StatelessWidget {
  final List<CommonModel> subNavList;
  const SubNav({Key key, this.subNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: EdgeInsets.all(7),
          child: _items(context),
        ));
  }

  _items(BuildContext context) {
    if (subNavList == null) return null;
    List<Widget> items = [];
    subNavList.forEach((element) {
      items.add(_item(context, element));
    });
    int half = (subNavList.length / 2 + 0.5).toInt();
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, half),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(half, subNavList.length),
          ),
        )
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        Navigator.push(
        context, 
        MaterialPageRoute(builder: (context)=> 
          WebDetail(
            title: model.title,
            url: model.url,
          )
        ));
      },
      child: Column(
        children: <Widget>[
          Image.network(
            model.icon,
            width: 18,
            height: 18,
          ),
          Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                model.title,
                style: TextStyle(fontSize: 12),
              ))
        ],
      ),
    ));
  }
}
