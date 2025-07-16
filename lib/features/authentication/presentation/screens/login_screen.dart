import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_exam/core/constants/const.dart';
import 'package:online_exam/core/di/di.dart';
import 'package:online_exam/core/l10n/app_localizations.dart';
import 'package:online_exam/core/providers/app_config_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              style: GoogleFonts.inter(
                color: Theme.of(context).colorScheme.secondary,
              ),
              decoration: InputDecoration(labelText: localizations.email),
            ),
            FilledButton(
              onPressed: () {
                if (getIt<AppConfigProvider>().isEnglish()) {
                  getIt<AppConfigProvider>().changeLanguage(AppConst.arLocale);
                } else {
                  getIt<AppConfigProvider>().changeLanguage(AppConst.enLocale);
                }
              },
              child: Text(localizations.login),
            ),
          ],
        ),
      ),
    );
  }
}
