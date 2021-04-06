import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_clone/base_class/BaseScreenState.dart';
import 'package:zoom_clone/utils/BaseMisc.dart';
import 'package:zoom_clone/utils/GenerateData.dart';
import 'package:zoom_clone/utils/Utils.dart';
import 'package:zoom_clone/utils/size_config.dart';

class MainPage extends StatefulWidget {
  MainState createState() => new MainState();
}

class MainState extends BaseScreenState<MainPage> {
  int _selectedIndex = 0;

  @override
  void baseMethod() {}

  @override
  bool isCancelable() {
    return false;
  }

  @override
  Widget onCreateWebWidget(int screenType, BuildContext buildContext) {
    return Scaffold(
        backgroundColor: HexColor(BaseColors.mainColor),
        body: Column(
          children: [
            Container(
              width: ScreenUtil().screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.topLeft,
                    child: Icon(
                      Icons.favorite,
                      size: SizeConfig.safeBlockVertical * 5,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    alignment: Alignment.topRight,
                    child: Text(
                      "Search by keywords",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil()
                              .setSp(8, allowFontScalingSelf: true)),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.black.withAlpha(120),
                        borderRadius: BorderRadius.circular(
                            SizeConfig.safeBlockHorizontal * 1.2)),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.circle,
                      size: SizeConfig.safeBlockVertical * 5,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.white.withAlpha(20),
                      style: BorderStyle.solid)),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  NavigationRail(
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: (int index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    labelType: NavigationRailLabelType.selected,
                    selectedIconTheme: IconThemeData(
                      color: Colors.white
                    ),
                    selectedLabelTextStyle: TextStyle(
                      color: Colors.white
                    ),
                    unselectedIconTheme: IconThemeData(
                      color: Colors.white.withAlpha(50)
                    ),
                    backgroundColor: HexColor(BaseColors.mainColor),
                    destinations: <NavigationRailDestination>[
                      NavigationRailDestination(
                        icon: Icon(GenerateData.sideListData()[0]),
                        selectedIcon: Icon(GenerateData.sideListData()[0]),
                        label: Text('Home'),
                      ),
                      /*NavigationRailDestination(
                        icon: Icon(GenerateData.sideListData()[1]),
                        selectedIcon: Icon(GenerateData.sideListData()[1]),
                        label: Text('Message'),
                      ),*/
                      NavigationRailDestination(
                        icon: Icon(GenerateData.sideListData()[1]),
                        selectedIcon: Icon(GenerateData.sideListData()[1]),
                        label: Text('History'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(GenerateData.sideListData()[2]),
                        selectedIcon: Icon(GenerateData.sideListData()[2]),
                        label: Text('Profile'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(GenerateData.sideListData()[3]),
                        selectedIcon: Icon(GenerateData.sideListData()[3]),
                        label: Text('Feedback'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(GenerateData.sideListData()[4]),
                        selectedIcon: Icon(GenerateData.sideListData()[4]),
                        label: Text('Schedule'),
                      ),
                    ],
                  ),
                  VerticalDivider(
                    thickness: 1,
                    width: 1,
                    color: Colors.white.withAlpha(20),
                  ),
                  // This is the main content.
                  Expanded(
                    child: GenerateData.fragmentList()[_selectedIndex],
                  )
                ],
              ),
            )
          ],
        ));
  }

  @override
  Widget onCreateMobileWidget(screenType, context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: Text("Main Page"),
      ),
    ));
  }

  @override
  void onDisposeMethod() {}
}
