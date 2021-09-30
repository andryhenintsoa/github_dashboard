import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  static const route = 'loadingscreen';

  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/');
        },
        child: FractionallySizedBox(
          widthFactor: 2 / 3,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    color: Colors.white,
                    child: Container(
                      margin: EdgeInsets.all(32.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage("assets/images/logo.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
