import 'dart:io';

import 'package:github_dashboard/core/enum/view_state.dart';
import 'package:github_dashboard/core/model/repo.dart';
import 'package:github_dashboard/core/model/user.dart';
import 'package:github_dashboard/core/service/api.dart';

import '../base_model.dart';
import '../service_locator.dart';

class UserModel extends BaseModel {
  Api _api = locator<Api>();
  String? flashMessage;
  User? user;
  List<Repo> repos = [];

  int _currentPage = 0;
  bool _isFetchingData = false;

  void setUser(User user) {
    this.user = user;
  }

  Future searchRepositoryForCurrentUser({int? page}) async {
    setState(ViewState.Busy);
    setState(ViewState.Busy);
    if (user?.reposUrl == null) {
      repos = [];
      return;
    }

    if(page == null){
      // If page == null, it the first time to get user's repos
      repos = [];
      _currentPage = 1;
    }
    else{
      // Else, it's a loading of next repos (according to pagination)
      // so, no reinit of repos list
      _currentPage = page;
    }

    await _api.getRepository(user!, page: _currentPage).then((result) {
      if (result != null) {
        repos.addAll(result);
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

  ///Fetching the next posts
  ///
  ///[_isFetchingData] is used to prevent fetching the same data
  ///[_currentPage] is incremented as we are searching the next data
  Future getNextRepos() async {
    if (_isFetchingData) return;
    _isFetchingData = true;
    await searchRepositoryForCurrentUser(page: _currentPage + 1);
    _isFetchingData = false;
  }

}
