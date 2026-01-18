import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pmb_app/core/utils/constants.dart';
import 'package:pmb_app/core/utils/custom_toast.dart';
import 'package:pmb_app/core/widgets/base/base_dropdown_button.dart';
import 'package:pmb_app/core/widgets/base/base_input.dart';
import 'package:pmb_app/core/widgets/custom_button_primary.dart';
import 'package:pmb_app/core/widgets/custom_outlined_datetime.dart';
import 'package:pmb_app/features/student/data/models/register_request.dart';
import 'package:pmb_app/features/student/domain/entity/major_entity.dart';
import 'package:pmb_app/features/student/presentation/bloc/student_bloc.dart';

class RegisterPage extends StatefulWidget {
  static const ROUTE_NAME = '/register';

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;

  final nameController = TextEditingController();
  final nisnController = TextEditingController();
  final birtdateController = TextEditingController();
  final majorController = TextEditingController();

  // List<MajorEntity>? majors = [];

  List<DropdownOption>? items = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<StudentBloc>().add(MajorsEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocListener<StudentBloc, StudentStateBloc>(
        listener: (context, state) {
          if (state is StudentRegisterSuccess) {
            CustomToast.show(context, "Success add new student");
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.pop();
            });
          }

          if (state is MajorSuccess) {
            setState(() {
              items = state.majors
                  .map(
                    (e) => DropdownOption(
                      value: e.name ?? "",
                      label: e.name ?? "",
                    ),
                  )
                  .toList();
            });
          }

          if (state is StudentRegisterError) {
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
                  "Add New Student",
                  style: GoogleFonts.urbanist(
                    color: fontColorPrimary,
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                gapH16,
                BaseInput(
                  controller: nameController,
                  label: "Name",
                  hintText: "Insert Name",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value == '') {
                      return "Name can't empty";
                    }

                    return null;
                  },
                ),
                gapH16,
                CustomOutlinedDatetime(
                  controller: birtdateController,
                  title: "Birthday",
                  onTap: () {
                    selectDate(context);
                  },
                  hintText: "01 Jan 2025",
                ),
                gapH16,
                BaseInput(
                  controller: nisnController,
                  label: "NISN",
                  hintText: "Insert NISN",
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value == '') {
                      return "NISN can't empty";
                    }

                    return null;
                  },
                ),
                gapH16,
                BaseDropdownButton(
                  value: majorController.text.isEmpty
                      ? null
                      : majorController.text,
                  label: "Major",
                  hintText: "Choose Major",
                  items: items,
                  onChanged: (value) {
                    setState(() {
                      majorController.text = value ?? "";
                    });
                  },
                  validator: (value) {
                    if (value == null || value == '') {
                      return "Error";
                    }

                    return null;
                  },
                ),
                gapH24,
                CustomButtonPrimary(
                  onTap: () {
                    if (nameController.text.isEmpty) {
                      CustomToast.showError(context, "Name can't empty");
                      return;
                    } else if (nisnController.text.isEmpty) {
                      CustomToast.showError(context, "NISN can't empty");
                      return;
                    } else if (majorController.text.isEmpty) {
                      CustomToast.showError(context, "Major can't empty");
                      return;
                    } else if (birtdateController.text.isEmpty) {
                      CustomToast.showError(context, "Birthday can't empty");
                      return;
                    } else {
                      RegisterRequest request = RegisterRequest(
                        name: nameController.text,
                        nisn: nisnController.text,
                        birtday: birtdateController.text,
                        major: majorController.text,
                      );

                      context.read<StudentBloc>().add(
                        RegisterStudentEvent(request: request),
                      );
                    }
                    // if (emailController.text.isEmpty) {
                    //   CustomToast.showError(context, "Email can't empty");
                    //   return;
                    // } else if (passwordController.text.isEmpty) {
                    //   CustomToast.showError(context, "Password can't empty");
                    //   return;
                    // } else {
                    //   context.read<AuthBloc>().add(
                    //     LoginEvent(
                    //       email: emailController.text,
                    //       password: passwordController.text,
                    //     ),
                    //   );
                    // }
                    // context.go(OtpPage.ROUTE_NAME,
                    //     extra: isGuest);
                  },
                  title: "Add Student",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,

      /// default tanggal
      initialDate: now,

      /// batas paling awal
      firstDate: DateTime(1950),

      /// tidak boleh masa depan
      lastDate: now,

      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: primarySecond,
              onPrimary: white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;

        birtdateController.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }
}
