import 'package:flutter/material.dart';
import 'package:flutter_app/config/router_manger.dart';
import 'package:flutter_app/models/viewModel/pirce_model.dart';
import 'package:flutter_app/provider/provider_widget.dart';

class BasisPage extends StatefulWidget {
  @override
  _BasisPageState createState() => _BasisPageState();
}

class _BasisPageState extends State<BasisPage> {
  var list = ["设置村组", "设置价格"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("设置数据"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemExtent: 30,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(list[index]),
            onTap: () {
              switch (index) {
                case 0:
                  Navigator.of(context).pushNamed(RouteName.group);
                  break;
                case 1:
                  Navigator.of(context).pushNamed(RouteName.price);
                  break;
              }
            },
          );
        },
      ),
    );
  }
}
