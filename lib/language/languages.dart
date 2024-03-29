class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  Language(this.id, this.flag, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      // Language(1, "🇦🇫", "فارسی", "fa"),
      Language(1, "🇺🇸", "English", "en"),
      // Language(3, "🇸🇦", "اَلْعَرَبِيَّةُ", "ar"),
      Language(2, "🇪🇸", "Español", "es")
      // Language(2, "🇪🇸", "Español", "es")
    ];
  }
}
