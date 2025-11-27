import 'doctor_models.dart';

class Appointment {
  final String id;
  final String patientName;
  final String patientPhone;
  final Doctor doctor;
  final DateTime appointmentDate;
  final String appointmentTime;
  final String status;
  final DateTime createdAt;

  Appointment({
    required this.id,
    required this.patientName,
    required this.patientPhone,
    required this.doctor,
    required this.appointmentDate,
    required this.appointmentTime,
    this.status = 'pending',
    required this.createdAt,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] ?? '',
      patientName: json['patientName'] ?? '',
      patientPhone: json['patientPhone'] ?? '',
      doctor: Doctor.fromJson(json['doctor']),
      appointmentDate: DateTime.parse(json['appointmentDate']),
      appointmentTime: json['appointmentTime'] ?? '',
      status: json['status'] ?? 'pending',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientName': patientName,
      'patientPhone': patientPhone,
      'doctor': doctor.toJson(),
      'appointmentDate': appointmentDate.toIso8601String(),
      'appointmentTime': appointmentTime,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
