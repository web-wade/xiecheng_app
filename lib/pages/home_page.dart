import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:xiecheng_app/dao/home_dao.dart';
import 'package:xiecheng_app/model/common_model.dart';
import 'package:xiecheng_app/model/grid_nav_model.dart';
import 'package:xiecheng_app/model/home_model.dart';
import 'package:xiecheng_app/model/sales_box_model.dart';
import 'package:xiecheng_app/widget/grid_nav.dart';
import 'package:xiecheng_app/widget/loading_container.dart';
import 'package:xiecheng_app/widget/local_nav.dart';
import 'package:xiecheng_app/widget/sales_box.dart';
import 'package:xiecheng_app/widget/sub_nav.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    'http://a3.att.hudong.com/14/75/01300000164186121366756803686.jpg',
    'http://a0.att.hudong.com/56/12/01300000164151121576126282411.jpg',
    'http://a4.att.hudong.com/52/52/01200000169026136208529565374.jpg'
  ];
  double appBarAlpha = 0;
  String resultString = '';
  List<CommonModel> localNavList = [];
  List<CommonModel> subNavList = [];
  SalesBoxModel salesBoxModel;
  List<CommonModel> bannerList = [];
  bool _loading = true;
  GridNavModel gridNavModel;

  @override
  void initState() {
    super.initState();
    lodeData();
  }

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  Future<Null> _handleRefresh() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
        subNavList = model.subNavList;
        gridNavModel = model.gridNav;
        salesBoxModel = model.salesBox;
        bannerList = model.bannerList;
        _loading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _loading = false;
      });
    }
    return null;
  }

  lodeData() {
    HomeDao.fetch().then((model) {
      setState(() {
        localNavList = model.localNavList;
        gridNavModel = model.gridNav;
        subNavList = model.subNavList;
        salesBoxModel = model.salesBox;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: LoadingContainer(
          isLoading: _loading,
          child: Stack(
            children: <Widget>[
              MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: RefreshIndicator(
                      child: NotificationListener(
                        onNotification: (scrollNotification) {
                          if (scrollNotification is ScrollUpdateNotification &&
                              scrollNotification.depth == 0) {
                            _onScroll(scrollNotification.metrics.pixels);
                          }
                          return;
                        },
                        child: ListView(
                          children: <Widget>[
                            Container(
                              height: 160,
                              child: Swiper(
                                itemCount: _imageUrls.length,
                                autoplay: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Image.network(
                                    _imageUrls[index],
                                    fit: BoxFit.fill,
                                  );
                                },
                                pagination: SwiperPagination(),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                              child: LocalNav(localNavList: localNavList),
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                                child: GridNav(gridNavModel: gridNavModel)),
                            Padding(
                                padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                                child: SubNav(subNavList: subNavList)),
                            Padding(
                                padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                                child: SalesBox(salesBox: salesBoxModel)),
                          ],
                        ),
                      ),
                      onRefresh: _handleRefresh)),
              Opacity(
                opacity: appBarAlpha,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text('首页'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
