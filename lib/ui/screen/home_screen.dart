import 'package:flutter/material.dart';
import 'package:github_dashboard/core/base_view.dart';
import 'package:github_dashboard/core/enum/view_state.dart';
import 'package:github_dashboard/core/viewmodel/app_model.dart';

import 'loading_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AppModel>(
        onModelReady: (model) => model.initData(),
        builder: (context, model, child) {
          if (model.state == ViewState.Busy) {
            return LoadingScreen();
          }
          return SearchScreen();
        });
  }
}
