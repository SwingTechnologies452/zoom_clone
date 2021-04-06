import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_clone/base_class/BaseScreenState.dart';
import 'package:zoom_clone/custom_views/HistoryItemView.dart';
import 'package:zoom_clone/utils/BaseMisc.dart';
import 'package:zoom_clone/utils/Utils.dart';
import 'package:zoom_clone/utils/size_config.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HistoryState();
  }
}

class HistoryState extends BaseScreenState<HistoryPage> {
  int selectedIndex = -1;
  bool isSelected = false;

  final List<Map> data = List.generate(
      50,
      (index) => {
            'id': index,
            'name': 'Design Daily Zoom Meeting $index',
            'isSelected': false
          });

  Map<int, dynamic> indexStoredMap = new Map();

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
      backgroundColor: HexColor(BaseColors.mainColor),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: ScreenUtil().screenWidth / 4,
            margin: EdgeInsets.all(SizeConfig.safeBlockVertical * 2),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            child: Icon(
                              Icons.refresh,
                              color: Colors.white,
                            ),
                            onTap: () {},
                          )),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: HexColor(BaseColors.darkBlueColor),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    Container(
                      child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onTap: () {},
                          )),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: HexColor(BaseColors.darkBlueColor),
                          borderRadius: BorderRadius.circular(5)),
                    )
                  ],
                ),
                Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return HistoryItemView(
                            index,
                            onHistoryClicked: (pos) {
                              if (indexStoredMap[0] != index) {
                                indexStoredMap[0] = index;
                                selectedIndex = index;
                              } else {
                                indexStoredMap[0] = -1;
                                selectedIndex = -1;
                              }
                              setState(() {});
                            },
                            msg: data[index]['name'],
                            bgColor: indexStoredMap[0] != index
                                ? HexColor(BaseColors.darkBlueColor)
                                : HexColor(BaseColors.blueColor),
                          );
                        })),
              ],
            ),
          ),
          VerticalDivider(
            width: 1.0,
            color: Colors.white.withAlpha(20),
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.all(SizeConfig.safeBlockVertical * 6),
            child: selectedIndex != -1
                ? ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return meetingItemView(context, selectedIndex);
                    })
                : Center(
                    child: Text(
                      "Nothing Selected.",
                      style: TextStyle(
                          fontSize: ScreenUtil()
                              .setSp(40, allowFontScalingSelf: true),
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
          )),
        ],
      ),
    );
  }

  Widget meetingItemView(context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
            width: SizeConfig.screenWidth / 2,
            child: AutoSizeText(
              "Daily StandUp Tech Conference ${data[index]['name']}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(12, allowFontScalingSelf: true)),
              minFontSize: 20,
              maxLines: 1,
              overflow: TextOverflow.fade,
            )),
        SizedBox(
            width: SizeConfig.screenWidth / 2,
            child: AutoSizeText(
              "10:00 - 11:30 | starts in 18hours",
              style: TextStyle(
                  color: Colors.white.withAlpha(80),
                  fontSize: ScreenUtil().setSp(8, allowFontScalingSelf: true)),
              minFontSize: 16,
              maxLines: 1,
              overflow: TextOverflow.fade,
            )),
        Container(
          width: SizeConfig.screenWidth / 0.9,
          height: 1,
          margin: EdgeInsets.only(
              top: SizeConfig.safeBlockVertical * 2,
              bottom: SizeConfig.safeBlockVertical * 2),
          color: Colors.white.withAlpha(50),
        ),
        Row(
          children: [
            Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              elevation: 10.0,
              color: HexColor(BaseColors.blueColor),
              clipBehavior: Clip.antiAlias,
              // Add This
              child: MaterialButton(
                minWidth: SizeConfig.safeBlockHorizontal * 10,
                height: SizeConfig.safeBlockVertical * 6,
                color: HexColor(BaseColors.blueColor),
                child: new Text('Start',
                    style: new TextStyle(fontSize: 16.0, color: Colors.white)),
                onPressed: () {},
              ),
            ),
            SizedBox(
              width: SizeConfig.safeBlockHorizontal * 1.2,
            ),
            Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              elevation: 10.0,
              color: HexColor(BaseColors.blueColor),
              clipBehavior: Clip.antiAlias,
              // Add This
              child: MaterialButton(
                minWidth: SizeConfig.safeBlockHorizontal * 10,
                height: SizeConfig.safeBlockVertical * 6,
                color: HexColor(BaseColors.blueColor),
                child: new Text('Copy Invitation',
                    style: new TextStyle(fontSize: 16.0, color: Colors.white)),
                onPressed: () {},
              ),
            ),
          ],
        ),
        Container(
          width: SizeConfig.screenWidth / 0.9,
          height: 1,
          margin: EdgeInsets.only(
              top: SizeConfig.safeBlockVertical * 2,
              bottom: SizeConfig.safeBlockVertical * 2),
          color: Colors.white.withAlpha(50),
        ),
        SizedBox(
            width: SizeConfig.screenWidth / 0.9,
            child: AutoSizeText(
              "Everyday’s StandUp Meeting discussing all the team work and tasks done. Check out all team members and let them report about their progress.",
              style: TextStyle(
                  color: Colors.white.withAlpha(80),
                  fontSize: ScreenUtil().setSp(10, allowFontScalingSelf: true)),
              minFontSize: 20,
              maxLines: 2,
              overflow: TextOverflow.fade,
            )),
        Container(
          width: SizeConfig.screenWidth / 0.9,
          height: 1,
          margin: EdgeInsets.only(
              top: SizeConfig.safeBlockVertical * 2,
              bottom: SizeConfig.safeBlockVertical * 2),
          color: Colors.white.withAlpha(50),
        ),
        Center(
            child: AutoSizeText(
          "Meeting ID:",
          style: TextStyle(
              color: Colors.white.withAlpha(80),
              fontSize: ScreenUtil().setSp(8, allowFontScalingSelf: true)),
          minFontSize: 16,
          maxLines: 1,
          overflow: TextOverflow.fade,
        )),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 2,
        ),
        Center(
            child: AutoSizeText(
          "90464214",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil().setSp(16, allowFontScalingSelf: true)),
          minFontSize: 22,
          maxLines: 1,
          overflow: TextOverflow.fade,
        )),
        Container(
          width: SizeConfig.screenWidth / 0.9,
          height: 1,
          margin: EdgeInsets.only(
              top: SizeConfig.safeBlockVertical * 2,
              bottom: SizeConfig.safeBlockVertical * 2),
          color: Colors.white.withAlpha(50),
        ),
        Row(
          children: [
            Icon(
              Icons.perm_contact_calendar_outlined,
              color: Colors.white.withAlpha(80),
            ),
            SizedBox(
              width: SizeConfig.safeBlockHorizontal * 0.9,
            ),
            AutoSizeText(
              "Participants",
              style: TextStyle(
                  color: Colors.white.withAlpha(80),
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(10, allowFontScalingSelf: true)),
              minFontSize: 16,
              maxLines: 1,
              overflow: TextOverflow.fade,
            ),
          ],
        ),
        SizedBox(
            width: SizeConfig.screenWidth / 0.9,
            height: SizeConfig.safeBlockVertical * 20,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                      margin: EdgeInsets.all(SizeConfig.safeBlockVertical * 2),
                      padding: EdgeInsets.all(SizeConfig.safeBlockVertical * 2),
                      decoration: BoxDecoration(
                          color: index != 5
                              ? HexColor(BaseColors.darkBlueColor)
                              : HexColor(BaseColors.blueColor),
                          borderRadius: BorderRadius.circular(10)),
                      child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            child: index != 5
                                ? Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          "https://picsum.photos/250?image=9",
                                          height:
                                              SizeConfig.safeBlockVertical * 5,
                                          width:
                                              SizeConfig.safeBlockVertical * 5,
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            SizeConfig.safeBlockVertical * 1.3,
                                      ),
                                      SizedBox(
                                          width:
                                              SizeConfig.safeBlockHorizontal *
                                                  5,
                                          child: AutoSizeText(
                                            "User Random$index",
                                            style: TextStyle(
                                                color:
                                                    Colors.white.withAlpha(80),
                                                fontSize: ScreenUtil().setSp(6,
                                                    allowFontScalingSelf:
                                                        true)),
                                            minFontSize: 12,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.fade,
                                          )),
                                    ],
                                  )
                                : Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Icon(Icons.add),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.white.withAlpha(50),
                                            border: Border.all(
                                                color: Colors.white, width: 1)),
                                      ),
                                      SizedBox(
                                        height:
                                            SizeConfig.safeBlockVertical * 1.5,
                                      ),
                                      SizedBox(
                                          width:
                                              SizeConfig.safeBlockHorizontal *
                                                  5,
                                          child: AutoSizeText(
                                            "Invite Member",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: ScreenUtil().setSp(6,
                                                    allowFontScalingSelf:
                                                        true)),
                                            minFontSize: 12,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.fade,
                                          )),
                                    ],
                                  ),
                            onTap: () {},
                          )));
                }))
      ],
    );
  }

  @override
  void onDisposeMethod() {}

  @override
  bool isCancelable() {
    return false;
  }
}
