import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/doctor_models.dart';

class DoctorService {
  static const String _baseUrl =
      "https://692807eab35b4ffc5013e56e.mockapi.io/doctors/doctors";

  static Future<List<Doctor>> fetchDoctors() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        return data.map((json) => Doctor.fromJson(json)).toList();
      } else {
        print("❌ API Error: ${response.statusCode}");
        return getMockDoctors();
      }
    } catch (e) {
      print("❌ Exception: $e");
      return getMockDoctors();
    }
  }

  static List<Doctor> getMockDoctors() {
    return [
      Doctor(
        id: '1',
        name: 'Dr. Sarah Johnson',
        specialization: 'Cardiologist',
        rating: 4.8,
        experience: '15 years',
        imageUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
        qualification: 'MBBS, MD (Cardiology)',
        availableDays: ['Monday', 'Tuesday', 'Wednesday', 'Friday'],
        consultationFee: '₹800',
      ),
      Doctor(
        id: '2',
        name: 'Dr. Michael Chen',
        specialization: 'Neurologist',
        rating: 4.9,
        experience: '12 years',
        imageUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
        qualification: 'MBBS, MD (Neurology)',
        availableDays: ['Monday', 'Wednesday', 'Thursday', 'Friday'],
        consultationFee: '₹1000',
      ),
      Doctor(
        id: '3',
        name: 'Dr. Emily Davis',
        specialization: 'Pediatrician',
        rating: 4.7,
        experience: '10 years',
        imageUrl: 'https://randomuser.me/api/portraits/women/68.jpg',
        qualification: 'MBBS, MD (Pediatrics)',
        availableDays: ['Tuesday', 'Wednesday', 'Thursday', 'Saturday'],
        consultationFee: '₹600',
      ),
      Doctor(
        id: '4',
        name: 'Dr. James Wilson',
        specialization: 'Orthopedic Surgeon',
        rating: 4.6,
        experience: '18 years',
        imageUrl: 'https://randomuser.me/api/portraits/men/52.jpg',
        qualification: 'MBBS, MS (Orthopedics)',
        availableDays: ['Monday', 'Tuesday', 'Friday', 'Saturday'],
        consultationFee: '₹1200',
      ),
    ];
  }

  static List<String> getAvailableTimeSlots() {
    return [
      '09:00 AM',
      '09:30 AM',
      '10:00 AM',
      '10:30 AM',
      '11:00 AM',
      '11:30 AM',
      '02:00 PM',
      '02:30 PM',
      '03:00 PM',
      '03:30 PM',
      '04:00 PM',
      '04:30 PM',
      '05:00 PM',
      '05:30 PM',
    ];
  }
}
