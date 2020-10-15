import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hello_flutter/dao/travel_dao.dart';
import 'package:hello_flutter/model/travel_model.dart';
import 'package:hello_flutter/widgets/web_detail.dart';

const PageSize = 10;
const TravelListUrl =
    'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';

class TravelTabPage extends StatefulWidget {
  final String travelUrl;
  final String groupChannelCode;
  TravelTabPage({Key key, this.travelUrl, this.groupChannelCode})
      : super(key: key);

  @override
  _TravelTabPageState createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage>
    with AutomaticKeepAliveClientMixin {
  List<TravelItem> travelItems;
  int index = 1;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _loadData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _loadData(loadMore: true);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: RefreshIndicator(
          child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              controller: _scrollController,
              itemCount: travelItems?.length ?? 0,
              itemBuilder: (BuildContext context, int index) =>
                  CreateItem(index: index, item: travelItems[index]),
              staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            )
          ), 
          onRefresh: _handleRefresh)
         );
  }
   Future<Null> _handleRefresh() async{
     _loadData();
     return null;
  }
  void _loadData({loadMore = false}) {
    if (loadMore) {
      index++;
    } else {
      index = 1;
    }
    TravelItemDao.fetch(TravelListUrl, widget.groupChannelCode, PageSize, index)
        .then((TravelModel model) {
      setState(() {
        List<TravelItem> items = _filterData(model.resultList);
        if (travelItems != null) {
          travelItems.addAll(items);
        } else {
          travelItems = items;
        }
      });
    }).catchError((e) {
      print(e);
    });
  }

  _filterData(List<TravelItem> list) {
    if (list == null) {
      return [];
    }
    List<TravelItem> filterItem = [];
    list.forEach((element) {
      if (element.article != null) {
        filterItem.add(element);
      }
    });
    return filterItem;
  }

  @override
  bool get wantKeepAlive => true;
}

class CreateItem extends StatelessWidget {
  final TravelItem item;
  final int index;
  const CreateItem({Key key, this.item, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.article != null && item.article.urls.length > 0) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return WebDetail(
              url: item.article.urls[0].h5Url,
              title: '详情',
            );
          }));
        }
      },
      child: Card(
        child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[_itemImage(), _itemText(), _itemUser()]),
        ),
      ),
    );
  }

  _itemUser() {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(
                    item.article.author?.coverImage?.dynamicUrl,
                  )),
                ),
                padding: EdgeInsets.all(4),
              ),
              Container(
                width: 90,
                padding: EdgeInsets.all(5),
                child: Text(
                  item.article.author.nickName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.thumb_up,
                size: 14,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.only(left: 3),
                child: Text(
                  item.article.likeCount.toString(),
                  style: TextStyle(fontSize: 10),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  _itemText() {
    return Container(
        padding: EdgeInsets.all(4),
        child: Text(
          item.article.articleTitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14,
          ),
        ));
  }

  _itemImage() {
    return Stack(
      children: <Widget>[
        Image.network(item.article.images[0]?.dynamicUrl),
        Positioned(
          bottom: 8,
          left: 8,
          child: Container(
            padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
            decoration: BoxDecoration(
                color: Colors.black54, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.location_on, color: Colors.white, size: 12),
                ),
                LimitedBox(
                    maxWidth: 130,
                    child: Text(
                      _locationName(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _locationName() {
    return item.article.pois == null || item.article.pois.length == 0
        ? '未知'
        : item.article.pois[0]?.poiName ?? '未知';
  }
}
