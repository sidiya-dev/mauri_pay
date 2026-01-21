import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mauri_pay/core/theme/app_colors.dart';
import 'package:mauri_pay/feautres/auth/presentation/bloc/auth_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.grayColor),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(5),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is Success) {
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: const Color.fromARGB(255, 27, 99, 134),
                        child: Text(
                          state.user.firstName[0] + state.user.lastName[0],
                          style: TextStyle(
                            fontSize: 42,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.user.firstName + " " + state.user.lastName,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        alignment: WrapAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.grayColor),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.call, size: 18),
                                const SizedBox(width: 6),
                                Text(
                                  state.user.phone ,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 68, 125, 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.verified,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "Compte Vérifié",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Paramètres",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.grayColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      _buildSettingTile(
                        icon: Icons.person_outline,
                        title: "Détails du compte",
                      ),
                      _buildSettingTile(
                        icon: Icons.phone_android,
                        title: "Changer de numéro de téléphone",
                        textColor: Colors.grey[700],
                      ),
                      _buildSettingTile(
                        icon: Icons.lock_outline,
                        title: "Changer votre mot de passe",
                      ),
                      _buildSettingTile(
                        icon: Icons.language,
                        title: "Langue de l'application",
                      ),
                      _buildSettingTile(
                        icon: Icons.logout,
                        title: "Déconnexion",
                        textColor: Colors.red,
                        iconColor: Colors.red,
                        noDivider: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    Color? textColor,
    Color? iconColor,
    bool noDivider = false,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(icon, color: iconColor),
            title: Text(
              title,
              style: TextStyle(color: textColor, fontSize: 16),
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          ),
        ),
        Visibility(
          visible: !noDivider,
          child: const Divider(height: 1, color: Colors.grey),
        ),
      ],
    );
  }
}
