/*
 * Product by Swing Technologies.
 * Copyright (c) 1/3/2021.
 * Developed by Debojyoti Singha
 */

import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_template/utils/BaseMisc.dart';
import 'package:flutter_base_template/utils/Utils.dart';

class ProgressBarDialog {
  /// BuildContext to show dialog in
  final BuildContext context;

  /// Main widget of dialog,
  final Widget loadingWidget;

  /// Whether dialog can dismiss by touching outside or not
  final bool dismissable;

  /// This function will trigger when user dismisses dialog
  final Function onDismiss;

  /// Amount of background blur
  final double blur;

  /// Dialog's background color
  final Color backgroundColor;

  /// Using safe area, dialog will keep padding from status bar, navigation bar and ...
  final bool useSafeArea;

  /// Duration of blur and background color animation
  final Duration animationDuration;

  /// Is dialog showing or not
  bool _isShowing = false;

  /// Dialog widget instance
  _ProgressBarDialogWidget _progressDialogWidget;

  /// Getter for _isShowing
  bool get isShowing => _isShowing;

  /// Animation Controller
  final AnimationController animationController;

  ProgressBarDialog(
    this.context, {
    this.backgroundColor: const Color(0x99000000),
    this.blur: 0,
    this.dismissable: true,
    this.onDismiss,
    this.loadingWidget,
    this.useSafeArea: false,
    this.animationController,
    this.animationDuration: const Duration(milliseconds: 300),
  }) {
    _initProgress();
  }

  /// Initialize dialog's instance
  void _initProgress() {
    _progressDialogWidget = _ProgressBarDialogWidget(
      blur: blur,
      dismissable: dismissable,
      backgroundColor: backgroundColor,
      onDismiss: onDismiss,
      loadingWidget: loadingWidget,
      animationController: animationController,
      animationDuration: animationDuration,
    );
  }

  /// Show progress dialog
  void show() async {
    if (!_isShowing) {
      _isShowing = true;
      if (_progressDialogWidget == null) _initProgress();
      await showDialog(
        useSafeArea: useSafeArea,
        context: context,
        barrierDismissible: dismissable ?? true,
        builder: (context) => _progressDialogWidget,
        barrierColor: Colors.transparent,
      );
      _isShowing = false;
    }
  }

  /// Dismiss progress dialog
  void dismiss() {
    if (_isShowing) {
      _isShowing = false;
      Navigator.pop(context);
    }
  }
}

// ignore: must_be_immutable
class _ProgressBarDialogWidget extends StatelessWidget {
  /// Main widget of dialog,
  Widget loadingWidget;

  /// This function will trigger when user dismisses dialog
  final Function onDismiss;

  /// Amount of background blur
  final double blur;

  /// Dialog's background color
  final Color backgroundColor;

  /// Whether dialog can dismiss by touching outside or not
  final bool dismissable;

  /// Duration of blur and background color animation
  final Duration animationDuration;

  /// Animation Controller
  final AnimationController animationController;

