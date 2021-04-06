import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:zoom_clone/utils/BaseMisc.dart';
import 'package:zoom_clone/utils/GenerateData.dart';
import 'package:zoom_clone/utils/Utils.dart';
import 'package:zoom_clone/utils/size_config.dart';

class HomeButtons extends StatelessWidget {
  int index;
  final Function(int) onHomeButton;

  HomeButtons(this.index, {this.onHomeButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => onHomeButton(index),
            child: Container(
                padding: EdgeInsets.all(SizeConfig.safeBlockVertical * 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 1.2, left: 1),
                        width: SizeConfig.safeBlockHorizontal * 6,
                        // height: SizeConfig.safeBlockVertical * 7,
                        child: Center(
                            child: WebsafeSvg.asset(
                          GenerateData.homeBtnIconData()[index],
                          width: SizeConfig.safeBlockHorizontal * 6,
                          height: SizeConfig.safeBlockVertical * 6,
                        )),
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white.withAlpha(50),
                            border: Border.all(color: Colors.white, width: 1))),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 4,
                    ),
                    new RichText(
                      text: new TextSpan(
                        text: GenerateData.homeBtnTitleData()[index],
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: ScreenUtil()
                                .setSp(10, allowFontScalingSelf: true)),
                        children: <TextSpan>[
                          new TextSpan(
                              text: GenerateData.homeBtnSubData()[index],
                              style: new TextStyle(
                                  color: Colors.white.withAlpha(120),
                                  fontSize: ScreenUtil()
                                      .setSp(8, allowFontScalingSelf: true))),
                        ],
                      ),
                    ),
                  ],
                )),
          )),
      decoration: BoxDecoration(
          color: index / 2 != 0
              ? HexColor(BaseColors.blueColor)
              : HexColor(BaseColors.orangeColor),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
