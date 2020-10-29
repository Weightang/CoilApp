import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class BillPage extends StatefulWidget {
  @override
  _BillPageState createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("今日:${DateUtil.formatDate(DateTime.now(),format: DateFormats.y_mo_d)}"),
      ),


    );
  }
}
