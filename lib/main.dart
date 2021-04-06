// import 'none.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zoom_clone/models/get_config_model.dart';
import 'package:zoom_clone/models/user_model.dart';
import 'package:zoom_clone/networking/NetworkClass.dart';

import 'base_class/RouteGenerator.dart';
import 'models/get_config_service.dart';
import 'utils/BaseMisc.dart';
import 'utils/SharedPrefs.dart';
import 'package:firebase_core/firebase_core.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();
  await Firebase.initializeApp();
  // final document = await getApplicationDocumentsDirectory();
  // var path = Directory.current.path;
  // // await Hive.initFlutter();
  // Hive.init(path);
  await Hive.initFlutter();
  Hive.registerAdapter(GetConfigModelAdapter());
  Hive.registerAdapter(AppConfigAdapter());
  Hive.registerAdapter(AdsConfigAdapter());
  Hive.registerAdapter(AuthUserAdapter());
  await Hive.openBox<GetConfigModel>('getConfigbox');
  await Hive.openBox<AppConfig>('appConfigbox');
  await Hive.openBox<AdsConfig>('adsConfigbox');
  await Hive.openBox<AuthUser>('user');
  // await Hive.openBox('seenBox');
  GetConfigModel getConfigModel;
  getConfigModel = await NetworkClass().getAppConfig();
  GetConfigService().updateGetConfig(getConfigModel);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: BaseStrings.APP_NAME,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: '/loginPage',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
        ));
  }
}
