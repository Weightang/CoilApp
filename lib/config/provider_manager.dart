

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';



List<SingleChildWidget> providers = [
  ...independentServices,
];

/// 独立的model
List<SingleChildWidget> independentServices = [

  // ChangeNotifierProvider<GlobalFavouriteStateModel>(
  //   create: (context) => GlobalFavouriteStateModel(),
  // )
];