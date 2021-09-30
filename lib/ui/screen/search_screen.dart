import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:github_dashboard/core/base_view.dart';
import 'package:github_dashboard/core/enum/view_state.dart';
import 'package:github_dashboard/core/viewmodel/search_model.dart';
import 'package:github_dashboard/ui/screen/user_screen.dart';
import 'package:github_dashboard/ui/styling.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            if (model.flashMessage != null) {
              Fluttertoast.showToast(
                msg: model.flashMessage!,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black54,
                textColor: Colors.white,
              );
              model.flashMessage = null;
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
                            borderRadius: BorderRadius.all(Radius.circular(4)),
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
                            model.searchUser(
                              searchController.text,
                              onSuccess: (user) {
                                Navigator.pushNamed(context, UserScreen.route,
                                    arguments: UserScreenArgument(user: user));
                              },
                            );
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
    );
  }
}
