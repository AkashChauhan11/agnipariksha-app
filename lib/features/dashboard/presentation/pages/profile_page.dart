import 'package:agni_pariksha/core/theme/colors.dart';
import 'package:agni_pariksha/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:agni_pariksha/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/widgets/logout_dialog.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  // Profile Avatar
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.primary.withOpacity(0.2),
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // User Name
                  Text(
                    state is Authenticated ? state.user.fullName : 'User Profile',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                  ),
                  const SizedBox(height: 8),
                  // User Email
                  Text(
                    state is Authenticated ? state.user.email : 'user@example.com',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.secondaryText,
                        ),
                  ),
                  // User Code
                  Text(
                    state is Authenticated ? state.user.code : 'user@example.com',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.secondaryText,
                        ),
                  ),
                  const SizedBox(height: 40),
              // Profile Options
              _buildProfileOption(
                context,
                icon: Icons.person_outline,
                title: 'Edit Profile',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Edit Profile - Coming Soon')),
                  );
                },
              ),
              _buildProfileOption(
                context,
                icon: Icons.lock_outline,
                title: 'Change Password',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Change Password - Coming Soon')),
                  );
                },
              ),
              _buildProfileOption(
                context,
                icon: Icons.notifications,
                title: 'Notifications',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Notifications - Coming Soon')),
                  );
                },
              ),
              _buildProfileOption(
                context,
                icon: Icons.settings_outlined,
                title: 'Settings',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Settings - Coming Soon')),
                  );
                },
              ),
              _buildProfileOption(
                context,
                icon: Icons.help_outline,
                title: 'Help & Support',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Help & Support - Coming Soon')),
                  );
                },
              ),
                  const SizedBox(height: 20),
                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => LogoutDialog.show(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout, color: AppColors.white),
                          SizedBox(width: 8),
                          Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.secondaryText,
            ),
          ],
        ),
      ),
    );
  }
} 