class Doctor {
  final String id;
  final String name;
  final String specialization;
  final double rating;
  final String experience;
  final String imageUrl;
  final String qualification;
  final List<String> availableDays;
  final String consultationFee;

  Doctor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.rating,
    required this.experience,
    required this.imageUrl,
    required this.qualification,
    required this.availableDays,
    required this.consultationFee,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id']?.toString() ?? '',
      name: json['names'] ?? json['name'] ?? 'Unknown Doctor',
      specialization: json['specialization'] ?? 'General Physician',
      rating: _normalizeRating(json['rating']),
      experience: json['experience'] ?? '5 years',
      imageUrl:
          json['imageUrl'] ?? 'https://randomuser.me/api/portraits/men/1.jpg',
      qualification: json['qualification'] ?? 'MBBS',
      availableDays: _parseAvailableDays(json['availableDays']),
      consultationFee:
          json['consultationFees'] ?? json['consultationFee'] ?? '₹500',
    );
  }

  static double _normalizeRating(dynamic rating) {
    if (rating == null) return 4.0;

    double ratingValue = rating is int ? rating.toDouble() : rating as double;

    if (ratingValue > 5) {
      ratingValue = (ratingValue / 100) * 5;
      ratingValue = ratingValue.clamp(0.0, 5.0);
    }

    return double.parse(ratingValue.toStringAsFixed(1));
  }

  static List<String> _parseAvailableDays(dynamic days) {
    if (days == null) {
      return ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
    }

    if (days is List) {
      if (days.isEmpty) {
        return ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
      }
      return days.map((e) => e.toString()).toList();
    }

    return ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'names': name,
      'specialization': specialization,
      'rating': rating,
      'experience': experience,
      'imageUrl': imageUrl,
      'qualification': qualification,
      'availableDays': availableDays,
      'consultationFees': consultationFee,
    };
  }

  Doctor copyWith({
    String? id,
    String? name,
    String? specialization,
    double? rating,
    String? experience,
    String? imageUrl,
    String? qualification,
    List<String>? availableDays,
    String? consultationFee,
  }) {
    return Doctor(
      id: id ?? this.id,
      name: name ?? this.name,
      specialization: specialization ?? this.specialization,
      rating: rating ?? this.rating,
      experience: experience ?? this.experience,
      imageUrl: imageUrl ?? this.imageUrl,
      qualification: qualification ?? this.qualification,
      availableDays: availableDays ?? this.availableDays,
      consultationFee: consultationFee ?? this.consultationFee,
    );
  }
}
