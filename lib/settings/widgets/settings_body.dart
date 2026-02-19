import 'dart:async';

import 'package:balance_sheet/app/theme/theme_cubit.dart';
import 'package:balance_sheet/settings/cubit/settings_cubit.dart';
import 'package:balance_sheet/widgets/app_alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsBody extends StatefulWidget {
  const SettingsBody({super.key});

  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  String _appVersion = 'Loading...';

  @override
  void initState() {
    super.initState();
    unawaited(_loadAppVersion());
  }

  Future<void> _loadAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        _appVersion = '${packageInfo.version} (${packageInfo.buildNumber})';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settingsState) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Appearance',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Card(
                        child: ListTile(
                          title: const Text('Dark Mode'),
                          trailing: Switch(
                            value: themeState.mode == ThemeMode.dark,
                            onChanged: (value) async {
                              await context.read<ThemeCubit>().toggleTheme();

                              if (!context.mounted) return;

                              final newTheme = value ? 'Dark' : 'Light';
                              showSuccessSnackBar(
                                context,
                                message: 'Theme changed to $newTheme mode',
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Preferences',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Card(
                        child: ListTile(
                          title: const Text('Currency'),
                          subtitle: Text(
                            '${settingsState.currency} (${settingsState.currencySymbol})',
                          ),
                          leading: const Icon(Icons.attach_money),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                          onTap: () async {
                            await _showCurrencyPicker(context);
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      Card(
                        child: ListTile(
                          title: const Text('Language'),
                          subtitle: const Text('English (US)'),
                          leading: const Icon(Icons.language),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                          onTap: () {
                            // Show coming soon message
                            showInfoSnackBar(
                              context,
                              message: 'Language selection coming soon',
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'About',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Card(
                        child: ListTile(
                          title: const Text('Version'),
                          subtitle: Text(_appVersion),
                          leading: const Icon(Icons.info_outline),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Consolidated Developer Card
                      Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'About Developer',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.person, size: 24),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Emmanuel C Phiri',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              'Mobile Apps Developer',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  const Divider(),
                                  const SizedBox(height: 12),
                                  const Text(
                                    'Connect with me',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  // GitHub Link
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: const Icon(Icons.code, size: 20),
                                    title: const Text('GitHub'),
                                    subtitle: const Text('Emelio101'),
                                    trailing: const Icon(
                                      Icons.open_in_new,
                                      size: 16,
                                    ),
                                    onTap: () => _launchURL(
                                      context,
                                      'https://github.com/Emelio101',
                                    ),
                                  ),
                                  // LinkedIn Link
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: const Icon(Icons.work, size: 20),
                                    title: const Text('LinkedIn'),
                                    subtitle: const Text(
                                      'Emmanuel C Phiri',
                                    ),
                                    trailing: const Icon(
                                      Icons.open_in_new,
                                      size: 16,
                                    ),
                                    onTap: () => _launchURL(
                                      context,
                                      'https://www.linkedin.com/in/emmanuel-c-phiri-13420315b',
                                    ),
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: const Icon(Icons.timer, size: 20),
                                    title: const Text('WakaTime'),
                                    subtitle: const Text('Emelio101'),
                                    trailing: const Icon(
                                      Icons.open_in_new,
                                      size: 16,
                                    ),
                                    onTap: () => _launchURL(
                                      context,
                                      'https://wakatime.com/@Emelio101',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12), const SizedBox(height: 12),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _showCurrencyPicker(BuildContext context) async {
    final currencies = [
      {'code': 'ZMW', 'name': 'Zambian Kwacha', 'symbol': 'K'},
      {'code': 'USD', 'name': 'US Dollar', 'symbol': r'$'},
      {'code': 'EUR', 'name': 'Euro', 'symbol': '€'},
      {'code': 'GBP', 'name': 'British Pound', 'symbol': '£'},
      {'code': 'JPY', 'name': 'Japanese Yen', 'symbol': '¥'},
      {'code': 'ZAR', 'name': 'South African Rand', 'symbol': 'R'},
      {'code': 'NGN', 'name': 'Nigerian Naira', 'symbol': '₦'},
      {'code': 'KES', 'name': 'Kenyan Shilling', 'symbol': 'KSh'},
    ];

    await showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext sheetContext) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Select Currency',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: currencies.length,
                  itemBuilder: (context, index) {
                    final currency = currencies[index];
                    return ListTile(
                      leading: Text(
                        currency['symbol']!,
                        style: const TextStyle(fontSize: 24),
                      ),
                      title: Text(currency['name']!),
                      subtitle: Text(currency['code']!),
                      onTap: () {
                        context.read<SettingsCubit>().updateCurrency(
                          currency['code']!,
                          currency['symbol']!,
                        );
                        // Show success snackbar when currency is updated
                        showSuccessSnackBar(
                          context,
                          message: 'Currency updated to ${currency['code']!}',
                        );
                        Navigator.pop(sheetContext);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _launchURL(BuildContext context, String urlString) async {
    try {
      final url = Uri.parse(urlString);
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );

        if (!context.mounted) return;

        showSuccessSnackBar(
          context,
          message: 'Opening link...',
        );
      } else {
        if (!context.mounted) return;
        await _showLaunchError(context, urlString);
      }
    } on Exception {
      if (!context.mounted) return;
      await _showLaunchError(context, urlString);
    }
  }

  Future<void> _showLaunchError(BuildContext context, String urlString) async {
    await showErrorSnackBar(
      context,
      message: 'Could not open $urlString',
    );
  }
}
