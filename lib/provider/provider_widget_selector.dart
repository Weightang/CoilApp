import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

/// Provider封装类
///
/// 方便数据初始化
class ProviderWidget<T extends ChangeNotifier, K> extends StatefulWidget {
  final ValueWidgetBuilder<K> builder;
  final K Function(BuildContext, T) selector;
  final T model;
  final Widget child;
  final Function(T model) onModelReady;
  final bool autoDispose;

  ProviderWidget({
    Key key,
    @required this.builder,
    @required this.model,
    this.selector,
    this.child,
    this.onModelReady,
    this.autoDispose,
  }) : super(key: key);

  _ProviderWidgetState<T,K> createState() => _ProviderWidgetState<T,K>();
}

class _ProviderWidgetState<T extends ChangeNotifier,K>
    extends State<ProviderWidget<T,  K>> {
  T model;

  @override
  void initState() {
    model = widget.model;
    widget.onModelReady?.call(model);
    super.initState();
  }

  @override
  void dispose() {
    if (widget.autoDispose) model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Selector<T, K>(
        selector: widget.selector,
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
