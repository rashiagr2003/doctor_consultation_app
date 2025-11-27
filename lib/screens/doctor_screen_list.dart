import 'dart:async';
import 'package:flutter/material.dart';
import '../models/doctor_models.dart';
import '../services/doctor_service.dart';
import '../utils/app_colors.dart';
import '../utils/platform_helper.dart';
import '../utils/responsive_utils.dart';
import '../widgets/doctor_card.dart';
import 'book_appointment_screen.dart';

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({super.key});

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  List<Doctor> _doctors = [];
  List<Doctor> _filteredDoctors = [];
  bool _isLoading = true;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _loadDoctors();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _loadDoctors() async {
    setState(() => _isLoading = true);
    try {
      final doctors = await DoctorService.fetchDoctors();
      setState(() {
        _doctors = doctors;
        _filteredDoctors = doctors;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        PlatformHelper.showSnackBar(
          context: context,
          message: 'Failed to load doctors',
          isError: true,
        );
      }
    }
  }

  void _filterDoctors(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _searchQuery = query;
        if (query.isEmpty) {
          _filteredDoctors = _doctors;
        } else {
          final lowerQuery = query.toLowerCase();
          _filteredDoctors = _doctors.where((doctor) {
            return doctor.name.toLowerCase().contains(lowerQuery) ||
                doctor.specialization.toLowerCase().contains(lowerQuery);
          }).toList();
        }
      });
    });
  }

  void _navigateToBooking(Doctor doctor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookAppointmentScreen(doctor: doctor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveUtils.responsivePadding(context, 16.0);
    final spacing = ResponsiveUtils.responsiveSpacing(context, 16.0);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Find Your Doctor',
          style: TextStyle(
            fontSize: ResponsiveUtils.responsiveFontSize(context, 20),
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildSearchBar(padding),
          Expanded(
            child: _isLoading
                ? Center(child: PlatformHelper.loadingIndicator())
                : _filteredDoctors.isEmpty
                ? _buildEmptyState(spacing)
                : RefreshIndicator(
                    onRefresh: _loadDoctors,
                    child: ResponsiveUtils.isMobile(context)
                        ? _buildListView(padding, spacing)
                        : _buildGridView(padding, spacing),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(double padding) {
    return Container(
      color: AppColors.primary,
      padding: EdgeInsets.fromLTRB(padding, 0, padding, padding),
      child: TextField(
        controller: _searchController,
        onChanged: _filterDoctors,
        style: const TextStyle(color: AppColors.textWhite),
        decoration: InputDecoration(
          hintText: 'Search by name or specialization...',
          hintStyle: const TextStyle(color: AppColors.textHint),
          prefixIcon: Icon(
            PlatformHelper.searchIcon,
            color: AppColors.textWhite,
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    PlatformHelper.closeIcon,
                    color: AppColors.textWhite,
                  ),
                  onPressed: () {
                    _searchController.clear();
                    _filterDoctors('');
                  },
                )
              : null,
          filled: true,
          fillColor: AppColors.primaryDark,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(double spacing) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 80, color: AppColors.textHint),
          SizedBox(height: spacing),
          Text(
            'No doctors found',
            style: TextStyle(
              fontSize: ResponsiveUtils.responsiveFontSize(context, 18),
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search',
            style: TextStyle(
              fontSize: ResponsiveUtils.responsiveFontSize(context, 14),
              color: AppColors.textHint,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(double padding, double spacing) {
    return ListView.separated(
      padding: EdgeInsets.all(padding),
      itemCount: _filteredDoctors.length,
      separatorBuilder: (context, index) => SizedBox(height: spacing),
      itemBuilder: (context, index) {
        final doctor = _filteredDoctors[index];
        return DoctorCard(
          doctor: doctor,
          onTap: () => _navigateToBooking(doctor),
        );
      },
    );
  }

  Widget _buildGridView(double padding, double spacing) {
    return GridView.builder(
      padding: EdgeInsets.all(padding),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ResponsiveUtils.getGridCrossAxisCount(context),
        childAspectRatio: 0.85,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
      ),
      itemCount: _filteredDoctors.length,
      itemBuilder: (context, index) {
        final doctor = _filteredDoctors[index];
        return DoctorCard(
          doctor: doctor,
          onTap: () => _navigateToBooking(doctor),
        );
      },
    );
  }
}
