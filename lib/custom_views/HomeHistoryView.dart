import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_clone/utils/BaseMisc.dart';
import 'package:zoom_clone/utils/Utils.dart';
import 'package:zoom_clone/utils/size_config.dart';

class HomeHistoryView extends StatelessWidget {
  int pos;
  Function(int) onHistoryClicked;

  HomeHistoryView(this.pos, {this.onHistoryClicked});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: pos == 0
              ? SizeConfig.safeBlockVertical * 4
              : SizeConfig.safeBlockVertical * 3),
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            child: Padding(
                padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Design Daily Zoom Meeting",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil()
                                  .setSp(12, allowFontScalingSelf: true)),
                        ),
                        Text(
                          "10:00 - 11:30 | starts in 18hours",
                          style: TextStyle(
                              color: Colors.white.withAlpha(80),
                              fontSize: ScreenUtil()
                                  .setSp(8, allowFontScalingSelf: true)),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical * 3,
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
                            child: new Text('Start',
                                style: new TextStyle(
                                    fontSize: 16.0, color: Colors.white)),
                            onPressed: () => onHistoryClicked(pos),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
            onTap: () {},
          )),
      decoration: BoxDecoration(
          color: HexColor(BaseColors.darkBlueColor),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
