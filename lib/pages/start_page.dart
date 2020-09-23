import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var primaryTextTheme = Theme.of(context).primaryTextTheme;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  child: Text(
                "Welcome to SPA Coding challenge",
                style: primaryTextTheme.headline5,
                textAlign: TextAlign.center,
              )),
            ],
          ),
        ],
      ),
    );
  }
}
