
import 'package:flutter/material.dart';

class SellPage extends StatefulWidget {
  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("卖出："),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            alignment: Alignment.center,
            child: Text("(元)"),

          )

        ],

      ),


    );
  }
}
