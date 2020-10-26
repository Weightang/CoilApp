import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/ui/page/setting/basis_page.dart';
import 'package:flutter_app/ui/page/setting/group_page.dart';
import 'package:flutter_app/ui/page/setting/price_page.dart';
import 'package:flutter_app/ui/page/tab_navigator.dart';
import 'package:flutter_app/ui/widget/page_route_anim.dart';



class RouteName {
  static const String splash = 'splash';
  static const String tab = '/';
  static const String login = 'login';
  static const String basis = 'basis';
  static const String group = 'group';
  static const String price = 'price';
}

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.tab:
        return NoAnimRouteBuilder(TabNavigator());
      case RouteName.basis:
        return NoAnimRouteBuilder(BasisPage());
      case RouteName.group:
        return NoAnimRouteBuilder(GroupPage());
      case RouteName.price:
        return NoAnimRouteBuilder(PricePage());
      default:
        return CupertinoPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}

/// Pop路由
class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}
