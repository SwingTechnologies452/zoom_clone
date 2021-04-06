import 'package:auth_buttons/res/buttons/google_auth_button.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zoom_clone/base_class/BaseScreenState.dart';
import 'package:zoom_clone/networking/Config.dart';
import 'package:zoom_clone/pages/auth/FirebaseAuthService.dart';
import 'package:zoom_clone/pages/auth/authentication_service.dart';
import 'package:zoom_clone/utils/BaseMisc.dart';
import 'package:zoom_clone/utils/Utils.dart';
import 'package:zoom_clone/utils/size_config.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    // 'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends BaseScreenState<LoginPage> {
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
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Config.enableGoogleAuth
              ? GoogleAuthButton(
                  onPressed: () async {
                    await FirebaseAuthService()
                        .signInWithGoogle()
                        .then((value) {
                      if (value.email != null) {
                        AuthService().updateUser(value);
                        Navigator.of(context).pushReplacementNamed("/mainPage");
                      } else {
                        FirebaseAuthService().signOut();
                        showToast("Error in login");
                      }
                    });
                  },
                  darkMode: false,
                  // iconStyle: AuthIconStyle.secondary,
                )
              : Container(),
          SizedBox(
            height: SizeConfig.safeBlockVertical * 5,
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
                child: new Text('Access Without Login',
                    style: new TextStyle(fontSize: 16.0, color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("/mainPage");
                },
              )),
        ],
      )),
    );
  }

  @override
  void onDisposeMethod() {}

  @override
  bool isCancelable() {
    return false;
  }
}
