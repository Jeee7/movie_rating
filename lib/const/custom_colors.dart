import 'package:flutter/material.dart';

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  final Color background;
  final Color grayLine;
  final Color chatBox;
  final Color whiteBar;
  final Color colorIc;
  final Color silverBg;
  final Color colorBoxHistory;
  final Color fontColorGlobal;

  const CustomColors({
    required this.background,
    required this.grayLine,
    required this.chatBox,
    required this.whiteBar,
    required this.colorIc,
    required this.silverBg,
    required this.colorBoxHistory,
    required this.fontColorGlobal,
  });

  @override
  CustomColors copyWith({
    Color? background,
    Color? grayLine,
    Color? chatBox,
    Color? whiteBar,
    Color? colorIc,
    Color? silverBg,
    Color? colorBoxHistory,
    Color? fontColorGlobal,
  }) {
    return CustomColors(
      background: background ?? this.background,
      grayLine: grayLine ?? this.grayLine,
      chatBox: chatBox ?? this.chatBox,
      whiteBar: whiteBar ?? this.whiteBar,
      colorIc: colorIc ?? this.colorIc,
      silverBg: silverBg ?? this.silverBg,
      colorBoxHistory: colorBoxHistory ?? this.colorBoxHistory,
      fontColorGlobal: fontColorGlobal ?? this.fontColorGlobal,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) return this;
    return CustomColors(
      background: Color.lerp(background, other.background, t)!,
      grayLine: Color.lerp(grayLine, other.grayLine, t)!,
      chatBox: Color.lerp(chatBox, other.chatBox, t)!,
      whiteBar: Color.lerp(whiteBar, other.whiteBar, t)!,
      colorIc: Color.lerp(colorIc, other.colorIc, t)!,
      silverBg: Color.lerp(silverBg, other.silverBg, t)!,
      colorBoxHistory: Color.lerp(colorBoxHistory, other.colorBoxHistory, t)!,
      fontColorGlobal: Color.lerp(fontColorGlobal, other.fontColorGlobal, t)!,
    );
  }
}
