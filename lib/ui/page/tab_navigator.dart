import 'package:flutter/material.dart';
import 'package:flutter_app/config/router_manger.dart';
import 'package:flutter_app/res/index.dart';
import 'package:flutter_app/ui/page/home/list_page.dart';
import 'package:flutter_app/ui/widget/iconfont_icons.dart';
import 'package:flutter_app/ui/widget/my_tab_indicator.dart';

import 'home/notes_page.dart';

List<Widget> pages = <Widget>[NotesPage(), ListPage()];

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator>
    with TickerProviderStateMixin {
  var _pageController = PageController();
  TabController mTabController;

  bool isPageCanChanged = false;
  DateTime _lastPressed;

  @override
  void initState() {
    super.initState();
    mTabController = TabController(vsync: this, length: pages.length);
    mTabController.addListener(() {
      if (mTabController.indexIsChanging) {
        //判断TabBar是否切换
        print(mTabController.index);
        onPageChange(mTabController.index, p: _pageController);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: null,
        title: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),),
          width: 120,
          height: 25,
          child: TabBar(
            controller: mTabController,
            labelColor: MyColors.white,
            labelStyle: TextStyle(color: MyColors.white, fontSize: 14.0),
            unselectedLabelColor: MyColors.grey_ca,
            unselectedLabelStyle:
            TextStyle(color: MyColors.grey_ec, fontSize: 14.0),
            indicator: FloatingLineTabIndicator(),

            tabs: [
              Tab(
                text: "记录",
              ),
              Tab(
                text: "查看",
              )
            ],
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (_lastPressed == null ||
              DateTime.now().difference(_lastPressed) > Duration(seconds: 1)) {
            //两次点击间隔超过1秒则重新计时
            _lastPressed = DateTime.now();
            return false;
          }
          return true;
        },
        child: PageView.builder(
          itemBuilder: (ctx, index) => pages[index],
          itemCount: pages.length,
          controller: _pageController,

          onPageChanged: (index) {
            onPageChange(index);
          },
        ),
      ),
      drawer: HomeDrawer(),
    );
  }

  onPageChange(int index, {PageController p, TabController t}) async {
    if (p != null) {
      //判断是哪一个切换
      isPageCanChanged = false;
      await _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease); //等待pageview切换完毕,再释放pageivew监听
      isPageCanChanged = true;
    } else {
      mTabController.animateTo(index); //切换Tabbar
    }
  }
}

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      //侧滑对象
      child: Column(
        // 主轴方向
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DrawerHeader(
            // 侧滑头部
            decoration: BoxDecoration(color: Colors.lightBlueAccent),
            child: Center(
              child: ClipOval(
                child: Icon(Icons.apartment),
              ),
            ),
          ),
          Expanded(
            // 伸展控件
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.settings_rounded),
                  title: Text(
                    "设置",
                    textDirection: TextDirection.ltr,
                  ),
                  subtitle: Text("基础数据"),
                  isThreeLine: true,
                  onTap: () =>
                      {Navigator.of(context).pushNamed(RouteName.basis)},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
