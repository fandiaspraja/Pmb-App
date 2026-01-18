import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:pmb_app/common/constants/app_colors.dart';
import 'package:pmb_app/core/utils/constants.dart';
import 'package:pmb_app/features/auth/presentation/pages/login_page.dart';
import 'package:pmb_app/features/student/domain/entity/student_entity.dart';
import 'package:pmb_app/features/student/presentation/bloc/student_bloc.dart';
import 'package:pmb_app/features/student/presentation/pages/detail_page.dart';
import 'package:pmb_app/features/student/presentation/pages/register_page.dart';
import 'package:pmb_app/features/student/presentation/widgets/student_card.dart';

class HomePage extends StatefulWidget {
  static const ROUTE_NAME = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<StudentEntity> students = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      context.read<StudentBloc>().add(StudentsEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Students Page",
          style: GoogleFonts.urbanist(color: AppColors.textPrimary),
        ),
        leading: BackButton(
          color: black,
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              showLogoutDialog(context);
            },
            icon: const Icon(Icons.logout, color: black),
          ),
        ],
      ),
      body: BlocBuilder<StudentBloc, StudentStateBloc>(
        builder: (context, state) {
          if (state is StudentListSuccess) {
            students = state.students;
          }

          return SafeArea(
            child: Column(
              children: [
                gapH16,
                Expanded(
                  child: ListView.builder(
                    itemCount: students.length,
                    padding: EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      var item = students[index];

                      return StudentCard(
                        student: item,
                        onTap: () {
                          context.push(DetailPage.ROUTE_NAME, extra: item.id);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade100,
        foregroundColor: primary,
        tooltip: "Add Student",
        onPressed: () {
          context.push(RegisterPage.ROUTE_NAME);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Logout"),
        content: const Text("Are you sure want to logout ?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);

              context.read<StudentBloc>().add(LogoutEvent());

              context.go(LoginPage.ROUTE_NAME);
            },
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}
