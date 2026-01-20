import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pmb_app/features/auth/presentation/pages/login_page.dart';
import 'package:pmb_app/features/student/presentation/bloc/student_bloc.dart';

Future<void> showLogoutDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      final theme = Theme.of(context);

      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: theme.dialogBackgroundColor,
        title: const Text("Logout"),
        content: const Text("Are you sure want to logout?"),
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);

              /// clear student + token
              context.read<StudentBloc>().add(LogoutEvent());

              /// go to login
              context.go(LoginPage.ROUTE_NAME);
            },
            child: const Text("Logout"),
          ),
        ],
      );
    },
  );
}
