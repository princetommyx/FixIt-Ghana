import 'package:flutter/widgets.dart';

/// Corner radii: spec calls for 10–16px across cards, sheets and buttons.
abstract final class AppRadii {
  static const double sm = 10;
  static const double md = 12;
  static const double lg = 16;

  static BorderRadius get smRadius => BorderRadius.circular(sm);
  static BorderRadius get mdRadius => BorderRadius.circular(md);
  static BorderRadius get lgRadius => BorderRadius.circular(lg);
}
