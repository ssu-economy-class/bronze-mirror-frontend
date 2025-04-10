import 'package:flutter/material.dart';
import 'package:pie_menu/pie_menu.dart';
import '../../common/style/design_system.dart';

PieAction customPieAction({required Icon icon, VoidCallback? onPressed}) {
  return PieAction(
    onSelect: onPressed ?? () => print(''),
    buttonTheme: const PieButtonTheme(
      backgroundColor: PRIMARY_400,
      iconColor: Colors.white,
    ),
    buttonThemeHovered: const PieButtonTheme(
      backgroundColor: PRIMARY_100,
      iconColor: Colors.white,
    ),
    child: icon,
    tooltip: SizedBox(),
  );
}
