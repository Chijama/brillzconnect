import 'package:brillzconnect/common/color.dart';
import 'package:brillzconnect/common/text_style.dart';
import 'package:brillzconnect/features/authentication/domain/user_state.dart';
import 'package:brillzconnect/features/authentication/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider.notifier).state;
    final currentUser = user ?? User.defaultUser();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile "),automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.appWhite,
      body: Column(
        children: [
          Stack(
            children: [
              // Cover Image
              Container(
                width: double.infinity,
                height: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1568605114967-8130f3a36994',
                    ), // Replace with your cover image URL
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Profile Picture
              const Positioned(
                bottom: 5, // Move the avatar down
                left: 16, // Adjust the position horizontally
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor:
                      Colors.white, // White border around profile pic
                  child: CircleAvatar(
                    radius: 59,
                    backgroundImage: AssetImage(
                      "assets/img/placeholder.jpg", // Replace with your profile pic URL
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoSection('Personal Information', {
                  'UserName': currentUser.username,
                  'Email': currentUser.email,
                  'Phone Number': currentUser.phone,
                }),
                _buildInfoSection(
                    'Interests', {'Sports': currentUser.interests.join(', ')}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildInfoSection(String title, Map<String, dynamic> info) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: getBlackZodiak(fontsize: 20, fontweight: FontWeight.w500),
      ),
      const SizedBox(height: 5),
      Divider(
        color: AppColors.appDividerLineLightGray,
      ),
      ...info.entries.map((e) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              '${e.key}: ${e.value}',
              style: getPlusJakartaSans(
                textColor: AppColors.appSecondaryTextMediumGray,
                fontsize: 12,
                fontweight: FontWeight.w400,
              ),
            ),
          )),
      const SizedBox(height: 16),
    ],
  );
}
