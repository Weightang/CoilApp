import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'config/provider_manager.dart';
import 'config/router_manger.dart';
import 'config/storage_manager.dart';
import 'utils/device_utils.dart';
import 'utils/log_utils.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  Log.init();
  runApp(MyApp());
  if (Device.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: MultiProvider(
          providers: providers,
          builder: (context, child) {
            return RefreshConfiguration(
              hideFooterWhenNotFull: true,
              headerBuilder: () => WaterDropHeader(),
              footerBuilder: () => ClassicFooter(),
              maxUnderScrollExtent:0,
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                onGenerateRoute: MyRouter.generateRoute,
                initialRoute: RouteName.tab,
              ),
            );
          },
        ));
  }
}