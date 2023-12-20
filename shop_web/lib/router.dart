import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login/UI/authorithation/forget_password.dart';
import 'package:login/UI/authorithation/forget_password_verification.dart';
import 'package:login/UI/authorithation/login_screen.dart';
import 'package:login/UI/authorithation/reg_verification_screen.dart';
import 'package:login/UI/authorithation/registration_screen.dart';
import 'package:login/UI/shop/shop_rewiew.dart';
import 'package:login/models/LogModel.dart';
import 'package:login/route_constants.dart';
import 'package:talker_flutter/talker_flutter.dart';

class NyAppRouter {
  static GoRouter returnRouter(bool isAuth, Talker talker, LogModel log) {
    GoRouter router = GoRouter(
      observers: [TalkerRouteObserver(talker)],
      routes: [
        GoRoute(
          name: RouteConstants.registration,
          path: '/',
          pageBuilder: (context, state) {
            log.route = state.fullPath;
            return MaterialPage(child: RegistrationScreen());
          },
        ),
        GoRoute(
          name: RouteConstants.login,
          path: "/login",
          pageBuilder: (context, state) {
            log.route = state.fullPath;
            return MaterialPage(child: LoginScreen());
          },
        ),
        GoRoute(
          name: RouteConstants.forgotPassword,
          path: "/frgpsw",
          pageBuilder: (context, state) {
            log.route = state.fullPath;
            return const MaterialPage(child: ForgotPasswordScreen());
          },
        ),
        GoRoute(
          name: RouteConstants.verification,
          path: "/verification",
          pageBuilder: (context, state) {
            log.route = state.fullPath;
            return const MaterialPage(child: VerificationScreen());
          },
        ),
        GoRoute(
          name: RouteConstants.forgot_password_verification,
          path: "/frgpsw/verification",
          pageBuilder: (context, state) {
            log.route = state.fullPath;
            return const MaterialPage(
                child: ForgotPasswordVerificationScreen());
          },
        ),
        GoRoute(
          name: RouteConstants.shop_rewiew,
          path: "/shop_rewiew",
          pageBuilder: (context, state) {
            log.route = state.fullPath;
            return MaterialPage(child: ShopRewiew(Isadmin: false));
          },
        ),
      ],
    );
    return router;
  }
}
