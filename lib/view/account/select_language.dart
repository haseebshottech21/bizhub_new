import 'package:bizhub_new/language/language_constant.dart';
import 'package:bizhub_new/main.dart';
import 'package:bizhub_new/language/languages.dart';
import 'package:flutter/material.dart';
import '../../widgets/common/app_bar.dart';

class SelectLanguage extends StatelessWidget {
  const SelectLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: mainAppBar(
        context: context,
        appBarTitle: translation(context).selectLanguage,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                translation(context).selectLanguage,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // Text(translation(context).helloWorld),
              const SizedBox(height: 20),
              DropdownButton(
                underline: const SizedBox(),
                isExpanded: true,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
                hint: Text(
                  translation(context).language,
                  style: const TextStyle(fontSize: 16),
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
                        alignment: Alignment.center,
                        value: e,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              e.flag,
                              style: const TextStyle(fontSize: 26),
                            ),
                            const SizedBox(width: 20),
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
            ],
          ),
        ),
      ),
    );
  }
}
