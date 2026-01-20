import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:pmb_app/features/student/presentation/bloc/student_bloc.dart';
import 'package:pmb_app/features/student/presentation/widgets/logout_dialog.dart';
import 'package:pmb_app/features/theme/presentation/pages/theme_page.dart';

class HomeDrawerContent extends StatelessWidget {
  const HomeDrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          child: Image.asset("assets/images/nf_logo.png", fit: BoxFit.contain),
        ),

        ListTile(
          leading: const Icon(Icons.home),
          title: const Text("Home"),
          onTap: () {
            Navigator.pop(context);
            Future.delayed(Duration.zero, () {
              context.read<StudentBloc>().add(StudentsEvent());
            });
          },
        ),

        ListTile(
          leading: const Icon(Icons.dark_mode),
          title: const Text("Change Theme"),
          onTap: () {
            Navigator.pop(context);
            context.push(ThemePage.ROUTE_NAME);
          },
        ),

        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text("Logout"),
          onTap: () {
            Navigator.pop(context);
            showLogoutDialog(context);
          },
        ),
      ],
    );
  }
}
