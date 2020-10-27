import 'package:flutter/material.dart';
import 'package:flutter_app/models/viewModel/pirce_model.dart';
import 'package:flutter_app/provider/provider_widget.dart';


class PricePage extends StatefulWidget {
  @override
  _PricePageState createState() => _PricePageState();
}

class _PricePageState extends State<PricePage> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<PriceModel>(
      model: PriceModel(),
      builder: (context,model,child){
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("设置价格"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                PriceListView(model: model),
                PriceTextField(model:model),

              ],

            ),

          ),

        );
      },
    );
  }
}
class PriceListView extends StatelessWidget {
 final PriceModel model;

  PriceListView({@required this.model});


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class PriceTextField extends StatelessWidget {
  final PriceModel model;
  PriceTextField({@required this.model})

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


