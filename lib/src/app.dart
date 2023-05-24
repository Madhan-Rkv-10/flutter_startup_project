import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:startup_flutter_page_view/src/providers/app_providers.dart';

import '../src/localization/app_locallization.dart';
import 'package:flutter/material.dart';
import 'localization/languages.dart';
import 'routing/routes.dart' as routes;
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatefulHookConsumerWidget {
  const App({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    final appTheme = ref.watch(appThemeProvider);
    final Brightness systemBrightness =
        MediaQuery.of(context).platformBrightness;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: Languages.languages.map((e) => Locale(e.code)).toList(),
      localizationsDelegates: const [
        //Custom App delegates
        AppLocalizations.delegate,
        // material delegates
        GlobalMaterialLocalizations.delegate,
        // Any type of Widget in Locale
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale!.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          },
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      builder: (_, child) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: child,
        );
      },
      onGenerateRoute: routes.onGenerateRoute,
    );
  }
}
