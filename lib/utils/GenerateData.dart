import 'package:flutter/material.dart';
import 'package:zoom_clone/pages/ui/FeedBackPage.dart';
import 'package:zoom_clone/pages/ui/HistoryPage.dart';
import 'package:zoom_clone/pages/ui/HomePage.dart';
import 'package:zoom_clone/pages/ui/MessagePage.dart';
import 'package:zoom_clone/pages/ui/ProfilePage.dart';
import 'package:zoom_clone/pages/ui/SchedulePage.dart';
import 'package:zoom_clone/utils/BaseMisc.dart';

class GenerateData {
  static List<String> homeBtnIconData() {
    var dataList = [
      BaseStrings.CAMERA_HOME_ICON,
      BaseStrings.MEETING_HOME_ICON,
      BaseStrings.CALENDAR_HOME_ICON,
      BaseStrings.SHARE_HOME_ICON
    ];
    return dataList;
  }

  static homeBtnTitleData() {
    var dataList = [
      "New Meeting",
      "Join Meeting",
      "Schedule",
      "Share Screen"
    ];
    return dataList;
  }

  static homeBtnSubData() {
    var dataList = [
      "\nset up new meeting",
      "\nvia invitation link",
      "\nplan your meetings",
      "\nshow your work"
    ];
    return dataList;
  }

  static List<IconData> sideListData() {
    List<IconData> dataList = [
      Icons.home,
      // Icons.message,
      Icons.access_time,
      Icons.person_rounded,
      Icons.lightbulb_outline,
      Icons.calendar_today_outlined
    ];
    return dataList;
  }

  static fragmentList() {
    var fragList = [
      HomePage(),
      // MessagePage(),
      HistoryPage(),
      ProfilePage(),
      FeedBackPage(),
      SchedulePage(),
    ];
    return fragList;
  }
}
