import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/models/viewModel/bill_model.dart';
import 'package:flutter_app/provider/provider_widget.dart';
import 'package:flutter_app/res/colors.dart';
import 'package:flutter_app/res/index.dart';

class BillPage extends StatefulWidget {
  @override
  _BillPageState createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<BillModel>(
      model: BillModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: MyColors.white,
          body: SafeArea(
            child: Column(
              children: [
                BillHeadListView(),
                Expanded(
                  child: BillListView(),
                ),
                BillFootListView()
              ],
            ),
          ),
        );
      },
    );
  }
}

class BillHeadListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: MyColors.common_grey_f1,
            offset: Offset(2,2),
            blurRadius: 4.0
          )
        ]
      ),
      child: Column(
        children: [
          Container(
            decoration: Decorations.bottom,
            child: Row(
              children: [
                Expanded(
                  child: Text("今日收入:200"),
                ),
                Expanded(
                  child: Text("今日支出:200"),
                )
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text("原料"),
              ),
              Expanded(
                child: Text("数量"),
              ),
              Expanded(
                child: Text("原料工价"),
              ),
              Expanded(
                child: Text("次料数量"),
              ),
              Expanded(
                child: Text("回收金额"),
              ),
            ],
          )


        ],
      ),
    );
  }
}

class BillListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class BillFootListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
