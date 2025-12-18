import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:insta_archiver_mobile/domain/repositories/i_repository.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _urlCtrl = TextEditingController();
  final _keyCtrl = TextEditingController();
  final repo = GetIt.I<IRepository>();

  @override
  void initState() {
    super.initState();
    final settings = repo.getSettings();
    _urlCtrl.text = settings['url'] ?? '';
    _keyCtrl.text = settings['secret'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _urlCtrl,
            decoration: const InputDecoration(
              labelText: 'Server URL',
              hintText: 'http://192.168.1.X:3000',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _keyCtrl,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Secret Key'),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () async {
              await repo.saveSettings(_urlCtrl.text, _keyCtrl.text);
              if (mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Saved!')));
              }
            },
            child: const Text('Save Configuration'),
          ),
        ],
      ),
    );
  }
}
