/*
 * Product by Swing Technologies.
 * Copyright (c) 1/3/2021.
 * Developed by Debojyoti Singha
 */

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_base_template/custom_views/ProgressBarDialog.dart';
import 'package:flutter_base_template/utils/BaseMisc.dart';
import 'package:flutter_base_template/utils/Helper.dart';
import 'package:flutter_base_template/utils/Utils.dart';
import 'package:flutter_base_template/utils/size_config.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class BaseScreenState<T extends StatefulWidget> extends State<T>
    with TickerProviderStateMixin {
  AnimationController _controller;
  ProgressBarDialog _progressDialog;

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
      child: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          if (connectivity == ConnectivityResult.none) {
            return Container(
                color: HexColor(BaseColors.mainColor),
                height: ScreenUtil().screenHeight,
                width: ScreenUtil().screenWidth,
                child: Center(
                  child: Text(
                    "No Internet.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ));
          }
          return child;
        },
        child: onCreateWidget(),
      ),
    );
  }

  void baseMethod();

  void onDisposeMethod();

  Widget onCreateWidget();

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
    print("BASE_MESSAGE: " + message);
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