  _ProgressBarDialogWidget({
    this.dismissable,
    this.onDismiss,
    this.backgroundColor,
    this.loadingWidget,
    this.blur,
    this.animationController,
    this.animationDuration: const Duration(milliseconds: 300),
  }) {
    animationController.duration = Duration(seconds: 2);
    animationController.repeat();
    loadingWidget = loadingWidget ??
        Container(
            padding: EdgeInsets.all(10.0),
            height: 120.0,
            width: 120.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Center(
                child: CircularProgressIndicator(
              valueColor: animationController.drive(ColorTween(
                  begin: HexColor(BaseColors.mainColor),
                  end: HexColor(BaseColors.lightPurpleColor))),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return _DialogBackground(
      blur: blur,
      dismissable: dismissable ?? true,
      onDismiss: onDismiss,
      color: backgroundColor,
      animationDuration: animationDuration,
      dialog: Padding(
        padding: MediaQuery.of(context).viewInsets +
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: Center(
          child: loadingWidget,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _DialogBackground extends StatelessWidget {
  /// Widget of dialog, you can use NDialog, Dialog, AlertDialog or Custom your own Dialog
  final Widget dialog;

  /// Because blur dialog cover the barrier, you have to declare here
  final bool dismissable;

  /// Action before dialog dismissed
  final Function onDismiss;

  /// Creates an background filter that applies a Gaussian blur.
  /// Default = 0
  final double blur;

  /// Background color
  final Color color;

  /// Animation Duration
  final Duration animationDuration;

  /// Color Opacity
  double _colorOpacity;

  _DialogBackground(
      {this.dialog,
      this.dismissable,
      this.blur,
      this.onDismiss,
      this.animationDuration: const Duration(milliseconds: 300),
      this.color}) {
    _colorOpacity = color.opacity;
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: animationDuration,
        builder: (context, val, child) {
          return Material(
            type: MaterialType.canvas,
            color: color.withOpacity(val * _colorOpacity),
            child: WillPopScope(
              onWillPop: () async {
                if (dismissable ?? true) {
                  if (onDismiss != null) onDismiss();
                  Navigator.pop(context);
                }
                return;
              },
              child: Stack(
                clipBehavior: Clip.antiAlias,
                alignment: Alignment.center,
                children: <Widget>[
                  GestureDetector(
                      onTap: dismissable ?? true
                          ? () {
                              if (onDismiss != null) {
                                onDismiss();
                              }
                              Navigator.pop(context);
                            }
                          : () {},
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: val * blur,
                          sigmaY: val * blur,
                        ),
                        child: Container(
                          color: Colors.transparent,
                        ),
                      )),
                  dialog
                ],
              ),
            ),
          );
        });
  }
}

class GradientCircularProgressIndicator extends StatelessWidget {
  final double strokeWidth;
  final bool strokeRound;
  final double value;
  final Color backgroundColor;
  final List<Color> gradientColors;
  final List<double> gradientStops;
  final double radius;

  /// Constructor require progress [radius] & gradient color range [gradientColors]
  /// , option includes: circle width [strokeWidth], round support [strokeRound]
  /// , progress background [backgroundColor].
  ///
  /// set progress with [value], 0.0 to 1.0.
  GradientCircularProgressIndicator({
    this.strokeWidth = 10.0,
    this.strokeRound = false,
    @required this.radius,
    @required this.gradientColors,
    this.gradientStops,
    this.backgroundColor = Colors.transparent,
    this.value,
  });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }

  @override
  Widget build(BuildContext context) {
    var _colors = gradientColors;
    if (_colors == null) {
      Color color = Theme.of(context).accentColor;
      _colors = [color, color];
    }

    return Transform.rotate(
      angle: -pi / 2,
      child: CustomPaint(
        size: Size.fromRadius(radius),
        painter: _GradientCircularProgressPainter(
            strokeWidth: strokeWidth,
            strokeRound: strokeRound,
            backgroundColor: backgroundColor,
            gradientColors: _colors,
            value: value,
            radius: radius),
      ),
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  _GradientCircularProgressPainter({
    this.strokeWidth,
    this.strokeRound,
    this.value,
    this.backgroundColor = Colors.transparent,
    this.gradientColors,
    this.gradientStops,
    this.total = 2 * pi,
    this.radius,
  });

  final double strokeWidth;
  final bool strokeRound;
  final double value;
  final Color backgroundColor;
  final List<Color> gradientColors;
  final List<double> gradientStops;
  final double total;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    if (radius != null) {
      size = Size.fromRadius(radius);
    }

    double _value = (value ?? .0);
    _value = _value.clamp(.0, 1.0) * total;
    double _start = .0;

    double _offset = strokeWidth / 2;
    Rect rect = Offset(_offset, _offset) &
        Size(size.width - strokeWidth, size.height - strokeWidth);

    var paint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    if (backgroundColor != Colors.transparent) {
      paint.color = backgroundColor;
      canvas.drawArc(rect, _start, total, false, paint);
    }

    if (_value > 0) {
      paint.shader = SweepGradient(
              colors: gradientColors,
              startAngle: 0.0,
              endAngle: _value,
              stops: gradientStops)
          .createShader(rect);

      canvas.drawArc(rect, _start, _value, false, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
