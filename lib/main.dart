import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/provider/app_language_provider.dart';
import 'package:news/provider/app_theme_provider.dart';
import 'package:news/ui/home/home_screen.dart';
import 'package:news/utils/app_routes.dart';
import 'package:news/utils/app_theme.dart';
import 'package:news/utils/observeble_bloc.dart';

import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
final languageProvider = AppLanguageProvider();
await languageProvider.initialize();

final themeProvider = AppThemeProvider();
await themeProvider.initialize();

  Bloc.observer = MyBlocObserver();
    runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(   create:(context) => languageProvider,),
            ChangeNotifierProvider(create: (context) => themeProvider,),
      ],
      child: MyApp(),
      )
    );
}


class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    var appLanguageProvider = Provider.of<AppLanguageProvider>(context);

    var appThemeProvider = Provider.of<AppThemeProvider>(context);


    return MaterialApp(
      localizationsDelegates: AppLocalizations
          .localizationsDelegates,
      supportedLocales: AppLocalizations
          .supportedLocales,
      locale: Locale(
        appLanguageProvider.appLanguage,
      ),
      debugShowCheckedModeBanner:
      false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: appThemeProvider.appTheme,

      initialRoute: AppRoutes.homeRouteName,
      routes: {AppRoutes.homeRouteName: (context) => HomeScreen()},
    );
  }
}