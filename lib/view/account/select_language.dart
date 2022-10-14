import 'package:bizhub_new/language/language_constant.dart';
import 'package:bizhub_new/main.dart';
import 'package:bizhub_new/language/languages.dart';
import 'package:flutter/material.dart';

class SelectLanguage extends StatelessWidget {
  const SelectLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(translation(context).helloWorld),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton(
                icon: const Icon(
                  Icons.language,
                  color: Colors.black,
                ),
                onChanged: (Language? language) async {
                  if (language != null) {
                    Locale locale = await setLocale(language.languageCode);
                    MyApp.setLocale(context: context, newLocale: locale);
                  }
                },
                items: Language.languageList()
                    .map<DropdownMenuItem<Language>>(
                      (e) => DropdownMenuItem<Language>(
                        value: e,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(e.flag),
                            Text(
                              e.name,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
