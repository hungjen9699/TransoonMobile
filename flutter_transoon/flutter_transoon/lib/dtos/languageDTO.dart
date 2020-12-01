class LanguageDTO {
  final int languageId;
  final String languageName;

  LanguageDTO._({this.languageId, this.languageName});
  factory LanguageDTO.fromJson(Map<String, dynamic> json) {
    return new LanguageDTO._(
      languageId: json['languageId'],
      languageName: json['languageName'],
    );
  }
}
