import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pmb_app/core/utils/constants.dart' as AppColors;
import 'package:pmb_app/features/auth/presentation/pages/login_page.dart';
import 'package:pmb_app/features/push_notification/domain/usecase/push_notification_usecase.dart';
import 'package:pmb_app/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:pmb_app/features/student/presentation/pages/home_page.dart';
import 'package:pmb_app/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:pmb_app/injection.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _pushNotificationUseCase = locator<PushNotificationUseCase>();
  String? fcmToken;

  @override
  void initState() {
    context.read<ThemeBloc>().add(LoadThemeEvent());
    super.initState();

    _setupPushNotifications();

    Future.delayed(Duration(seconds: 3), () {
      context.read<SplashBloc>().add(GetLoginStatusSplashEvent());
    });
  }

  Future<void> _setupPushNotifications() async {
    try {
      // Get device token (optional)
      final token = await _pushNotificationUseCase.getDeviceToken();
      debugPrint("FCM Device Token: $token");
      fcmToken = token;

      // Set listener on foreground/background notifications
      _pushNotificationUseCase.configurePushNotifications();

      // (Optional) Subscribe to topic
      // _pushNotificationUseCase.subscribeToTopic("user");
    } catch (e) {
      debugPrint("Push Notification Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashBloc, SplashStateBloc>(
      builder: (context, state) {
        if (state is LoginStatusSplash) {
          // Use Future.microtask to defer navigation
          Future.microtask(() {
            if (state.isLogin) {
              context.go(HomePage.ROUTE_NAME);
            } else {
              context.go(LoginPage.ROUTE_NAME);
            }
          });
        }
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: AppColors.primary50,
          body: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Center(
              child: Container(
                child: Image.asset("assets/images/nf_logo.png", height: 200),
              ),
            ),
          ),
        );
      },
    );
  }
}
