import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login/UI/authorithation/forget_password.dart';
import 'package:login/UI/authorithation/forget_password_verification.dart';
import 'package:login/UI/authorithation/login_screen.dart';
import 'package:login/UI/authorithation/reg_verification_screen.dart';
import 'package:login/UI/authorithation/registration_screen.dart';
import 'package:login/route_constants.dart';

class AppRouter {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: RouteConstants.registration,
        path: "/",
        pageBuilder: (context, state) {
          return const MaterialPage(child: RegistrationScreen());
        },
      ),
      GoRoute(
        name: RouteConstants.login,
        path: "/login",
        pageBuilder: (context, state) {
          return const MaterialPage(child: LoginScreen());
        },
      ),
      GoRoute(
        name: RouteConstants.forgotPassword,
        path: "/frgpsw",
        pageBuilder: (context, state) {
          return const MaterialPage(child: ForgotPasswordScreen());
        },
      ),
      GoRoute(
        name: RouteConstants.verification,
        path: "/verification",
        pageBuilder: (context, state) {
          return const MaterialPage(child: VerificationScreen());
        },
      ),
      GoRoute(
        name: RouteConstants.forgot_password_verification,
        path: "/frgpsw/verification",
        pageBuilder: (context, state) {
          return const MaterialPage(child: ForgotPasswordVerificationScreen());
        },
      ),
    ],
    // redirect: (context, state) async {
    //   bool isAuthentificated = false;
    //   if (!isAuthentificated) {
    //     return state.namedLocation(RouteConstants.registration);
    //     // ignore: dead_code
    //   } else {
    //     return null;
    //   }
    // },
  );
}
