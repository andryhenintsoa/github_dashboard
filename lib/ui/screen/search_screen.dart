import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:github_dashboard/core/base_view.dart';
import 'package:github_dashboard/core/enum/view_state.dart';
import 'package:github_dashboard/core/viewmodel/search_model.dart';
import 'package:github_dashboard/ui/screen/repo_screen.dart';
import 'package:github_dashboard/ui/styling.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  late ScrollController _scrollController;

  late SearchModel currentModel;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  _scrollListener() async {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      print("bottom reached");
      await currentModel.getNextRepos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (currentModel.user != null) {
            currentModel.goSearch();
            return false;
          }
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 4.0,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                color: mainTextColor(),
              ),
            ),
            title: Text(
              "Github Dashboard",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          body: Container(
            color: lightGreyColor(),
            width: double.infinity,
            height: double.infinity,
            child: BaseView<SearchModel>(builder: (context, model, child) {
              currentModel = model;

              if (model.flashMessage != null) {
                Fluttertoast.showToast(
                  msg: model.flashMessage!,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black54,
                  textColor: Colors.white,
                );
                model.flashMessage = null;
              }

              if (model.user != null) {
                return Column(
                  children: [
                    SizedBox(height: 8.0),
                    Chip(
                      deleteIcon: Icon(Icons.close),
                      onDeleted: () {
                        model.goSearch();
                      },
                      avatar: (model.user!.avatarUrl == null)
                          ? null
                          : Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                image: DecorationImage(
                                  image: NetworkImage(model.user!.avatarUrl!),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                      label: Text(model.user!.name ?? model.user!.login),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        itemCount: model.repos.length,
                        itemBuilder: (BuildContext context, int index) {
                          var e = model.repos[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Material(
                              child: ListTile(
                                onTap: () {
                                  print("here");
                                  Navigator.pushNamed(context, RepoScreen.route,
                                      arguments: RepoScreenArgument(repo: e));
                                },
                                leading: Icon(Icons.inbox),
                                title: Text(
                                  e.name,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }

              return Column(
                children: [
                  Spacer(),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: ConstrainedBox(
                            constraints: BoxConstraints.expand(height: 48.0),
                            child: Material(
                              elevation: 2,
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextField(
                                  controller: searchController,
                                  style: Theme.of(context).textTheme.bodyText2,
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  textCapitalization: TextCapitalization.none,
                                  autocorrect: false,
                                  decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Username",
                                    hintStyle: new TextStyle(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Container(
                          height: 48.0,
                          width: 100,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 2,
                              primary: accentColor(),
                              shadowColor: lightGreyColor(),
                            ),
                            onPressed: () {
                              model.searchUser(searchController.text);
                            },
                            child: model.state == ViewState.Busy
                                ? SpinKitThreeBounce(
                                    size: 20,
                                    color: Colors.white,
                                  )
                                : Text("Search"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
