import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zoom_clone/models/user_model.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
    'email',
  ]);

  /* FirebaseAuthService({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();*/

  AuthUser _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }

    return AuthUser(
      userId: user.uid,
      email: user.email,
      name: user.displayName,
      imageUrl: user.photoURL,
    );
  }

  Stream<User> get onAuthStateChanged {
    _firebaseAuth.authStateChanges().listen((User user) {
      return user;
    });
  }

  /*Future<User> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }*/

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<AuthUser> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult = await _firebaseAuth.signInWithCredential(credential);
    return _userFromFirebase(authResult.user);
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<AuthUser> currentUser() async {
    final user = _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }
}
