class NameInternational {
  String? ar;
  String? cs;
  String? de;
  String? en;
  String? es;
  String? fa;
  String? fr;
  String? he;
  String? hi;
  String? hy;
  String? ml;
  String? uk;
  String? ur;
  String? hr;
  String? zh;

  NameInternational({
    this.ar,
    this.cs,
    this.de,
    this.en,
    this.es,
    this.fa,
    this.fr,
    this.he,
    this.hi,
    this.hy,
    this.ml,
    this.uk,
    this.ur,
    this.hr,
    this.zh,
  });

  factory NameInternational.fromJson(Map<String, dynamic> json) {
    return NameInternational(
      ar: json['ar'] as String?,
      cs: json['cs'] as String?,
      de: json['de'] as String?,
      en: json['en'] as String?,
      es: json['es'] as String?,
      fa: json['fa'] as String?,
      fr: json['fr'] as String?,
      he: json['he'] as String?,
      hi: json['hi'] as String?,
      hy: json['hy'] as String?,
      ml: json['ml'] as String?,
      uk: json['uk'] as String?,
      ur: json['ur'] as String?,
      hr: json['hr'] as String?,
      zh: json['zh'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'ar': ar,
    'cs': cs,
    'de': de,
    'en': en,
    'es': es,
    'fa': fa,
    'fr': fr,
    'he': he,
    'hi': hi,
    'hy': hy,
    'ml': ml,
    'uk': uk,
    'ur': ur,
    'hr': hr,
    'zh': zh,
  };
}
