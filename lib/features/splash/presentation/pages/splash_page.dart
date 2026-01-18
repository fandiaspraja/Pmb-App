import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pmb_app/common/constants/app_colors.dart';
import 'package:pmb_app/core/utils/constants.dart';
import 'package:pmb_app/features/auth/presentation/pages/login_page.dart';
import 'package:pmb_app/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:pmb_app/features/student/presentation/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // _setupPushNotifications();

    Future.delayed(Duration(seconds: 3), () {
      context.read<SplashBloc>().add(GetLoginStatusSplashEvent());
    });
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
