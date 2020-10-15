import 'package:flutter/material.dart';
import 'package:hello_flutter/model/common_model.dart';
import 'package:hello_flutter/model/sale_box_model.dart';

import 'web_detail.dart';

class SaleBox extends StatelessWidget {
  final SaleBoxModel saleBoxModel;
  const SaleBox({Key key, this.saleBoxModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, 
          MaterialPageRoute(builder: (context)=>
            WebDetail(url: saleBoxModel.moreUrl,title: '活动',hideAppBar: true)
          )
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child:  _items(context),
        ),
    );
  }

  _items(BuildContext context) {
    if (saleBoxModel == null) return null;
    List<Widget> items = [];
    items.add(_doubleItem(context,saleBoxModel.bigCard1,saleBoxModel.bigCard2,true,false));
     items.add(_doubleItem(context,saleBoxModel.smallCard1,saleBoxModel.smallCard2,false,false));
     items.add(_doubleItem(context,saleBoxModel.smallCard3,saleBoxModel.smallCard4,false,true));
    return Column(
      children: <Widget>[
       Container(
         height: 44,
         margin: EdgeInsets.only(left:10),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
             Image.network(
               saleBoxModel.icon,
               height: 15,
               fit: BoxFit.fill,
             ),
             Container(
               padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
               margin: EdgeInsets.only(right: 7),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(12),
                 gradient: LinearGradient(colors: [
                   Color(0xffff4e63),
                   Color(0xffff6cc9)
                 ],
                 begin: Alignment.centerLeft,
                 end: Alignment.centerRight,
                 )
               ),
               child: GestureDetector(
                 child: Text('更多活动',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12
                  ),
                 ),
               ),
             )
           ],
         ),
       ),
       Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: 
           items.sublist(0,1),
       ),
       Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: 
           items.sublist(1,2),
       ),
       Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: 
           items.sublist(2,3),
       )
      ],
    );
  }
  Widget _doubleItem(BuildContext context, CommonModel leftCard,CommonModel rightCard,bool big,bool last) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _item(context, leftCard,big, true,last),
        _item(context, rightCard,big ,false,last)
      ],
    );
  }
  Widget _item(BuildContext context, CommonModel model,bool big,bool left,bool last) {
    return  GestureDetector(
      onTap: () {
        Navigator.push(context, 
          MaterialPageRoute(builder: (context)=>
            WebDetail(url: model.url,title: '详情')
          )
        );
      },
      child: Container(
        decoration: BoxDecoration(
           border: Border(
           right: left?BorderSide(width:0.7,color: Color(0xfff2f2f2)):BorderSide.none,
           bottom: last?BorderSide.none:BorderSide(width:0.7,color: Color(0xfff2f2f2)))
          ),
       child: Image.network(
            model.icon,
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width/2-10,
            height: big?129:80,
          ),
        ),
    );
  }
}
