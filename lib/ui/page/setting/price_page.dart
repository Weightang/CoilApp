import 'package:flutter/material.dart';
import 'package:flutter_app/models/response/price_entity.dart';
import 'package:flutter_app/models/viewModel/pirce_model.dart';
import 'package:flutter_app/provider/provider_widget.dart';
import 'package:flutter_app/provider/view_state_widget.dart';
import 'package:flutter_app/res/colors.dart';
import 'package:flutter_app/utils/log_utils.dart';
import 'package:oktoast/oktoast.dart';

class PricePage extends StatefulWidget {
  @override
  _PricePageState createState() => _PricePageState();
}

class _PricePageState extends State<PricePage> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<PriceModel>(
      model: PriceModel(),
      builder: (context, model, child) {
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
                Container(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "种类(斤)",
                          style: TextStyle(color: MyColors.gray_33),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Text("价格(元)",
                            style: TextStyle(color: MyColors.gray_33)),
                        flex: 1,
                      )
                    ],
                  ),
                  decoration: BoxDecoration(color: MyColors.common_line_grey),
                ),
                Expanded(child: PriceListView(model: model)),
                PriceTextField(model: model),
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
    return ProviderWidget<PriceModel>(
        model: model,
        onModelReady: (model) {
          model.findAllPrice();
        },
        builder: (context, model, child) {
          if (model.isEmpty) {
            return Container();
          } else if (model.isError) {
            return ViewStateErrorWidget(
                error: model.viewStateError,
                onPressed: () {
                  showToast("数据查询错误");
                });
          }
          return ListView.separated(
            itemCount: model.list.length,
            itemBuilder: (_, index) {
              return PriceSettingCell(bean: model.list[index], model: model);
            },
            separatorBuilder: (BuildContext context, int index)=>Divider(height: 2.0, color: MyColors.common_line_grey),
          );
        });
  }
}

class PriceSettingCell extends StatelessWidget {
  final PriceEntity bean;
  final PriceModel model;

  PriceSettingCell({@required this.bean, @required this.model});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Colors.red),
      direction: DismissDirection.endToStart,
      child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          child: Container(
            height: 40,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "${bean.name}",
                    style: TextStyle(color: MyColors.gray_33),
                  ),
                ),
                Expanded(
                  child: Text("${bean.price}",
                      style: TextStyle(color: MyColors.gray_33)),
                )
              ],
            ),
          )),
      onDismissed: (_) async {
        if (bean != null) {
          model.list.remove(bean);
          model.deletePrice(bean).then((value) => () {
                if (value) {
                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(
                    const SnackBar(content: Text('已删除')),
                  );
                }
              });
        }
      },
    );
  }
}

class PriceTextField extends StatelessWidget {
  final PriceModel model;
  final TextEditingController _textNameEditingController;
  final TextEditingController _textPriceEditingController;

  PriceTextField({@required this.model})
      : _textNameEditingController = TextEditingController(),
        _textPriceEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _textNameEditingController,
            decoration: const InputDecoration(
              fillColor: Colors.transparent,
              filled: true,
              contentPadding: EdgeInsets.all(16),
              border: InputBorder.none,
              hintText: '请输入种类名称',
            ),
            onSubmitted: (_) async {
              await _persistMessage();
            },
          ),
          flex: 2,
        ),
        Expanded(
          child: TextField(
            controller: _textPriceEditingController,
            decoration: const InputDecoration(
              fillColor: Colors.transparent,
              filled: true,
              contentPadding: EdgeInsets.all(16),
              border: InputBorder.none,
              hintText: '请输入价格',
            ),
            onSubmitted: (_) async {
              await _persistMessage();
            },
          ),
          flex: 2,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: OutlineButton(
              textColor: Colors.blueGrey,
              child: const Text('保存'),
              onPressed: () async {
                await _persistMessage();
              },
            ),
          ),
          flex: 1,
        )
      ],
    ));
  }

  Future<void> _persistMessage() async {
    final name = _textNameEditingController.text;
    final price = _textPriceEditingController.text;
    if (name.trim().isEmpty) {
      _textNameEditingController.clear();
    } else if (price.trim().isEmpty) {
      _textPriceEditingController.clear();
    } else {
      final pirce = PriceEntity(name: name, price: price);
      await model.addPrice(pirce);
      _textNameEditingController.clear();
      _textPriceEditingController.clear();
    }
  }
}
