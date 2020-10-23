// Place fonts/iconfont.ttf in your fonts/ directory and
// add the following to your pubspec.yaml
// flutter:
//   fonts:
//    - family: iconfont
//      fonts:
//       - asset: fonts/iconfont.ttf
import 'package:flutter/widgets.dart';

class Iconfont {
  Iconfont._();

  static const String _fontFamily = 'iconfont';

  static const IconData home = IconData(0x1f5ee, fontFamily: _fontFamily);
  static const IconData work = IconData(0xe901, fontFamily: _fontFamily);
  static const IconData message = IconData(0xe902, fontFamily: _fontFamily);
  static const IconData account = IconData(0xe903, fontFamily: _fontFamily);

}
