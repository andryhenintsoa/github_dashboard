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
              if (repo.language != null) ...[
                SizedBox(height: 8.0),
                TitledContainer(
                  title: "Language",
                  children: [
                    Text(repo.language!),
                  ],
                )
              ],
              if (repo.language != null) ...[
                SizedBox(height: 8.0),
                TitledContainer(
                  title: "Description",
                  children: [
                    Text(repo.description!),
                  ],
                ),
              ],
            ],
          ),
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
