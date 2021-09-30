import 'dart:io';

import 'package:github_dashboard/core/enum/view_state.dart';
import 'package:github_dashboard/core/model/repo.dart';
import 'package:github_dashboard/core/model/user.dart';
import 'package:github_dashboard/core/service/api.dart';

import '../base_model.dart';
import '../service_locator.dart';

class SearchModel extends BaseModel {
  Api _api = locator<Api>();

  String? searchedUsername;
  User? user;
  List<Repo> repos = [];

  void goSearch() {
    user = null;
    repos = [];
    setState(ViewState.Idle);
  }

  Future searchUser(String username) async {
    setState(ViewState.Busy);

    searchedUsername = username;
    repos = [];

    await _api.getUser(searchedUsername!).then((result) {
      user = result;
      searchRepositoryForCurrentUser();
    }).catchError((dynamic e, StackTrace trace) {
      if (e is SocketException) {
        print('$e');
      } else {
        print('Unhandled Error : $e');
      }

      setState(ViewState.Idle);
    });
  }

  Future searchRepositoryForCurrentUser() async {
    if (user?.reposUrl == null) {
      repos = [];
      return;
    }

    await _api.getRepository(user!).then((result) {
      if (result != null) {
        repos = result;
      }
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
