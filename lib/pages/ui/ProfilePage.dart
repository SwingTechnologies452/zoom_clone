import 'package:flutter/material.dart';
import 'package:zoom_clone/base_class/BaseScreenState.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ProfileState();
  }
}

class ProfileState extends BaseScreenState<ProfilePage> {
  @override
  void baseMethod() {}

  @override
  Widget onCreateMobileWidget(int screenType, BuildContext buildContext) {
    return Scaffold(
      body: Container(),
    );
  }

  @override
  Widget onCreateWebWidget(int screenType, BuildContext buildContext) {
    return Scaffold(
      body: Container(),
    );
  }

  @override
  void onDisposeMethod() {}

  @override
  bool isCancelable() {
    return false;
  }
}
