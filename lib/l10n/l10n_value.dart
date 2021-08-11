class L10nValue<TValue> {
  TValue en;
  TValue zh;

  L10nValue({required this.en, required this.zh});

  val() {
    return en;
  }
}

// class L10nString extends L10nValue<String> {
//   L10nString({String en, String zh}) : super(en: en, zh: zh);
// }
