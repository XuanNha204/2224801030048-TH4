import 'package:flutter/material.dart';

import '../theme/theme_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.themeController});

  final ThemeController themeController;

  static const _studentClass = 'Chưa cung cấp';
  static const _studentId = '2224801030048';
  static const _studentName = 'Huỳnh Xuân Nhã';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        Text('Giao diện', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Card(
          clipBehavior: Clip.antiAlias,
          child: SwitchListTile(
            value: themeController.isDark,
            onChanged: themeController.setDarkMode,
            secondary: Icon(
              themeController.isDark
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
            ),
            title: const Text('Chế độ tối'),
            subtitle: Text(
              themeController.isDark
                  ? 'Đang bật giao diện tối'
                  : 'Đang bật giao diện sáng',
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Thông tin ứng dụng',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                const _InfoTile(
                  icon: Icons.groups_outlined,
                  label: 'Lớp',
                  value: _studentClass,
                ),
                Divider(height: 1, indent: 56, color: colors.outlineVariant),
                const _InfoTile(
                  icon: Icons.badge_outlined,
                  label: 'MSSV',
                  value: _studentId,
                ),
                Divider(height: 1, indent: 56, color: colors.outlineVariant),
                const _InfoTile(
                  icon: Icons.person_outline_rounded,
                  label: 'Họ tên',
                  value: _studentName,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      subtitle: Text(value),
    );
  }
}
