// import 'dart:convert';

// // import 'package:bizhub_new/language/language_constant.dart';
// import 'package:bizhub_new/main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MultiLanguages {
//   final Locale locale;
//   MultiLanguages({this.locale = const Locale.fromSubtags(languageCode: 'en')});

//   static MultiLanguages? of(BuildContext context) {
//     return Localizations.of<MultiLanguages>(context, MultiLanguages);
//   }

//   // store
//   void keepLoacleKey(String localKey) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('localeKey');
//     await prefs.setString('localeKey', localKey);
//   }

//   // read
//   Future<String> readLocaleKey() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('localeKey') ?? 'es';
//   }

//   void setLocale(BuildContext context, Locale locale) async {
//     keepLoacleKey(locale.languageCode);

//     print('key language: ${locale.languageCode}');
//     MyApp.setLocale(context: context, newLocale: locale);
//   }

//   static const LocalizationsDelegate<MultiLanguages> delegate =
//       _MultiLanguagesDelegate();

//   late Map<String, String> _locaizedStrings;

//   Future<bool> load() async {
//     String jsonString = await rootBundle
//         .loadString('assets/language/${locale.languageCode}.json');
//     Map<String, dynamic> jsonMap = json.decode(jsonString);

//     _locaizedStrings = jsonMap.map((key, value) {
//       return MapEntry(key, value.toString());
//     });
//     return true;
//   }

//   String? translate(String key) {
//     return _locaizedStrings[key];
//   }
// }

// class _MultiLanguagesDelegate extends LocalizationsDelegate<MultiLanguages> {
//   // This delegate instance will never change
//   // It can provide a constant constructor.
//   const _MultiLanguagesDelegate();
//   @override
//   bool isSupported(Locale locale) {
//     // Include all of your supported language codes here
//     return ['en', 'es'].contains(locale.languageCode);
//   }

//   /// read Json
//   @override
//   Future<MultiLanguages> load(Locale locale) async {
//     // MultiLanguages class is where the JSON loading actually runs

//     MultiLanguages localizations = MultiLanguages(locale: locale);
//     await localizations.load();
//     return localizations;
//   }

//   @override
//   bool shouldReload(_MultiLanguagesDelegate old) => false;
// }
