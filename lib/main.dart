import 'package:flutter/material.dart';
import 'package:flutter_languages/kvp.dart';
// #docregion app-localizations-import
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// #enddocregion app-localizations-import

// #docregion localization-delegates-import
import 'package:flutter_localizations/flutter_localizations.dart';
// #enddocregion localization-delegates-import

//based on:
//https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // #docregion material-app
    return const MaterialApp(
      title: 'Localizations Sample App',
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('es'), // Spanish
      ],
      home: MyHomePage(),
    );
    // #enddocregion material-app
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const List<Kvp> languages = <Kvp>[
    Kvp(name: 'English', id: 'en'),
    Kvp(name: 'Espanol', id: 'es'),
    Kvp(name: 'Arabic', id: 'ar'),
  ];
  Kvp dropdownValue = languages.first;

  Widget languageButton() {
    return DropdownButton(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        style: const TextStyle(color: Colors.deepOrange),
        underline: Container(
          height: 2,
          color: Colors.deepOrangeAccent,
        ),
        items: languages.map<DropdownMenuItem<Kvp>>((Kvp value) {
          return DropdownMenuItem<Kvp>(
            value: value,
            child: Text(value.name),
          );
        }).toList(),
        onChanged: (Kvp? value) {
          setState(() {
            dropdownValue = value!;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return // Add the following code
        Localizations.override(
      context: context,
      locale: Locale(dropdownValue.id),
      // Using a Builder here to get the correct BuildContext.
      // Alternatively, you can create a new widget and Localizations.override
      // will pass the updated BuildContext to the new widget.
      child: Builder(
        builder: (context) {
          // #docregion placeholder
          // Examples of internationalized strings.
          return Scaffold(
            // #docregion internationalized-title
            appBar: AppBar(
              //If this is outside the localization override, the title will not change
              // The [AppBar] title text should update its message
              // according to the system locale of the target platform.
              // Switching between English and Spanish locales should
              // cause this text to update.
              title: Text(t!.helloWorldOn(DateTime.now())),
            ),
            // #enddocregion internationalized-title
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      languageButton(),
                      const SizedBox(height: 40),
                      Text(t!.hello('John')),
                      Text(t!.nWombats(0)),
                      Text(t!.nWombats(1)),
                      Text(t!.nWombats(5)),
                      Text(t!.pronoun('male')),
                      Text(t!.pronoun('female')),
                      Text(t!.pronoun('other')),
                      Text(t!.currentPrice(5)),
                    ],
                  )
                  // #enddocregion placeholder
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
