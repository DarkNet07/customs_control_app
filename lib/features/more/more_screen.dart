import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/l10n/l10n.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navMore)),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.menu_book_outlined),
            title: Text(l10n.navDictionaries),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/dictionaries'),
          ),
          ListTile(
            leading: const Icon(Icons.file_download_outlined),
            title: Text(l10n.navExport),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/export'),
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: Text(l10n.navSettings),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/settings'),
          ),
        ],
      ),
    );
  }
}
