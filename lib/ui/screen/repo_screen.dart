import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:github_dashboard/core/model/repo.dart';
import 'package:github_dashboard/ui/shared/titled_container.dart';
import 'package:github_dashboard/ui/styling.dart';
import 'package:url_launcher/url_launcher.dart';

class RepoScreenArgument {
  final Repo repo;

  RepoScreenArgument({required this.repo});
}

class RepoScreen extends StatelessWidget {
  static const String route = "repo";

  final Repo repo;

  RepoScreen({Key? key, required this.repo}) : super(key: key);

  RepoScreen.withArgument({Key? key, required RepoScreenArgument argument})
      : this(key: key, repo: argument.repo);

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
          title: Text(
            repo.name,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        body: Container(
          color: lightGreyColor(),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              TitledContainer(
                title: "Stars",
                children: [
                  Text(repo.stargazersCount.toString()),
                ],
              ),
              if (repo.language != null) ...[
                SizedBox(height: 8.0),
                TitledContainer(
                  title: "Language",
                  children: [
                    Text(repo.language!),
                  ],
                ),
              ],
              if (repo.description != null) ...[
                SizedBox(height: 8.0),
                TitledContainer(
                  title: "Description",
                  children: [
                    Text(repo.description!),
                  ],
                ),
              ],
              SizedBox(height: 8.0),
              TitledContainer(
                title: "Link",
                children: [
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyText2!.apply(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                      text: repo.htmlUrl,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          var url = repo.htmlUrl;
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
