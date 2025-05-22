import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late SharedPreferences _prefs;
  bool _soundEnabled = true;
  bool _aiEnabled = true;
  String _difficulty = 'easy';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _soundEnabled = _prefs.getBool('sound_enabled') ?? true;
      _aiEnabled = _prefs.getBool('ai_enabled') ?? true;
      _difficulty = _prefs.getString('difficulty') ?? 'easy';
    });
  }

  Future<void> _saveSettings() async {
    await _prefs.setBool('sound_enabled', _soundEnabled);
    await _prefs.setBool('ai_enabled', _aiEnabled);
    await _prefs.setString('difficulty', _difficulty);
  }

  Future<void> _clearProgress() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Progress'),
        content: const Text('Are you sure you want to clear all progress? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Clear'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _prefs.remove('progress');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Progress cleared')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Sound Effects'),
            subtitle: const Text('Enable sound effects and music'),
            value: _soundEnabled,
            onChanged: (value) {
              setState(() => _soundEnabled = value);
              _saveSettings();
            },
          ),
          SwitchListTile(
            title: const Text('AI Explanations'),
            subtitle: const Text('Enable AI-powered explanations'),
            value: _aiEnabled,
            onChanged: (value) {
              setState(() => _aiEnabled = value);
              _saveSettings();
            },
          ),
          ListTile(
            title: const Text('Difficulty Level'),
            subtitle: Text(_difficulty.toUpperCase()),
            trailing: DropdownButton<String>(
              value: _difficulty,
              items: const [
                DropdownMenuItem(value: 'easy', child: Text('Easy')),
                DropdownMenuItem(value: 'pilot', child: Text('Pilot')),
                DropdownMenuItem(value: 'captain', child: Text('Captain')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => _difficulty = value);
                  _saveSettings();
                }
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Clear Progress'),
            subtitle: const Text('Reset all progress and achievements'),
            trailing: const Icon(Icons.delete_forever),
            onTap: _clearProgress,
          ),
        ],
      ),
    );
  }
} 