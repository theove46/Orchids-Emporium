import 'package:flutter/material.dart';
import 'package:orchids_emporium/core/routes/routes.dart';
import 'package:orchids_emporium/users/view/auth/sign_in_page/pages/user_sign_in_page.dart';
import 'package:orchids_emporium/users/view/auth/sign_up_page/pages/user_sign_up_page.dart';
import 'package:orchids_emporium/users/view/screens/dashboard/dashboard.dart';

class RouteGenerator {
  static get controller => null;

  static Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.signUp:
        return MaterialPageRoute(
          builder: (_) => const UserSignUpPage(),
        );

      case Routes.signIn:
        return MaterialPageRoute(
          builder: (_) => const UserSignInPage(),
        );

      case Routes.userDashBoard:
        return MaterialPageRoute(
          builder: (_) => const UserDashBoard(),
        );

      // case Routes.inbox:
      //   return MaterialPageRoute(
      //     builder: (_) => const InboxPage(),
      //   );
      //
      // case Routes.forgotPassword:
      //   return MaterialPageRoute(
      //     builder: (_) => const ForgotPasswordPage(),
      //   );

      // case Routes.welcome:
      //   return MaterialPageRoute(builder: (_) => const SuccessPage());
      //
      // case Routes.webView:
      //   return MaterialPageRoute(
      //     builder: (_) => WebViewPage(
      //       url: routeSettings.arguments as String,
      //     ),
      //   );

      // case Routes.resetPassword:
      //   return MaterialPageRoute(
      //     builder: (_) => SetNewPasswordPage(
      //       email: routeSettings.arguments as String,
      //     ),
      //   );
      //
      // case Routes.changePassword:
      //   return MaterialPageRoute(
      //     builder: (_) => const ChangePasswordPage(),
      //   );

      // case Routes.updateProfile:
      //   return MaterialPageRoute(
      //     builder: (_) => const UpdateProfilePage(),
      //   );
      //
      // case Routes.searchUser:
      //   return MaterialPageRoute(
      //     builder: (_) => const SearchUserPage(),
      //   );

      default:
        return null;
    }
  }
}
