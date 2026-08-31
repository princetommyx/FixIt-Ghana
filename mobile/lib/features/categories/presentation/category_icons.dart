import 'package:flutter/material.dart';

IconData categoryIconFor(String? icon) {
  switch (icon) {
    case 'plumbing':
      return Icons.plumbing_rounded;
    case 'electrical':
      return Icons.electrical_services_rounded;
    case 'ac_repair':
      return Icons.ac_unit_rounded;
    case 'cleaning':
      return Icons.cleaning_services_rounded;
    case 'carpentry':
      return Icons.carpenter_rounded;
    case 'painting':
      return Icons.format_paint_rounded;
    case 'appliance_repair':
      return Icons.kitchen_rounded;
    case 'moving':
      return Icons.local_shipping_rounded;
    default:
      return Icons.build_rounded;
  }
}
