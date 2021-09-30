import 'dart:io';

import 'package:github_dashboard/core/enum/view_state.dart';
import 'package:github_dashboard/core/model/user.dart';
import 'package:github_dashboard/core/service/api.dart';

import '../base_model.dart';
import '../service_locator.dart';

class SearchModel extends BaseModel {
  Api _api = locator<Api>();

  String? searchedUsername;
  User? user;

  void goSearch(){
    user = null;
    setState(ViewState.Idle);

  }

  Future searchUser(String username) async {
    setState(ViewState.Busy);

    searchedUsername = username;

    await _api.getUser(searchedUsername!).then((result) {
      user = result;
    }).catchError((dynamic e, StackTrace trace) {
      if (e is SocketException) {
        print('$e');
      } else {
        print('Unhandled Error : $e');
      }
    });

    setState(ViewState.Idle);
  }
}
