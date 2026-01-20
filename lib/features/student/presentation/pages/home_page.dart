import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pmb_app/core/theme/app_colors.dart';
import 'package:pmb_app/core/utils/constants.dart';
import 'package:pmb_app/features/auth/presentation/pages/login_page.dart';
import 'package:pmb_app/features/student/domain/entity/student_entity.dart';
import 'package:pmb_app/features/student/presentation/bloc/student_bloc.dart';
import 'package:pmb_app/features/student/presentation/pages/detail_page.dart';
import 'package:pmb_app/features/student/presentation/pages/register_page.dart';
import 'package:pmb_app/features/student/presentation/widgets/home_drawer_content.dart';
import 'package:pmb_app/features/student/presentation/widgets/student_card.dart';
import 'package:pmb_app/features/theme/presentation/pages/theme_page.dart';

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
    return BlocListener<StudentBloc, StudentStateBloc>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          context.go(LoginPage.ROUTE_NAME);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Students Page", style: GoogleFonts.urbanist()),
        ),
        drawerScrimColor: Colors.transparent,
        drawer: Drawer(
          backgroundColor: Theme.of(context).colorScheme.surface,
          child: const HomeDrawerContent(),
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
          tooltip: "Add Student",
          onPressed: () {
            context.push(RegisterPage.ROUTE_NAME);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
