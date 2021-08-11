import 'l10n/l10n_value.dart';

class Assets {
  static String path = "assets";
  static String svgPath = '${Assets.path}/svg';

  static String scanIcon = '${Assets.svgPath}/scan_icon.svg';
  static L10nValue<String> scanLabel = L10nValue<String>(
      en: '${Assets.svgPath}/scan_label_en.svg',
      zh: '${Assets.svgPath}/scan_label_zh.svg');
  static String filterIcon = '${Assets.svgPath}/filter_icon.svg';
}
