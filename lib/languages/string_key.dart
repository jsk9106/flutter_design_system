// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';

enum LanguageCode {
  ko,
  en,
}

class LocaleString {
  static final LocaleString _instance = LocaleString._();

  factory LocaleString() => _instance;

  LocaleString._();

  static LanguageCode _languageCode = LanguageCode.ko;

  static LanguageCode get languageCode => _languageCode;

  static LocaleString of(BuildContext context) {
    try {
      _languageCode = LanguageCode.values.singleWhere(
        (e) => e.name == Localizations.localeOf(context).languageCode,
        orElse: () => LanguageCode.ko,
      );
    } catch (e) {
      _languageCode = LanguageCode.ko;
    }

    return _instance;
  }

  String get c_ui_public_yyyy_mm => StringKey.c_ui_public_yyyy_mm.value;
  String get c_ui_public_yyyy => StringKey.c_ui_public_yyyy.value;
  String get c_ui_public_mm => StringKey.c_ui_public_mm.value;
  String get c_ui_public_bt_confirm => StringKey.c_ui_public_bt_confirm.value;
  String get c_ui_public_data_picker_title => StringKey.c_ui_public_data_picker_title.value;
  String get c_ui_public_time_select => StringKey.c_ui_public_time_select.value;
  String get t_ui_public_am => StringKey.t_ui_public_am.value;
  String get t_ui_public_pm => StringKey.t_ui_public_pm.value;
  String get t_ui_public_bt_cancel => StringKey.t_ui_public_bt_cancel.value;
}

enum StringKey {
  c_ui_public_yyyy_mm,
  c_ui_public_yyyy,
  c_ui_public_mm,
  c_ui_public_bt_confirm,
  c_ui_public_data_picker_title,
  c_ui_public_time_select,
  t_ui_public_am,
  t_ui_public_pm,
  t_ui_public_bt_cancel,
  ;
}

extension StringKeyExtension on StringKey {
  static const _translations = {
    StringKey.c_ui_public_yyyy_mm: {
      LanguageCode.ko: '{0}년 {1}월',
      LanguageCode.en: '',
    },
    StringKey.c_ui_public_yyyy: {
      LanguageCode.ko: '{0}년',
      LanguageCode.en: '',
    },
    StringKey.c_ui_public_mm: {
      LanguageCode.ko: '{0}월',
      LanguageCode.en: '',
    },
    StringKey.c_ui_public_bt_confirm: {
      LanguageCode.ko: '확인',
      LanguageCode.en: '',
    },
    StringKey.c_ui_public_data_picker_title: {
      LanguageCode.ko: '월 선택',
      LanguageCode.en: '',
    },
    StringKey.c_ui_public_time_select: {
      LanguageCode.ko: '시간 선택',
      LanguageCode.en: '',
    },
    StringKey.t_ui_public_am: {
      LanguageCode.ko: '오전',
      LanguageCode.en: '',
    },
    StringKey.t_ui_public_pm: {
      LanguageCode.ko: '오후',
      LanguageCode.en: '',
    },
    StringKey.t_ui_public_bt_cancel: {
      LanguageCode.ko: '취소',
      LanguageCode.en: '',
    },
  };

  String get value => _translations[this]?[LocaleString.languageCode] ?? '';
}
