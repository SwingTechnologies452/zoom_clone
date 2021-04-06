import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:zoom_clone/base_class/BaseScreenState.dart';
import 'package:zoom_clone/custom_views/HomeButtons.dart';
import 'package:zoom_clone/custom_views/HomeHistoryView.dart';
import 'package:zoom_clone/utils/BaseMisc.dart';
import 'package:zoom_clone/utils/Utils.dart';
import 'package:zoom_clone/utils/size_config.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}

class HomeState extends BaseScreenState<HomePage> {
  DateTime now = DateTime.now();
  DateFormat dateFormat = DateFormat("HH:mm");

  @override
  void baseMethod() {
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onPictureInPictureWillEnter: _onPictureInPictureWillEnter,
        onPictureInPictureTerminated: _onPictureInPictureTerminated,
        onError: _onError));
  }

  @override
  Widget onCreateMobileWidget(int screenType, BuildContext buildContext) {
    return Scaffold(
      backgroundColor: HexColor(BaseColors.mainColor),
      body: Container(),
    );
  }

  @override
  Widget onCreateWebWidget(int screenType, BuildContext buildContext) {
    return Scaffold(
      backgroundColor: HexColor(BaseColors.mainColor),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
            margin: EdgeInsets.all(SizeConfig.safeBlockVertical * 6),
            child: GridView.builder(
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: SizeConfig.safeBlockHorizontal * 3,
                childAspectRatio: MediaQuery.of(context).size.width /
                    1.4 /
                    (MediaQuery.of(context).size.height),
                mainAxisSpacing: SizeConfig.safeBlockHorizontal * 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                return new HomeButtons(
                  index,
                  onHomeButton: (pos) async {
                    // showToast(pos.toString());
                    if (pos == 0) {
                      Navigator.of(context).pushNamed("/jitsi");
                    }
                  },
                );
              },
            ),
          )),
          VerticalDivider(
            width: 1.0,
            color: Colors.white.withAlpha(20),
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.all(SizeConfig.safeBlockVertical * 6),
            child: ListView(
              physics: ScrollPhysics(),
              children: [
                Container(
                    width: ScreenUtil().screenWidth,
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        WebsafeSvg.asset(BaseStrings.BG_HOME_ICON),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              padding: EdgeInsets.only(left: 10, bottom: 10),
                              child: new RichText(
                                textAlign: TextAlign.center,
                                text: new TextSpan(
                                  text:
                                      "${now.hour.toString()} : ${now.minute.toString()}",
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(28,
                                          allowFontScalingSelf: true)),
                                  children: <TextSpan>[
                                    new TextSpan(
                                        text: "\nThursday, 28 March 1996",
                                        style: new TextStyle(
                                            color: Colors.white.withAlpha(120),
                                            fontSize: ScreenUtil().setSp(8,
                                                allowFontScalingSelf: true))),
                                  ],
                                ),
                              ),
                            )),
                        /* Align(
                          alignment: Alignment.centerRight,
                          child: SvgPicture.asset(
                            BaseStrings.FLOWER_HOME_ICON,
                            height: SizeConfig.safeBlockVertical * 15,
                            width: SizeConfig.safeBlockHorizontal * 14,
                          ),
                        )*/
                      ],
                    )),
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  primary: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (buildContext, pos) {
                    return HomeHistoryView(pos, onHistoryClicked: (pos) {
                      showToast(pos.toString());
                    });
                  },
                )
              ],
            ),
          )),
        ],
      ),
    );
  }

  joinMeeting() async {
    try {
      // Enable or disable any feature flag here
      // If feature flag are not provided, default values will be used
      // Full list of feature flags (and defaults) available in the README
      Map<FeatureFlagEnum, bool> featureFlags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      };
      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      }
      featureFlags[FeatureFlagEnum.INVITE_ENABLED] = false;

      var options = JitsiMeetingOptions()
        ..room = "90465214"
        ..serverURL = "https://meet.jit.si/"
        ..subject = "HELLO"
//        ..userDisplayName = nameText
//        ..userEmail = emailText.text
//        ..iosAppBarRGBAColor = CustomTheme.iosMeetingAppBarRGBAColor
        ..featureFlags = featureFlags
        ..audioOnly = true
        ..audioMuted = true
        ..videoMuted = true;

      await JitsiMeet.joinMeeting(
        options,
        listener: JitsiMeetingListener(onConferenceWillJoin: ({message}) {
          debugPrint("${options.room} will join with message: $message");
        }, onConferenceJoined: ({message}) {
          debugPrint("${options.room} joined with message: $message");
        }, onConferenceTerminated: ({message}) {
          debugPrint("${options.room} terminated with message: $message");
        }),
        // by default, plugin default constraints are used
        //roomNameConstraints: new Map(), // to disable all constraints
        //roomNameConstraints: customContraints, // to use your own constraint(s)
      );
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  @override
  void onDisposeMethod() {
    JitsiMeet.removeAllListeners();
  }

  @override
  bool isCancelable() {
    return false;
  }

  _onConferenceWillJoin({message}) {
    debugPrint("_onConferenceWillJoin broadcasted");
  }

  _onConferenceJoined({message}) {
    debugPrint("_onConferenceJoined broadcasted");
  }

  _onConferenceTerminated({message}) {
    debugPrint("_onConferenceTerminated broadcasted");
  }

  _onPictureInPictureWillEnter({message}) {
    debugPrint(
        "_onPictureInPictureWillEnter broadcasted with message: $message");
  }

  _onPictureInPictureTerminated({message}) {
    debugPrint(
        "_onPictureInPictureTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted");
  }
}
