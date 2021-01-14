import 'package:event_app/config/injection.dart';
import 'package:event_app/presentation/pages/event_detail_page.dart';
import 'package:event_app/presentation/pages/event_home_page.dart';
import 'package:event_app/presentation/pages/home_page.dart';
import 'package:event_app/presentation/pages/splash_screen.dart';
import 'package:event_app/size_config.dart';
import 'package:event_app/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        setupSystemSettings();
        return GetMaterialApp(
          smartManagement: SmartManagement.full,
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: SplashScreen.routeName,
          getPages: [
            GetPage(
              name: SplashScreen.routeName,
              page: () => SplashScreen(),
            ),
            GetPage(
              name: HomePage.routeName,
              page: () => HomePage(),
            ),
            GetPage(
              name: EventDetailScreen.routeName,
              page: () => EventDetailScreen(),
            ),
            GetPage(
              name: EventHomePage.routeName,
              page: () => EventHomePage(),
            ),
          ],
        );
      });
    });
  }
}

void setupSystemSettings() {
  // this will change color of status bar and system navigation bar
  SystemChrome.setSystemUIOverlayStyle(AppTheme.systemUiDark);

  // this will prevent change oriontation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
