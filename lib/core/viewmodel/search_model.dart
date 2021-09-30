import 'dart:io';

import 'package:github_dashboard/core/enum/view_state.dart';
import 'package:github_dashboard/core/model/repo.dart';
import 'package:github_dashboard/core/model/user.dart';
import 'package:github_dashboard/core/service/api.dart';

import '../base_model.dart';
import '../service_locator.dart';

class SearchModel extends BaseModel {
  Api _api = locator<Api>();
  String? flashMessage;

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
      if(result == null){
        flashMessage = "User not found";
        setState(ViewState.Idle);
      }
      else{
        searchRepositoryForCurrentUser();
      }

    }).catchError((dynamic e, StackTrace trace) {
      errorHandler(e,trace);
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
    }).catchError(errorHandler);

    setState(ViewState.Idle);
  }

  errorHandler(dynamic e, StackTrace trace) {
    if (e is SocketException) {
      flashMessage = "Network error, please try again";
    } else {
      flashMessage = "Unhandled Error : $e";
    }
  }
}
