import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {},
        'es_ES': {},
      };

  static Future<Map<String, Map<String, String>>> loadTranslations() async {
    final Map<String, Map<String, String>> translations = {};

    // Load English
    final enString = await rootBundle.loadString('assets/locales/en.json');
    final enMap = json.decode(enString) as Map<String, dynamic>;
    translations['en_US'] = enMap.map((key, value) => MapEntry(key, value.toString()));

    // Load Spanish
    final esString = await rootBundle.loadString('assets/locales/es.json');
    final esMap = json.decode(esString) as Map<String, dynamic>;
    translations['es_ES'] = esMap.map((key, value) => MapEntry(key, value.toString()));

    return translations;
  }
}
