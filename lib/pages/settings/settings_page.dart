import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;
  String _selectedLanguage = 'en';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Theme Switch
                Card(
                  child: ListTile(
                    title: const Text('Dark Mode'),
                    subtitle: const Text('Toggle application theme'),
                    trailing: Switch(
                      value: _isDarkMode,
                      onChanged: (value) {
                        setState(() {
                          _isDarkMode = value;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Language Switch
                Card(
                  child: ListTile(
                    title: const Text('Language'),
                    subtitle: const Text('Select application language'),
                    trailing: DropdownButton<String>(
                      value: _selectedLanguage,
                      underline: const SizedBox(),
                      items: const [
                        DropdownMenuItem(
                          value: 'en',
                          child: Text('English'),
                        ),
                        DropdownMenuItem(
                          value: 'zh',
                          child: Text('中文'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedLanguage = value;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // App Version
          Padding(
            padding: const EdgeInsets.only(bottom: 32, top: 16),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Application Version',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '1.0.0',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
