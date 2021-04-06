import 'package:auth_buttons/res/buttons/google_auth_button.dart';
import 'package:auth_buttons/res/shared/auth_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoom_clone/pages/auth/FirebaseAuthService.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GoogleAuthButton(
      onPressed: () async {
        await FirebaseAuthService().signInWithGoogle();
      },
      darkMode: false,
      iconStyle: AuthIconStyle.secondary,
    );
  }
}
