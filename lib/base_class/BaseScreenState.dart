/*
 * Product by Swing Technologies.
 * Copyright (c) 1/3/2021.
 * Developed by Debojyoti Singha
 */
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:zoom_clone/custom_views/ProgressBarDialog.dart';
import 'package:zoom_clone/utils/Helper.dart';
import 'package:zoom_clone/utils/size_config.dart';

abstract class BaseScreenState<T extends StatefulWidget> extends State<T>
    with TickerProviderStateMixin {
  AnimationController _controller;
  ProgressBarDialog _progressDialog;
  int screenType = -1;

  BaseScreenState() {
    // Parent constructor
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
    SizeConfig().init(context);

    return isCancelable()
        ? defaultWidget()
        : WillPopScope(
            onWillPop: Helper.of(context).onWillPop, child: defaultWidget());
  }

  Widget defaultWidget() {
    return SafeArea(
      child: Builder(builder: (context) {
        if (UniversalPlatform.isWeb) {
          screenType = 1;
          return onCreateWebWidget(screenType, context);
        } else {
          screenType = 2;
          return onCreateMobileWidget(screenType, context);
        }
      }),
    );
  }

  void baseMethod();

  void onDisposeMethod();

  Widget onCreateMobileWidget(int screenType, BuildContext buildContext);

  Widget onCreateWebWidget(int screenType, BuildContext buildContext);

  bool isCancelable();

  AnimationController getAnimController() {
    return _controller;
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    baseMethod();

    _progressDialog = ProgressBarDialog(context,
        blur: 2,
        backgroundColor: Color(0x33000000),
        animationController: _controller,
        animationDuration: Duration(milliseconds: 500));

    super.initState();
  }

  @override
  void dispose() {
    onDisposeMethod();
    _controller.dispose();
    super.dispose();
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message, timeInSecForIosWeb: 2, gravity: ToastGravity.CENTER);
  }

  void showLog(String msg) {
    if (!Foundation.kReleaseMode) {
      print("BASE_MESSAGE: " + msg);
    }
  }

  void showProgressBar() {
    if (!_progressDialog.isShowing) {
      _progressDialog.show();
    }
  }

  void dismissProgressBar() {
    if (_progressDialog.isShowing) {
      _progressDialog.dismiss();
    }
  }

  String getDeviceType() {
    if (Platform.isAndroid) {
      // Android-specific code/UI Component
      return "Android";
    } else if (Platform.isIOS) {
      // iOS-specific code/UI Component
      return "iOS";
    } else {
      return "ERROR";
    }
  }
}
