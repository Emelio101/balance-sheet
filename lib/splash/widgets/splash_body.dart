import 'package:balance_sheet/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// {@template splash_body}
/// Body of the SplashPage.
///
/// Displays the app logo, loader, and version information.
/// {@endtemplate}
class SplashBody extends StatefulWidget {
  /// {@macro splash_body}
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    // Wait for 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      // Navigate to HomePage using your route pattern
      Navigator.pushReplacement(
        context,
        HomePage.route(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            SvgPicture.asset('assets/svg/logo.svg', height: 100),
            const SizedBox(height: 8),
            const AppName(),
            const SizedBox(height: 24),
            const CircularProgressIndicator(),
            const Spacer(),
            const AppVersion(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class AppName extends StatefulWidget {
  const AppName({super.key});

  @override
  State<AppName> createState() => _AppNameState();
}

class _AppNameState extends State<AppName> {
  String _appName = '';

  @override
  void initState() {
    super.initState();
    _loadAppName();
  }

  Future<void> _loadAppName() async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        _appName = packageInfo.appName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _appName.isEmpty ? '' : _appName,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class AppVersion extends StatefulWidget {
  const AppVersion({super.key});

  @override
  State<AppVersion> createState() => _AppVersionState();
}

class _AppVersionState extends State<AppVersion> {
  String _appVersion = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        _appVersion = 'v${packageInfo.version} (${packageInfo.buildNumber})';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _appVersion.isEmpty ? 'Loading...' : _appVersion,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Colors.grey[600],
      ),
    );
  }
}
