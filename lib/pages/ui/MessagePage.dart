import 'package:flutter/material.dart';
import 'package:zoom_clone/base_class/BaseScreenState.dart';

class MessagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MessageState();
  }
}

class MessageState extends BaseScreenState<MessagePage> {
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
