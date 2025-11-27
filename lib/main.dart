import 'package:flutter/material.dart';
import 'screens/doctor_screen_list.dart';
import 'utils/app_colors.dart';

void main() {
  runApp(const DoctorConsultationApp());
}

class DoctorConsultationApp extends StatelessWidget {
  const DoctorConsultationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor Consultation',
      debugShowCheckedModeBanner: false,
      theme: AppColors.getLightTheme(),
      home: const DoctorListScreen(),
    );
  }
}
