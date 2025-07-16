import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam/core/di/di.dart';
import 'package:online_exam/core/providers/app_config_provider.dart';
import 'package:provider/provider.dart';
import 'core/l10n/app_localizations.dart';
import 'core/routing/routes.dart';
import 'core/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  getIt<AppConfigProvider>().getLocale();

  runApp(
    ChangeNotifierProvider.value(
      value: getIt<AppConfigProvider>(),
      child: MyApplication(),
    ),
  );
}

class MyApplication extends StatelessWidget {
  MyApplication({super.key});

  late AppConfigProvider appConfigProvider;

  @override
  Widget build(BuildContext context) {
    appConfigProvider = Provider.of<AppConfigProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: AppLocalizations.of(context)?.login,
          onGenerateRoute: AppRoutes.onGenerateRoute,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale(appConfigProvider.locale!), // Default locale
          initialRoute: AppRoutes.login,
          theme: AppTheme.lightTheme,
        );
      },
    );
  }
}
