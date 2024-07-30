// import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izuahia/repository/local/shared_prefs.dart';
import 'package:izuahia/res/colors.dart';
import 'package:izuahia/screens/splash-screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  await SharedPrefs().init();


  runApp(
    // DevicePreview(
    //   enabled: true,
    //   builder: (context) =>
    const MyApp(),
    // )
  );
}

//  37.09024 -95.712891

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return Listener(
            onPointerDown: (_) {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.focusedChild?.unfocus();
              }
            },
            child: GetMaterialApp(
              useInheritedMediaQuery: true,
              // locale: DevicePreview.locale(context),
              // builder: DevicePreview.appBuilder,
              defaultTransition: Transition.fadeIn,
              debugShowCheckedModeBanner: false,
              title: 'Izuahia',
              theme: ThemeData(
                fontFamily: 'Montserrat',
                colorScheme: ColorScheme.fromSeed(seedColor: AppColors.whiteColor),
              ),
              home: SafeArea(
                child: Scaffold(body: child),
              ),
            ),
          );
        },
        child: const SplashScreen());
  }
}
