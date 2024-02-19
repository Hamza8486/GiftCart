import 'dart:core';

import 'package:get/get.dart';
import 'package:mr_bet/util/locales/en.dart';
import 'package:mr_bet/util/locales/es.dart';
import 'package:mr_bet/util/locales/fr.dart';
import 'package:mr_bet/util/locales/it.dart';
import 'package:mr_bet/util/locales/nl.dart';
import 'package:mr_bet/util/locales/pa.dart';
import 'package:mr_bet/util/locales/tl.dart';
import 'package:mr_bet/util/locales/zh.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enMap,
        'es_SP': esMap,
        'fr_FR': frMap,
        'it_IT': itMap,
        'nl_NL': nlMap,
        'pa_PA': paMap,
        'tl_TL': tlMap,
        'zh_ZH': zhMap,
      };
}
