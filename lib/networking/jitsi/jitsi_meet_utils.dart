/*
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

class JitsiMeetUtils {
  */
/*below properties for meeting*//*

  var isAudioOnly = false;
  var isAudioMuted = true;
  var isVideoMuted = false;
  String serverUrl;

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
        ..room = "myroom" // Required, spaces will be trimmed
        ..serverURL = "https://meet.jit.si/"
        ..subject = "Meeting with Gunschu"
        ..userDisplayName = "My Name"
        ..userEmail = "myemail@email.com"
        ..userAvatarURL = "https://someimageurl.com/image.jpg" // or .png
        ..audioOnly = true
        ..audioMuted = true
        ..videoMuted = true
        ..featureFlags = featureFlags;

      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  */
/*joinMeeting({String roomCode,String nameText}) async {
    //fetch serverUrl from hiveBox
    if(Hive.box<GetConfigModel>('getConfigbox').getAt(0).appConfig.jitsiServer != null && Hive.box<GetConfigModel>('getConfigbox').getAt(0).appConfig.jitsiServer != ""){
       serverUrl =  Hive.box<GetConfigModel>('getConfigbox').getAt(0).appConfig.jitsiServer;
    }
    try {
      // Enable or disable any feature flag here
      // If feature flag are not provided, default values will be used
      // Full list of feature flags (and defaults) available in the README
      Map<FeatureFlagEnum, bool> featureFlags =
      {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED : false,
      };
      // Here is an example, disabling features for each platform
      if (Platform.isAndroid)
      {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      }

      featureFlags[FeatureFlagEnum.INVITE_ENABLED] = false;

      var options = JitsiMeetingOptions()
        ..room = roomCode
        ..serverURL = serverUrl
//        ..subject = subjectText.text
        ..userDisplayName = nameText
//        ..userEmail = emailText.text
 //       ..iosAppBarRGBAColor = CustomTheme.iosMeetingAppBarRGBAColor
        ..featureFlags = featureFlags
        ..audioOnly = isAudioOnly
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;

      debugPrint("JitsiMeetingOptions: $options");
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
  hostMeeting({String roomCode,String meetingTitle,}) async {
    //fetch serverUrl from hiveBox
    if(Hive.box<GetConfigModel>('getConfigbox').getAt(0).appConfig.jitsiServer != null && Hive.box<GetConfigModel>('getConfigbox').getAt(0).appConfig.jitsiServer != ""){
      serverUrl =  Hive.box<GetConfigModel>('getConfigbox').getAt(0).appConfig.jitsiServer;
    }
    try {
      // Enable or disable any feature flag here
      // If feature flag are not provided, default values will be used
      // Full list of feature flags (and defaults) available in the README
      Map<FeatureFlagEnum, bool> featureFlags =
      {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED : false,
      };
      // Here is an example, disabling features for each platform
      if (Platform.isAndroid)
      {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      }
      featureFlags[FeatureFlagEnum.INVITE_ENABLED] = false;
      var options = JitsiMeetingOptions()
        ..room = roomCode
        ..serverURL = serverUrl
        ..subject = meetingTitle
//        ..userDisplayName = nameText
//        ..userEmail = emailText.text
//        ..iosAppBarRGBAColor = CustomTheme.iosMeetingAppBarRGBAColor
        ..featureFlags = featureFlags
        ..audioOnly = isAudioOnly
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;

      debugPrint("JitsiMeetingOptions: $options");
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
  }*//*

  void onConferenceWillJoin({message}) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void onConferenceJoined({message}) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void onConferenceTerminated({message}) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}
*/
