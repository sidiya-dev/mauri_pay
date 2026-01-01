import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mauri_pay/core/theme/app_colors.dart';
import 'package:mauri_pay/cubit/cubit/locale_cubit.dart';
import 'package:mauri_pay/l10n/app_localizations.dart';

class _Lang {
  final String name;
  final String languageCode;

  _Lang({required this.name, required this.languageCode});
}

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});

  final List<_Lang> _langs = [
    _Lang(name: "English", languageCode: "en"),
    _Lang(name: "Français", languageCode: "fr"),
    _Lang(name: "العربية", languageCode: "ar"),
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Drawer(
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 17, 17, 22),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/images/user.png"),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sidiya Sidibaba",
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () {
                              context.go("/login");
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(50, 30),
                            ),
                            child: Text(
                              t.logout,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(color: AppColors.errorColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.place_outlined),
                title: Text(t.agencies),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.phone_outlined),
                title: Text(t.contacts),
                onTap: () {},
              ),
              const Divider(height: 40, thickness: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _langs.map((e) {
                    final isSelected = locale.languageCode == e.languageCode;
                    return ElevatedButton(
                      onPressed: () {
                        context.read<LocaleCubit>().changeLocale(
                          e.languageCode,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelected
                            ? Colors.grey.shade800
                            : null,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        e.name,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: isSelected
                              ? Colors.white
                              : Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
