import 'package:common_loc_wt_floc/presentation/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'generated/l10n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: _locale,
      title: Intl.message(LocaleKeys.materialApptitle),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: MyHomePage(title: Intl.message(LocaleKeys.homeTitle), setLocale: setLocale,),
      // 위 방식처럼 상위 위젯에서 번역값을 가져올 경우 갱신이 약간 늦습니다: 빠른 해결법으로 키 만을 넘겨주었습니다
      home: MyHomePage(
        title: LocaleKeys.homeTitle,
        setLocale: setLocale,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.setLocale});

  final String title;
  final Function setLocale;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // title: Text(widget.title),
        // 위 방식처럼 상위 위젯에서 번역값을 가져올 경우 갱신이 약간 늦습니다: 빠른 해결법으로 키를 넘겨받아 해결하였습니다
        title: Text(Intl.message(widget.title)),
        // title: Text(S.of(context).home_title), // 동일하게 작동
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              Intl.message(LocaleKeys.textTimes),
            ),
            // 동일하게 작동
            Text(
              S.of(context).text_times,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            OutlinedButton(
                onPressed: () {
                  widget.setLocale(const Locale.fromSubtags(languageCode: "ko"));
                },
                child: const Text("한국어 전환")),
            OutlinedButton(
                onPressed: () {
                  widget.setLocale(const Locale.fromSubtags(languageCode: "en"));
                },
                child: const Text("Change to English")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        // tooltip: S.of(context).tooltip_add,
        tooltip: Intl.message(LocaleKeys.tooltipAdd),
        child: const Icon(Icons.add),
      ),
    );
  }
}
