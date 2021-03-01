import 'package:flutter/material.dart';
import 'package:flutter_base_template/base_class/BaseScreenState.dart';

class MainPage extends StatefulWidget {
  MainState createState() => new MainState();
}

class MainState extends BaseScreenState {
  @override
  void baseMethod() {}

  @override
  bool isCancelable() {
    return false;
  }

  @override
  Widget onCreateWidget() {
    return Scaffold(
        body: Container(
      child: Center(
        child: Text("Main Page"),
      ),
    ));
  }

  @override
  void onDisposeMethod() {}
}
