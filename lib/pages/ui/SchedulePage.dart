import 'package:flutter/material.dart';
import 'package:zoom_clone/base_class/BaseScreenState.dart';

class SchedulePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ScheduleState();
  }
}

class ScheduleState extends BaseScreenState<SchedulePage> {
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
