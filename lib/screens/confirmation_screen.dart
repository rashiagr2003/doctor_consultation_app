import 'package:flutter/material.dart';
import '../models/appointment.dart';
import '../utils/app_colors.dart';
import '../utils/responsive_utils.dart';
import 'doctor_screen_list.dart';

class ConfirmationScreen extends StatelessWidget {
  final Appointment appointment;

  const ConfirmationScreen({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveUtils.responsivePadding(context, 16.0);
    final spacing = ResponsiveUtils.responsiveSpacing(context, 16.0);
    final cardWidth = ResponsiveUtils.getCardWidth(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Success",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            fontSize: ResponsiveUtils.responsiveFontSize(context, 20),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: cardWidth,
              padding: EdgeInsets.all(padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      color: AppColors.success,
                      size: 80,
                    ),
                  ),

                  SizedBox(height: spacing * 2),

                  Text(
                    'Appointment Confirmed!',
                    style: TextStyle(
                      fontSize: ResponsiveUtils.responsiveFontSize(context, 26),
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: spacing * 0.5),

                  Text(
                    'Your appointment has been successfully booked.',
                    style: TextStyle(
                      fontSize: ResponsiveUtils.responsiveFontSize(context, 15),
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: spacing * 2),

                  Card(
                    elevation: 4,
                    shadowColor: Colors.black12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Appointment Details',
                            style: TextStyle(
                              fontSize: ResponsiveUtils.responsiveFontSize(
                                context,
                                20,
                              ),
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),

                          const SizedBox(height: 16),
                          const Divider(height: 1),
                          const SizedBox(height: 16),

                          _buildDetailRow(
                            context,
                            icon: Icons.confirmation_number_outlined,
                            label: 'Appointment ID',
                            value: '#${appointment.id.substring(0, 8)}',
                          ),

                          const SizedBox(height: 16),

                          _buildDetailRow(
                            context,
                            icon: Icons.person_outline,
                            label: 'Patient Name',
                            value: appointment.patientName,
                          ),

                          const SizedBox(height: 16),

                          _buildDetailRow(
                            context,
                            icon: Icons.phone_outlined,
                            label: 'Phone Number',
                            value: appointment.patientPhone,
                          ),

                          const SizedBox(height: 16),

                          _buildDetailRow(
                            context,
                            icon: Icons.medical_services_outlined,
                            label: 'Doctor',
                            value: appointment.doctor.name,
                          ),

                          const SizedBox(height: 16),

                          _buildDetailRow(
                            context,
                            icon: Icons.local_hospital_outlined,
                            label: 'Specialization',
                            value: appointment.doctor.specialization,
                          ),

                          const SizedBox(height: 16),

                          _buildDetailRow(
                            context,
                            icon: Icons.calendar_today_outlined,
                            label: 'Date',
                            value: _formatDate(appointment.appointmentDate),
                          ),

                          const SizedBox(height: 16),

                          _buildDetailRow(
                            context,
                            icon: Icons.access_time_outlined,
                            label: 'Time',
                            value: appointment.appointmentTime,
                          ),

                          const SizedBox(height: 16),

                          _buildDetailRow(
                            context,
                            icon: Icons.currency_rupee,
                            label: 'Consultation Fee',
                            value: appointment.doctor.consultationFee,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: spacing * 2),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.info.withOpacity(0.07),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.info.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, color: AppColors.info),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'A confirmation message has been sent to your phone number.',
                            style: TextStyle(
                              fontSize: ResponsiveUtils.responsiveFontSize(
                                context,
                                14,
                              ),
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spacing * 2),

                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DoctorListScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.textWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                      ),
                      child: Text(
                        'Back to Home',
                        style: TextStyle(
                          fontSize: ResponsiveUtils.responsiveFontSize(
                            context,
                            16,
                          ),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: ResponsiveUtils.responsiveFontSize(context, 12),
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                softWrap: true,

                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: ResponsiveUtils.responsiveFontSize(context, 16),
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
