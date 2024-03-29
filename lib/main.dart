import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zentro/routes/app_pages.dart';
import 'package:zentro/theme/themes.dart';
import 'package:country_picker/country_picker.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Setting SystemUIOverlay
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // Setting SystemUIMode
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
  );

  runApp(ScreenUtilInit(builder: (_, __) => const BasePage()));
}

class BasePage extends StatelessWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zentro',
      getPages: AppPages.pages,
      initialRoute: AppRoutes.SPLASH,
      theme: ZentroTheme.lightTheme,
      localizationsDelegates: const [
        CountryLocalizations.delegate,
      ],
    );
  }
}
