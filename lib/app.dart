import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supportive_app/Providers/ChatProvider/ChatProvider.dart';
import 'package:supportive_app/Providers/LoadingProvider/LoadingProvider.dart';
import 'package:supportive_app/Providers/AuthProvider/AuthProvider.dart';
import 'package:supportive_app/Providers/PlaidProvider/PlaidProvider.dart';
import 'package:supportive_app/Routes/Routes.dart';
import 'package:supportive_app/Utils/Constant/RouteConstant.dart';
import 'package:supportive_app/Utils/Constant/ColorConstants.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => LoadingProvider()),
            ChangeNotifierProvider(create: (context) => AuthProvider()),
            ChangeNotifierProvider(create: (context) => PlaidProvider()),
            ChangeNotifierProvider(create: (context) => ChatProvider()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Bankr AI',
            theme: ThemeData(
              primaryColor: ColorConstants.blackColor,
              scaffoldBackgroundColor: ColorConstants.whiteColor,
              colorScheme: ColorScheme.light(
                primary: ColorConstants.blackColor,
                secondary: ColorConstants.blackColor,
                surface: ColorConstants.whiteColor,
                background: ColorConstants.whiteColor,
                error: ColorConstants.redColor,
              ),
            ),
            initialRoute: RouteConstant.login,
            onGenerateRoute: RouteGenerator.generateRoute,
          ),
        );
      },
    );
  }
}
