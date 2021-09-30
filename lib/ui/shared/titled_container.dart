
import 'package:flutter/material.dart';

import '../styling.dart';

class TitledContainer extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final double distanceBetweenChildren;

  static final double horizontalPadding = 32.0;

  const TitledContainer({
    Key? key,
    required this.children,
    required this.title,
    this.distanceBetweenChildren = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> containerChildren = [];
    containerChildren.add(
      Container(
        margin: EdgeInsets.only(bottom: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 4,
              height: 30,
              margin: EdgeInsets.only(right: 8.0),
              decoration: BoxDecoration(
                color: accentColor(),
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
            ),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
    );
    bool isFirst = true;
    for (Widget item in children) {
      if (!isFirst) {
        containerChildren.add(
          SizedBox(
            height: distanceBetweenChildren,
          ),
        );
      }
      containerChildren.add(item);
      isFirst = false;
    }

    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: horizontalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: containerChildren,
      ),
    );
  }
}
