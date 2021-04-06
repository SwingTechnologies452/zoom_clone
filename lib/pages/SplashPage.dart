import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:zoom_clone/base_class/BaseScreenState.dart';
import 'package:zoom_clone/models/user_model.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends BaseScreenState<SplashPage> {
  bool _isLogged = false;

  @override
  void baseMethod() {
    _isLogged = Hive.box<AuthUser>('user').get('0') != null ? true : false;
  }

  @override
  Widget onCreateMobileWidget(int screenType, BuildContext buildContext) {
    return Scaffold(
      body: Container(),
    );
  }

  @override
  Widget onCreateWebWidget(int screenType, BuildContext buildContext) {
    return Scaffold(
      body: _isLogged
          ? Container(
              child: Text("Logged IN"),
            )
          : Container(
              child: Text("Logged OUT"),
            ),
    );
  }

  @override
  void onDisposeMethod() {}

  @override
  bool isCancelable() {
    return false;
  }
}
