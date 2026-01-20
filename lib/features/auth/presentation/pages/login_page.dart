import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pmb_app/core/utils/constants.dart';
import 'package:pmb_app/core/utils/custom_toast.dart';
import 'package:pmb_app/core/widgets/base/base_input.dart';
import 'package:pmb_app/core/widgets/custom_button_primary.dart';
import 'package:pmb_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pmb_app/features/student/presentation/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  static const ROUTE_NAME = '/login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: BlocListener<AuthBloc, AuthStateBloc>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            context.read<AuthBloc>().add(
              SaveAccessTokenEvent(state.userEntity.token ?? ''),
            );

            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go(HomePage.ROUTE_NAME);
            });
          }

          if (state is AuthError) {
            CustomToast.showError(context, state.message);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                gapH24,
                Image.asset("assets/images/nf_logo.png", height: 100),
                gapH16,
                Text(
                  "Login",
                  style: GoogleFonts.urbanist(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                gapH16,
                BaseInput(
                  controller: emailController,
                  label: "Email",
                  hintText: "Insert Email",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value == '') {
                      return "Email can't empty";
                    }

                    return null;
                  },
                ),
                gapH16,
                BaseInput(
                  controller: passwordController,
                  label: "Password",
                  hintText: "Insert Password",
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value == '') {
                      return "Password can't empty";
                    }

                    return null;
                  },
                ),
                gapH24,
                CustomButtonPrimary(
                  onTap: () {
                    if (emailController.text.isEmpty) {
                      CustomToast.showError(context, "Email can't empty");
                      return;
                    } else if (passwordController.text.isEmpty) {
                      CustomToast.showError(context, "Password can't empty");
                      return;
                    } else {
                      context.read<AuthBloc>().add(
                        LoginEvent(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      );
                    }
                    // context.go(OtpPage.ROUTE_NAME,
                    //     extra: isGuest);
                  },
                  title: "Login",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
