import 'package:hello_flutter/model/common_model.dart';
import 'package:hello_flutter/model/config_model.dart';
import 'package:hello_flutter/model/grid_nav_model.dart';
import 'package:hello_flutter/model/sale_box_model.dart';

class HomeModel {
  final ConfigModel configModel;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final List<CommonModel> subNavList;
  final GridNavModel gridNavModel;
  final SaleBoxModel saleBoxModel;
  HomeModel({this.configModel, this.bannerList, this.localNavList, this.gridNavModel, this.saleBoxModel, this.subNavList});

  factory HomeModel.fromJson(Map<String,dynamic>json) {
    var localNavListJson = json['localNavList'] as List;
    List localNavList = localNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    var bannerListJson = json['bannerList'] as List;
    List bannerList = bannerListJson.map((i) => CommonModel.fromJson(i)).toList();

    var subNavListJson = json['subNavList'] as List;
    List subNavList = subNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    return HomeModel (
      localNavList: localNavList,
      bannerList: bannerList,
      subNavList: subNavList,
      configModel: ConfigModel.fromJson(json['config']),
      gridNavModel:GridNavModel.fromJson(json['gridNav']),
      saleBoxModel: SaleBoxModel.fromJson(json['salesBox'])
    );
  }
}