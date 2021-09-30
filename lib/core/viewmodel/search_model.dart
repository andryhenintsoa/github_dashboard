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

  int _currentPage = 0;
  bool _isFetchingData = false;

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

  Future searchRepositoryForCurrentUser({int? page}) async {
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
