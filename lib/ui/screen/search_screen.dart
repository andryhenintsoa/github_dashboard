import 'package:flutter/material.dart';
import 'package:github_dashboard/core/base_view.dart';
import 'package:github_dashboard/core/viewmodel/search_model.dart';
import 'package:github_dashboard/ui/styling.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  SearchScreen({Key? key}) : super(key: key);

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


            if (model.user != null) {
              return Chip(
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
                      ConstrainedBox(
                        constraints: BoxConstraints(minHeight: 48.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 2,
                            primary: accentColor(),
                            shadowColor: lightGreyColor(),
                          ),
                          onPressed: () {
                            model.searchUser(searchController.text);
                          },
                          child: Text("Search"),
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

class CityButton extends StatelessWidget {
  const CityButton({Key? key, required this.text, this.onTap})
      : super(key: key);

  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(height: 48.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shadowColor: lightGreyColor(),
          ),
          onPressed: () {
            onTap?.call();
          },
          child: Text(this.text,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .apply(color: Colors.black)),
        ),
      ),
    );
  }
}
