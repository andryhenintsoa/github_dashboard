import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:github_dashboard/core/base_view.dart';
import 'package:github_dashboard/core/enum/view_state.dart';
import 'package:github_dashboard/core/model/user.dart';
import 'package:github_dashboard/core/viewmodel/user_model.dart';
import 'package:github_dashboard/ui/screen/repo_screen.dart';
import 'package:github_dashboard/ui/shared/shimmer_container.dart';
import 'package:github_dashboard/ui/styling.dart';
import 'package:shimmer/shimmer.dart';

class UserScreenArgument {
  final User user;

  UserScreenArgument({required this.user});
}

class UserScreen extends StatefulWidget {
  static const String route = "user";

  final User user;

  UserScreen({Key? key, required this.user}) : super(key: key);

  UserScreen.withArgument({Key? key, required UserScreenArgument argument})
      : this(key: key, user: argument.user);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late ScrollController _scrollController;
  late UserModel currentModel;

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
      await currentModel.getNextRepos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 4.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: mainTextColor(),
            ),
          ),
          title: Row(
            children: [
              if (widget.user.avatarUrl != null) ...[
                Container(
                  height: 36.0,
                  width: 36.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(widget.user.avatarUrl!),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
              ],
              Text(
                widget.user.name ?? widget.user.login,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
        body: Container(
          color: lightGreyColor(),
          width: double.infinity,
          height: double.infinity,
          child: BaseView<UserModel>(
            onModelReady: (model) {
              model.setUser(widget.user);
              model.searchRepositoryForCurrentUser();
            },
            builder: (context, model, child) {
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

              if (model.state == ViewState.Busy && model.repos.isEmpty)
                return ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  shrinkWrap: true,
                  itemCount: 6,
                  itemBuilder: (_, __) => Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 16.0,
                      ),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[200]!,
                        highlightColor: Colors.grey[100]!,
                        enabled: true,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(Icons.inbox),
                            SizedBox(width: 32),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ShimmerContainer.text(
                                    width: 100,
                                    randomRangeWidth: 200,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              return ListView.builder(
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
              );
            },
          ),
        ),
      ),
    );
  }
}
