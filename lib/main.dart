import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:upoint_purchase_app/screens/loginScreen.dart';

import 'app/app_routes.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late Dio dio;
  // late LoginService loginService;

  MyApp() {
    final Dio dio = Dio(BaseOptions(
        // TODO change api
        // baseUrl: 'https://api.dev.hrm.astralink.mn/openapi',
        ));

    // loginService = LoginService(dio);
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.login,
      navigatorObservers: [GetObserver()],
      navigatorKey: navigatorKey,
      getPages: [
        GetPage(
            name: AppRoutes.login,
            page: () => const LoginScreen(
                // loginService: loginService,
                )),
        // GetPage(name: AppRoutes.signup, page: () => SignUpScreen()),
        // GetPage(
        //     name: AppRoutes.forgotPassword,
        //     page: () => ForgotPasswordScreen(
        //           token: '',
        //         )),
        // // TODO fix this
        // // TODO энэ яг майн screen ээс дамжуулдаг нь байна...
        // GetPage(
        //     name: AppRoutes.leavePermission,
        //     page: () => LeavePermission(
        //           token: '',
        //         )),
        // GetPage(
        //   name: AppRoutes.home,
        //   page: () => MyAppWithBottomNavigation(
        //       page: HomeScreen(
        //     token: '',
        //   )),
        // ),
        // GetPage(
        //   name: AppRoutes.homeTime,
        //   page: () => MyAppWithBottomNavigation(
        //       page: HomeTime(
        //     firstname: '',
        //     position: '',
        //     token: '',
        //   )),
        // ),
        // GetPage(
        //   name: AppRoutes.homeSent,
        //   page: () => MyAppWithBottomNavigation(page: HomeSent()),
        // ),
        // GetPage(
        //   name: AppRoutes.homeCheck,
        //   page: () => MyAppWithBottomNavigation(page: HomeCheck()),
        // ),
        // GetPage(
        //   name: AppRoutes.homeProfile,
        //   page: () => MyAppWithBottomNavigation(
        //       page: HomeProfile(
        //     token: '',
        //   )),
        // ),
        // GetPage(
        //   name: AppRoutes.leavePermission,
        //   page: () => MyAppWithBottomNavigation(
        //       page: LeavePermission(
        //     token: '',
        //   )),

        // ),
      ],
    );
  }
}
