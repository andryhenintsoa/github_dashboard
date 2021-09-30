import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:github_dashboard/core/service_locator.dart';

class BaseView<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget? child) builder;
  final Function(T)? onModelReady;

  BaseView({required this.builder, this.onModelReady});

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends ChangeNotifier> extends State<BaseView<T>> {
  T model = locator<T>();

  @override
  void initState() {
    widget.onModelReady?.call(model);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (model is ChangeNotifier) {
      try {
        model.dispose();
      } catch (_) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(builder: widget.builder),
    );
  }
}
