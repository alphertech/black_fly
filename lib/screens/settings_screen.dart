import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _autoWifi = false;
  bool _autoMobile = false;
  bool _killSwitch = true;
  bool _dnsLeak = true;
  bool _ipv6Leak = true;
  bool _adBlocker = false;
  String _protocol = 'WireGuard';

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSettingsGroup(
            title: 'Connection',
            children: [
              _buildDropdownSetting(
                title: 'Protocol',
                subtitle: 'WireGuard / OpenVPN / IKEv2',
                value: _protocol,
                items: const ['WireGuard', 'OpenVPN', 'IKEv2'],
                onChanged: (value) {
                  setState(() {
                    _protocol = value!;
                  });
                },
              ),
              _buildSwitchSetting(
                title: 'Auto-connect on Wi-Fi',
                subtitle: 'Connect automatically on Wi-Fi',
                value: _autoWifi,
                onChanged: (value) {
                  setState(() {
                    _autoWifi = value;
                  });
                },
              ),
              _buildSwitchSetting(
                title: 'Auto-connect on Mobile',
                subtitle: 'Connect automatically on mobile data',
                value: _autoMobile,
                onChanged: (value) {
                  setState(() {
                    _autoMobile = value;
                  });
                },
              ),
              _buildSwitchSetting(
                title: 'Kill Switch',
                subtitle: 'Block internet if VPN drops',
                value: _killSwitch,
                onChanged: (value) {
                  setState(() {
                    _killSwitch = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSettingsGroup(
            title: 'Security & Privacy',
            children: [
              _buildSwitchSetting(
                title: 'DNS Leak Protection',
                subtitle: 'Prevent DNS leaks',
                value: _dnsLeak,
                onChanged: (value) {
                  setState(() {
                    _dnsLeak = value;
                  });
                },
              ),
              _buildSwitchSetting(
                title: 'IPv6 Leak Protection',
                subtitle: 'Block IPv6 traffic',
                value: _ipv6Leak,
                onChanged: (value) {
                  setState(() {
                    _ipv6Leak = value;
                  });
                },
              ),
              _buildSwitchSetting(
                title: 'Ad Blocker',
                subtitle: 'Block ads and trackers',
                value: _adBlocker,
                onChanged: (value) {
                  setState(() {
                    _adBlocker = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSettingsGroup(
            title: 'Appearance',
            children: [
              _buildSwitchSetting(
                title: 'Dark Mode',
                subtitle: 'Toggle dark/light theme',
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
              ),
              _buildDropdownSetting(
                title: 'Language',
                subtitle: 'Select your language',
                value: 'English',
                items: const ['English', 'Spanish', 'French', 'Arabic'],
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSettingsGroup(
            title: 'About',
            children: [
              _buildInfoSetting(
                title: 'Version',
                value: '2.4.1',
              ),
              _buildInfoSetting(
                title: 'Privacy Policy',
                isLink: true,
                onTap: () {},
              ),
              _buildInfoSetting(
                title: 'Terms of Service',
                isLink: true,
                onTap: () {},
              ),
              _buildInfoSetting(
                title: 'Open Source Licenses',
                isLink: true,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchSetting({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
      activeThumbColor: Theme.of(context).primaryColor,
    );
  }

  Widget _buildDropdownSetting({
    required String title,
    required String subtitle,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: DropdownButton<String>(
        value: value,
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        underline: const SizedBox(),
      ),
    );
  }

  Widget _buildInfoSetting({
    required String title,
    String? value,
    bool isLink = false,
    VoidCallback? onTap,
  }) {
    return ListTile(
      title: Text(title),
      trailing: isLink
          ? const Icon(Icons.chevron_right, size: 20)
          : Text(value ?? '', style: const TextStyle(color: Colors.grey)),
      onTap: onTap,
    );
  }
}