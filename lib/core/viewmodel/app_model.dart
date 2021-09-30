import 'package:github_dashboard/core/enum/view_state.dart';

import '../base_model.dart';

class AppModel extends BaseModel {

  Future initData() async {
    setState(ViewState.Busy);

    print("initData begin");
    await Future.delayed(Duration(seconds: 2));
    print("initData done");
    setState(ViewState.Idle);
  }
}
