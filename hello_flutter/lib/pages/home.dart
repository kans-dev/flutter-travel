import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hello_flutter/dao/home_dao.dart';
import 'package:hello_flutter/model/common_model.dart';
import 'package:hello_flutter/model/grid_nav_model.dart';
import 'package:hello_flutter/model/sale_box_model.dart';
import 'package:hello_flutter/widgets/gridNav.dart';
import 'package:hello_flutter/widgets/localNav.dart';
import 'package:hello_flutter/widgets/sale_box.dart';
import 'package:hello_flutter/widgets/search_bar.dart';
import 'package:hello_flutter/widgets/subNav.dart';

const APPBAR_SCROLL_OFFSET = 80;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State with AutomaticKeepAliveClientMixin {
  String result = '';
  List<CommonModel> localNavList = [];
  GridNavModel gridNavModel;
  List<CommonModel> sublNavList = [];
  List<CommonModel> bannerList = [];
  SaleBoxModel saleBoxModel;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  SearchBarType _searchBarType = SearchBarType.home;
  double appBarAlpha = 0.0;
  _onScroll(offset) {
    print(offset);
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    SearchBarType type = SearchBarType.home;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 0.8) {
      alpha = 1;
    }
    if (alpha < 0.8) {
      type = SearchBarType.home;
    } else {
      type = SearchBarType.homeLight;
    }
    setState(() {
      appBarAlpha = alpha;
      _searchBarType = type;
    });
  }

  loadData() {
    HomeDao.fetch()
        .then((value) => {
              setState(() {
                localNavList = value.localNavList;
                gridNavModel = value.gridNavModel;
                sublNavList = value.subNavList;
                bannerList = value.bannerList;
                saleBoxModel = value.saleBoxModel;
              })
            })
        .catchError((err) => {print(err)});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: NotificationListener(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollUpdateNotification &&
                      scrollNotification.depth == 0) {
                    _onScroll(scrollNotification.metrics.pixels);
                    return true;
                  }
                  return false;
                },
                child: Stack(
                  children: <Widget>[
                    ListView(
                      children: <Widget>[
                        Container(
                            height: 160,
                            child: Swiper(
                              itemCount: bannerList.length,
                              autoplay: true,
                              pagination: SwiperPagination(),
                              itemBuilder: (BuildContext context, int index) {
                                return Image.network(
                                  bannerList[index].icon,
                                  fit: BoxFit.fill,
                                );
                              },
                            )),
                        Padding(
                            padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                            child: LocalNav(
                              localNavList: localNavList,
                            )),
                        Padding(
                            padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                            child: GirdNav(
                              navModel: gridNavModel,
                            )),
                        Padding(
                            padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                            child: SubNav(
                              subNavList: sublNavList,
                            )),
                        Padding(
                            padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                            child: SaleBox(saleBoxModel: saleBoxModel))
                      ],
                    ),
                    Opacity(
                        opacity: appBarAlpha,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).padding.top),
                            child: SearchBar(searchBarType: _searchBarType))),
                  ],
                ))));
  }

  @override
  bool get wantKeepAlive => true;
}
