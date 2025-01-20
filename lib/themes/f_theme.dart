import 'package:flutter_design_system/extentions/context_extension.dart';
import 'package:flutter_design_system/themes/f_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 사용 예제 코드
// return MaterialApp.router(
//   debugShowCheckedModeBanner: false,
//   routerConfig: AppRouter().router,
//   themeMode: FTheme.lightMode,
//   theme: FTheme.light,
//   darkTheme: FTheme.dark,
// );

// FTheme.lightMode, FTheme.darkMode의 상태관리 필요
// light theme, dark theme 구분해서 각각 필요한 요소들 추가 가능
class FTheme {
  static String get defaultFontFamily => 'Pretendard';

  static TextTheme get lightTextTheme => ThemeData.light().textTheme.apply(
        fontFamily: defaultFontFamily,
      );

  static TextTheme get darkTextTheme => ThemeData.dark().textTheme.apply(
        fontFamily: defaultFontFamily,
      );

  static ThemeData light(context) => ThemeData.light().copyWith(
        textTheme: lightTextTheme,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark, // Light Mode에서 상태 표시줄 아이콘을 어둡게
        ),
        scaffoldBackgroundColor: FColors.of(context).lightNormalN,
      );

  static ThemeData dark(context) => ThemeData.dark().copyWith(
        textTheme: darkTextTheme,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light, // Dark Mode에서 상태 표시줄 아이콘을 밝게
        ),
        scaffoldBackgroundColor: FColors.of(context).darkNormalN,
      );

  static bool isLightMode(BuildContext context) {
    return context.isBrightness;
  }
}
