import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/providers/notification_provider.dart';
import 'package:to_do_app/service/notification_todo.dart';

class SettingNotification extends StatefulWidget {
  const SettingNotification({super.key});

  @override
  State<SettingNotification> createState() => _SettingNotificationState();
}

class _SettingNotificationState extends State<SettingNotification> {
  bool _notificationEnabled = true;
  late NotifyHelper _notifyHelper;

  @override
  void initState() {
    super.initState();
    _notifyHelper = NotifyHelper();
    _loadSettings();
  }

  Future _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationEnabled = prefs.getBool('notification_enabled') ?? true;
    });
  }

  Future _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notification_enabled', _notificationEnabled);
  }

  @override
  Widget build(BuildContext context) {
    final setting = Provider.of<NotificationSettingProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Pengaturan Notifikasi")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text("Aktifkan Notifikasi"),
              value: _notificationEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationEnabled = value;
                });
                _saveSettings();
              },
            ),
            SwitchListTile(
              title: const Text('Bunyikan Notifikasi'),
              subtitle: const Text('Aktifkan suara saat notifikasi muncul'),
              value: setting.sound,
              onChanged: (val) {
                setting.toggleSound(val);
                _saveSettings();
              },
            ),
            SwitchListTile(
              title: const Text('Vibrasi'),
              subtitle: const Text('Getar saat notifikasi dikirim'),
              value: setting.vibration,
              onChanged: (val) {
                setting.toggleVibration(val);
                _saveSettings();
              },
            ),

            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  _notifyHelper.displayNotification(
                    title: "Notifikasi Aktif",
                    body: "Ini adalah contoh notifikasi test.",
                  );
                },
                icon: const Icon(Icons.notifications_active),
                label: const Text("Test Notifikasi Sekarang"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
