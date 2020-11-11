import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/models/viewModel/bill_model.dart';
import 'package:flutter_app/provider/provider_widget.dart';
import 'package:flutter_app/res/colors.dart';
import 'package:flutter_app/res/index.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
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
                NotesHeadView(),
                Expanded(
                  child: NotesListView(),
                ),
                NotesFootView()
              ],
            ),
          ),
        );
      },
    );
  }
}

class NotesHeadView extends StatelessWidget {
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
              Row(

              ),
              Row()
        ],
      ),
    );
  }
}

class NotesListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class NotesFootView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
