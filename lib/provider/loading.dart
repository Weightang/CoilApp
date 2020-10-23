import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingToast {
  static void show(
    String msg,
    BuildContext context,
  ) {
    Loading.dismiss();
    Loading.createView(msg, context);
  }

  static void dismiss() {
    Loading.dismiss();
  }
}

Widget loading(BuildContext context) {
  return LoadingWidget(
    widget: Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: Colors.black87, borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularProgressIndicator(),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "加载中...",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

class Loading {
  static final Loading _singleton = Loading._internal();

  factory Loading() {
    return _singleton;
  }

  Loading._internal();

  static OverlayState overlayState;
  static OverlayEntry _overlayEntry;
  static bool _isVisible = false;

  static void createView(
    String msg,
    BuildContext context,
  ) async {
    overlayState = Overlay.of(context);
    _overlayEntry = new OverlayEntry(
      builder: (BuildContext context) => LoadingWidget(
        widget: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    msg,
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    _isVisible = true;
    overlayState.insert(_overlayEntry);
  }

  static dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry?.remove();
  }
}

class LoadingWidget extends StatelessWidget {
  LoadingWidget({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: widget,
    );
  }
}
