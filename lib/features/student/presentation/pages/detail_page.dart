import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pmb_app/core/theme/app_colors.dart';
import 'package:pmb_app/core/utils/constants.dart';
import 'package:pmb_app/features/student/domain/entity/student_entity.dart';
import 'package:pmb_app/features/student/presentation/bloc/student_bloc.dart';

class DetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';

  final int id;

  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  StudentEntity? student;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<StudentBloc>().add(DetailStudentEvent(id: widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Students Detail Page", style: GoogleFonts.urbanist()),
        leading: BackButton(
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: BlocBuilder<StudentBloc, StudentStateBloc>(
        builder: (context, state) {
          if (state is StudentLoading) {
            // return const Center(child: CircularProgressIndicator());
          }
          if (state is StudentError) {
            return Center(child: Text(state.message));
          }
          if (state is StudentSuccess) {
            student = state.students;
          }

          if (student == null) return const SizedBox();

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// =====================
                  /// AVATAR
                  /// =====================
                  Center(
                    child: CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.blue.shade100,
                      child: Text(
                        (student?.name?.isNotEmpty ?? false)
                            ? student!.name!.substring(0, 1).toUpperCase()
                            : "-",
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Center(
                    child: Text(
                      student?.name ?? "-",
                      style: GoogleFonts.urbanist(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// =====================
                  /// INFO CARD
                  /// =====================
                  _infoCard(
                    title: "Informasi Siswa",
                    children: [
                      _infoRow("NISN", student?.nisn),
                      _infoRow("Tanggal Lahir", student?.birtdate),
                      _infoRow("Jurusan", student?.major),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// =====================
  /// WIDGETS
  /// =====================

  Widget _infoCard({required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.urbanist(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _infoRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              title,
              style: TextStyle(
                // color: Colors.grey.shade600,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value ?? "-",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
