import 'package:blackdiamondcar/dependency_injection.dart';
import 'package:blackdiamondcar/routes/route_names.dart';
import 'package:blackdiamondcar/utils/k_string.dart';
import 'package:blackdiamondcar/widgets/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize dependencies like DB, repositories, etc.
  await DInjector.initDB();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return OverlaySupport.global(
          child: MultiRepositoryProvider(
            providers: DInjector.repositoryProvider,
            child: MultiBlocProvider(
              providers: DInjector.blocProviders,
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: KString.appName,
                initialRoute: RouteNames.splashScreen,
                onGenerateRoute: RouteNames.generateRoutes,
                theme: MyTheme.theme,
              ),
            ),
          ),
        );
      },
    );
  }
}
