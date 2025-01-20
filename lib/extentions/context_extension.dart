import 'package:flutter_design_system/languages/string_key.dart';
import 'package:flutter/material.dart';

// context extension
// how to use
// context.isBrightness
// ex) context.isBrightness? return const Placeholder() : return const Placeholder();
extension BuildContextExtensions on BuildContext {
  bool get isBrightness {
    Brightness brightnessValue = Theme.of(this).brightness;

    return brightnessValue == Brightness.light;
  }

  // 언어
  LocaleString get localeString => LocaleString.of(this);
}
